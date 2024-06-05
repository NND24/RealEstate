package batdongsan.controllers.admin;

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

import batdongsan.models.EmployeeModel;


@Controller
@Transactional
@RequestMapping("/admin/")
public class LoginAdminController {
	@Autowired
	SessionFactory factory;
	
	String page;
	
	@RequestMapping("login")
	public String index(ModelMap model) {
		model.addAttribute("account", new EmployeeModel());
		return "admin/loginAdmin/loginAdmin";
	}
	
	@RequestMapping("forgot-password")
	public String forgotPassword(ModelMap model) {
		model.addAttribute("account", new EmployeeModel());
		return "admin/loginAdmin/forgotPassword";
	}
	
	@RequestMapping(value = "sendVerifyCode", method = RequestMethod.POST)
	public String sendCode(ModelMap model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("account") EmployeeModel account, BindingResult errors) {
		Session session = factory.openSession();
		String email = account.getEmail();
		System.out.println(email);
		if(email == null || email.trim().length() == 0) {
		    errors.rejectValue("email", "account", "Vui lòng nhập email!");
		}
		try {
			String hql = "FROM EmployeeModel WHERE email = :email";
			Query<EmployeeModel> query = session.createQuery(hql);
			query.setParameter("email",  email);

			EmployeeModel emp = query.uniqueResult();

			if (emp != null) {
				Cookie empCookie = new Cookie("id", String.valueOf(emp.getId()));
				empCookie.setMaxAge(30 * 24 * 60 * 60);
				response.addCookie(empCookie);
				sendEmail(model, email, request);
			} else {
				if(!email.isEmpty()) {
					errors.rejectValue("email", "account", "Email không tồn tại trong hệ thống");
				}
				return "admin/loginAdmin/forgotPassword";
			}
		} finally {
			session.close();
		}
		return "admin/loginAdmin/verifyCodeConfirm";
	}
	
	@RequestMapping(value = "confirmVerifyCode",  method = RequestMethod.POST)
	public String verifyCode(ModelMap model, HttpServletRequest request,
			@RequestParam("verify-code-1") String  code1 ,
			@RequestParam("verify-code-2") String  code2 ,
			@RequestParam("verify-code-3") String  code3 ,
			@RequestParam("verify-code-4") String  code4 ,
			@RequestParam("verify-code-5") String  code5 ,
			@RequestParam("verify-code-6") String  code6) {
		String combinedCode = code1 + code2 + code3 + code4 + code5 + code6;
		int verificationCode = Integer.parseInt(combinedCode);
		HttpSession session = request.getSession();
		Integer verifyCode = (Integer) session.getAttribute("verifyCode");
		String wwEmail = (String) session.getAttribute("Email");
		System.out.println(wwEmail);
		if (combinedCode != null && verificationCode == verifyCode){
			model.addAttribute("verifyCode", verifyCode);
			return "admin/loginAdmin/createNewPassword";
		} else {
			if(!combinedCode.isEmpty()) {
				request.setAttribute("error", "Mã xác nhận không chính xác!");
			}		
			return "admin/loginAdmin/verifyCodeConfirm";
		}
	}
	
	@RequestMapping(value = "createNewPassword",  method = RequestMethod.POST)
	public String createPassword(ModelMap model, HttpServletRequest request,
			@RequestParam("password") String password ,
			@RequestParam("retypePassword") String  retypePassword) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		if(password.isEmpty()|| retypePassword.isEmpty()) {
			request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");
			return "admin/loginAdmin/createNewPassword";
		}
		if(!password.equals(retypePassword)) {
			request.setAttribute("error", "Mật khẩu nhập lại phải giống mật khẩu mới tạo!");
			return "admin/loginAdmin/createNewPassword";
		}
		HttpSession httpSession = request.getSession();
		String empEmail = (String) httpSession.getAttribute("Email");
		
		if(!empEmail.isEmpty()) {
			try {
	        	String hql = "FROM EmployeeModel WHERE email = :email";
	        	Query<EmployeeModel> query = session.createQuery(hql);
	        	query.setParameter("email", empEmail);
	        	EmployeeModel currentEmp = query.uniqueResult();
	            
	        	currentEmp.setPassword(password);
	            session.update(currentEmp);
	            t.commit();

	            httpSession.removeAttribute("verifyCode");
	            httpSession.removeAttribute("Email");
	            model.addAttribute("account", new EmployeeModel());
	            return "admin/loginAdmin/loginAdmin";
	        } catch (Exception e) {
	            t.rollback();
	            return "admin/loginAdmin/createNewPassword";
	        } finally {
	            session.close();
	        }
		} else {
			return "admin/loginAdmin/createNewPassword";
		}
	}
	
	
	@RequestMapping("loginInAdminPage")
	public String login(ModelMap model, HttpServletRequest request, HttpServletResponse response,
			@ModelAttribute("account") EmployeeModel account, BindingResult errors) {
		Session session = factory.openSession();
		String email = account.getEmail();
		String password = account.getPassword();
		if(email == null || email.trim().length() == 0) {
		    errors.rejectValue("email", "account", "Vui lòng nhập email!");
		}
		if(password == null || password.trim().length() == 0) {
		    errors.rejectValue("password", "account", "Vui lòng mật khẩu!");
		}
		try {
			String hql = "FROM EmployeeModel WHERE email = :email AND password = :password";
			Query<EmployeeModel> query = session.createQuery(hql);
			query.setParameter("email",  email);
			query.setParameter("password", password);

			EmployeeModel emp = query.uniqueResult();

			if (emp != null) {
				if (!emp.getPassword().equals(password)) {
	                request.setAttribute("error", "Mật khẩu hoặc email không chính xác!");
	                return "admin/loginAdmin/loginAdmin";
	            }
				Cookie empCookie = new Cookie("id", String.valueOf(emp.getId()));
				empCookie.setMaxAge(30 * 24 * 60 * 60);
				response.addCookie(empCookie);
			} else {
				if(!email.isEmpty()) {
					request.setAttribute("error", "Tài khoản không tồn tại!");
				}
				return "admin/loginAdmin/loginAdmin";
			}
		} finally {
			session.close();
		}
		return "redirect:/admin/listNews.html";
	}
	
	// ===========================
	@Autowired
	JavaMailSender mailer;
	
	private void sendEmail(ModelMap model, String email, HttpServletRequest request) {
		try {
			String from = "PTIT";
			MimeMessage mail = mailer.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(mail, true, "UTF-8");
			helper.setFrom(from, from);
			helper.setTo(email);
			helper.setReplyTo(from, from);
			helper.setSubject("Mã xác nhận tài khoản");

			int verifyCode = generateRandomNumber();
			helper.setText("Mã xác nhận: " + verifyCode, true);

			mailer.send(mail);
			HttpSession session = request.getSession();
			session.setAttribute("verifyCode", verifyCode);
			session.setAttribute("Email", email);

			model.addAttribute("message", "Gửi email thành công!");
			System.out.println(verifyCode);
		} catch (Exception ex) {
			String errorMessage = ex.getMessage();
		    System.out.println("Error message: " + errorMessage);
			model.addAttribute("message", "Gửi email thất bại!");
		}
	}
	
	public static int generateRandomNumber() {
		Random rand = new Random();

		int min = 100000;
		int max = 999999;
		int randomNumber = rand.nextInt((max - min) + 1) + min;

		return randomNumber;
	}
	
}
