package batdongsan.controllers.client;

import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import batdongsan.models.UsersModel;
import batdongsan.utils.PasswordHashing;

@Controller
@Transactional
public class LoginController {
	@Autowired
	SessionFactory factory;

	String page;

	@RequestMapping(value = { "/dang-nhap" }, method = RequestMethod.GET)
	public String index(ModelMap model) {
		model.addAttribute("account", new UsersModel());
		return "client/login/login";
	}

	@RequestMapping(value = { "/dang-ky" }, method = RequestMethod.GET)
	public String getRegisterPage(HttpServletRequest request) {
		request.setAttribute("currentPage", "register");
		page = "register";
		return "client/login/register";
	}

	@RequestMapping(value = { "/khoi-phuc-mat-khau" }, method = RequestMethod.GET)
	public String getForgotPasswordPage(HttpServletRequest request) {
		request.setAttribute("currentPage", "forgotPassword");
		page = "forgotPassword";
		return "client/login/register";
	}

	@RequestMapping(value = { "/xac-nhan" }, method = RequestMethod.GET)
	public String getVerifyPage() {
		return "client/login/verify";
	}

	@RequestMapping(value = { "/tao-mat-khau" }, method = RequestMethod.GET)
	public String getCreatePasswordPage() {
		return "client/login/createPassword";
	}

	@RequestMapping(value = { "/doi-mat-khau-moi" }, method = RequestMethod.GET)
	public String getChangePasswordPage() {
		return "client/login/changePassword";
	}

	@Autowired
	JavaMailSender mailer;

	@RequestMapping("/mailer/send")
	public String send(ModelMap model, @RequestParam("to") String to, HttpServletRequest request) {
		try {
			String from = "BDS";
			MimeMessage mail = mailer.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(mail, true, "UTF-8");
			helper.setFrom(from, from);
			helper.setTo(to);
			helper.setReplyTo(from, from);
			helper.setSubject("Mã xác nhận tài khoản");

			int verifyCode = generateRandomNumber();
			helper.setText("Mã xác nhận: " + verifyCode, true);

			mailer.send(mail);

			HttpSession session = request.getSession();
			session.setAttribute("verifyCode", verifyCode);
			session.setAttribute("registerEmail", to);

			model.addAttribute("message", "Gửi email thành công!");
		} catch (Exception ex) {
			model.addAttribute("message", "Gửi email thất bại!");
		}
		return "redirect:/xac-nhan.html";
	}

	@RequestMapping("/mailer/checkAndSend")
	public String checkAndSend(ModelMap model, @RequestParam("to") String to, HttpServletRequest request) {
	    try (Session session = factory.openSession()) {
	        Transaction t = session.beginTransaction();
	        request.setAttribute("currentPage", "register");
	        String email = to;

	        if (email == null || email.isEmpty()) {
	        	 request.setAttribute("error", "Email không được bỏ trống!");
	                return "client/login/register";
	        }

	        try {
	            String hql = "FROM UsersModel WHERE email = :email";
	            Query<UsersModel> query = session.createQuery(hql);
	            query.setParameter("email", email);
	            UsersModel user = query.uniqueResult();

	            String from = "BDS";
	            MimeMessage mail = mailer.createMimeMessage();
	            MimeMessageHelper helper = new MimeMessageHelper(mail, true, "UTF-8");
	            helper.setFrom(from, from);
	            helper.setTo(to);
	            helper.setReplyTo(from, from);
	            helper.setSubject("Mã xác nhận tài khoản");

	            int verifyCode = generateRandomNumber();
	            helper.setText("Mã xác nhận: " + verifyCode, true);

	            mailer.send(mail);

	            HttpSession httpSession = request.getSession();
	            httpSession.setAttribute("verifyCode", verifyCode);
	            httpSession.setAttribute("registerEmail", to);

	            t.commit(); // Commit the transaction after successful email send
	            return "redirect:/xac-nhan.html";
	        } catch (Exception ex) {
	            t.rollback();
	            return "redirect:/dang-ky.html";
	        }
	    } catch (Exception e) {
	        model.addAttribute("message", "Đã xảy ra lỗi khi mở phiên làm việc!");
	        return "redirect:/dang-ky.html";
	    }
	}


	public static int generateRandomNumber() {
		Random rand = new Random();

		int min = 100000;
		int max = 999999;
		int randomNumber = rand.nextInt((max - min) + 1) + min;

		return randomNumber;
	}

