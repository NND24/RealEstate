package batdongsan.controllers;

import java.util.List;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import batdongsan.models.CategoryModel;
import batdongsan.models.FavouriteModel;
import batdongsan.models.ProvincesModel;
import batdongsan.models.RealEstateModel;
import batdongsan.models.UsersModel;

@Controller
@Transactional
public class AccountController {
	@Autowired
	SessionFactory factory;

	@RequestMapping(value = { "/dang-nhap" }, method = RequestMethod.GET)
	public String index() {
		return "client/login/login";
	}

	@RequestMapping(value = { "/dang-ky" }, method = RequestMethod.GET)
	public String getRegisterPage() {
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

	@Autowired
	JavaMailSender mailer;

	@RequestMapping("/mailer/send")
	public String send(ModelMap model, @RequestParam("to") String to, HttpServletRequest request) {
		try {
			String from = "PTIT";
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
			return "redirect:/tao-mat-khau.html";
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

				UsersModel user = new UsersModel(randomUsername, registerEmail, password, "images/avatar-mac-dinh.jpg",
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

	@RequestMapping("login")
	public String login(ModelMap model, HttpServletRequest request, HttpServletResponse response,
			@RequestParam("email") String email, @RequestParam("password") String password) {
		Session session = factory.openSession();
		try {
			String hql = "FROM UsersModel WHERE (email = :email OR phonenumber = :phonenumber) AND password = :password";
			Query<UsersModel> query = session.createQuery(hql);
			query.setParameter("email", email);
			query.setParameter("phonenumber", email);
			query.setParameter("password", password);

			UsersModel user = query.uniqueResult();

			if (user != null) {
				Cookie userCookie = new Cookie("userId", String.valueOf(user.getUserId()));

				userCookie.setMaxAge(30 * 24 * 60 * 60);
				response.addCookie(userCookie);
			} else {
				return "redirect:/dang-nhap.html?error=true";
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

		return "Thành công";
	}

	@ResponseBody
	@RequestMapping("favourite")
	public String favourite(HttpServletRequest request, HttpServletResponse response,
	        @RequestParam(name = "realEstateId") String realEstateId) {
	    try {
	        Cookie[] cookies = request.getCookies();
	        String userId = null;

	        if (cookies != null) {
	            for (Cookie cookie : cookies) {
	                if (cookie.getName().equals("userId")) {
	                    userId = cookie.getValue();
	                    break;
	                }
	            }
	        }

	        if (userId != null) {
	            Session session = factory.getCurrentSession();

	            UsersModel user = session.get(UsersModel.class, Integer.parseInt(userId));

	            RealEstateModel realEstate = session.get(RealEstateModel.class, Integer.parseInt(realEstateId));

	            if (user != null && realEstate != null) {
	                FavouriteModel favourite = new FavouriteModel(user, realEstate);

	                session.save(favourite);
	                return "Thành công"; // Or any other success indicator
	            } else {
	                System.out.println("User or real estate not found");
	                return "redirect:/tao-mat-khau.html"; // Redirect to error page or handle as appropriate
	            }
	        } else {
	            System.out.println("User ID not found in cookies");
	            return "redirect:/dang-nhap.html"; // Redirect to login page or handle as appropriate
	        }
	    } catch (Exception e) {
	        System.out.println("Exception occurred: " + e.getMessage());
	        return "redirect:/tao-mat-khau.html"; // Redirect to error page or handle as appropriate
	    }
	}

}