	@RequestMapping("verify")
	public String verifyCode(ModelMap model, HttpServletRequest request, @RequestParam("code") Integer code) {
		HttpSession session = request.getSession();
		Integer verifyCode = (Integer) session.getAttribute("verifyCode");
		if (verifyCode != null && code.equals(verifyCode)) {
			model.addAttribute("verifyCode", verifyCode);
			if (page.equals("register")) {
				return "redirect:/tao-mat-khau.html";
			} else {
				return "redirect:/doi-mat-khau-moi.html";
			}
		} else {
			System.out.println("Không tìm thấy randomNumber trong session");
			return "redirect:/xac-nhan.html";
		}
	}

	@RequestMapping("createAccount")
	public String createAccount(ModelMap model, HttpServletRequest request, @RequestParam("password") String password,
			@RequestParam("rePassword") String rePassword) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();

		HttpSession httpSession = request.getSession();
		String registerEmail = (String) httpSession.getAttribute("registerEmail");

		if (registerEmail != null) {
			try {
				String randomUsername = "user" + generateRandomNumber();

				String hashPassword = PasswordHashing.hashPassword(password);
				UsersModel user = new UsersModel(randomUsername, registerEmail, hashPassword, "images/avatar-mac-dinh.jpg",
						"", "");

				session.save(user);
				t.commit();

				httpSession.removeAttribute("verifyCode");
				httpSession.removeAttribute("registerEmail");

				return "redirect:/dang-nhap.html";
			} catch (Exception e) {
				t.rollback();
				return "redirect:/tao-mat-khau.html";
			} finally {
				session.close();
			}
		} else {
			return "redirect:/tao-mat-khau.html";
		}
	}

	@RequestMapping("changePassword")
	public String changePassword(ModelMap model, HttpServletRequest request, @RequestParam("password") String password,
			@RequestParam("rePassword") String rePassword) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();

		HttpSession httpSession = request.getSession();
		String email = (String) httpSession.getAttribute("registerEmail");

		if (email != null) {
			try {
				String hql = "FROM UsersModel WHERE email = :email";
				Query<UsersModel> query = session.createQuery(hql);
				query.setParameter("email", email);
				UsersModel currentUser = query.uniqueResult();

				if (!password.equals(rePassword)) {
					return "redirect:/doi-mat-khau-moi.html";
				}

				String hashPassword = PasswordHashing.hashPassword(password);
				currentUser.setPassword(hashPassword);
				session.update(currentUser);
				t.commit();

				httpSession.removeAttribute("verifyCode");
				httpSession.removeAttribute("registerEmail");

				return "redirect:/dang-nhap.html";
			} catch (Exception e) {
				t.rollback();
				return "redirect:/doi-mat-khau-moi.html";
			} finally {
				session.close();
			}
		} else {
			return "redirect:/doi-mat-khau-moi.html";
		}
	}

	@RequestMapping("login")
	public String login(ModelMap model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("account") UsersModel account, BindingResult errors) {
		Session session = factory.openSession();
		try {
			String email = account.getEmail();
			String password = account.getPassword();

			if (email == null || email.trim().length() == 0) {
				errors.rejectValue("email", "account", "Vui lòng nhập email!");
			}
			if (password == null || password.trim().length() == 0) {
				errors.rejectValue("password", "account", "Vui lòng mật khẩu!");
			}

			if (errors.hasErrors()) {
				if (errors.hasFieldErrors("email")) {
					model.addAttribute("emailError", "Vui lòng nhập email!");
				}
				if (errors.hasFieldErrors("password")) {
					model.addAttribute("passwordError", "Vui lòng nhập mật khẩu!");
				}
				return "client/login/login";
			}

			String hql = "FROM UsersModel WHERE (email = :email OR phonenumber = :phonenumber)";
			Query<UsersModel> query = session.createQuery(hql);
			query.setParameter("email", email);
			query.setParameter("phonenumber", email);

			UsersModel user = query.uniqueResult();

			if (user != null) {				
				if (!PasswordHashing.checkPassword(password, user.getPassword())) {
					request.setAttribute("error", "Mật khẩu hoặc email không chính xác!");
					return "client/login/login";
				}
				Cookie userCookie = new Cookie("userId", String.valueOf(user.getUserId()));
				userCookie.setMaxAge(30 * 24 * 60 * 60);
				response.addCookie(userCookie);
			} else {
				request.setAttribute("error", "Tài khoản không tồn tại!");
				return "client/login/login";
			}
		} finally {
			session.close();
		}
		return "redirect:/trang-chu.html";
	}
	
	@ResponseBody
	@RequestMapping("logout")
	public String logout(HttpServletRequest request, HttpServletResponse response) {
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("userId")) {
					cookie.setMaxAge(0);
					response.addCookie(cookie);
					break;
				}
			}
		}

		return "redirect:/trang-chu.html";
	}

}
