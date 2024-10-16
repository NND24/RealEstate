package batdongsan.controllers.client;

import java.io.File;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FilenameUtils;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import batdongsan.models.UsersModel;
import batdongsan.utils.PasswordHashing;
import batdongsan.utils.Vadilator;

@Controller
@RequestMapping("/sellernet/")
public class ManageAccountController {
	@Autowired
	SessionFactory factory;

	@RequestMapping(value = { "thong-tin-ca-nhan" }, method = RequestMethod.GET)
	public String getManageAccountPage(ModelMap model, HttpServletRequest request,
			@RequestParam(name = "edit", required = false) String edit,
			@RequestParam(name = "setting", required = false) String setting) {
		Session session = factory.openSession();
		try {
			if (edit != null) {
				request.setAttribute("edit", edit);
			}
			if (setting != null) {
				request.setAttribute("setting", setting);
			}

			Cookie[] cookies = request.getCookies();
			UsersModel user = null;

			if (cookies != null) {
				for (Cookie cookie : cookies) {
					if (cookie.getName().equals("userId")) {
						String userId = cookie.getValue();
						String hqlUser = "FROM UsersModel WHERE userId = :userId";
						Query<UsersModel> queryUser = session.createQuery(hqlUser);
						queryUser.setParameter("userId", Integer.parseInt(userId));
						user = queryUser.uniqueResult();
						break;
					}
				}
			}

			request.setAttribute("user", user);

			return "client/sellernet/manageAccount";
		} finally {
			session.close();
		}
	}

	@RequestMapping(value = { "updateAccount" }, method = RequestMethod.POST)
	public String updateAccount(ModelMap model, HttpServletRequest request, @ModelAttribute("user") UsersModel user,
			@RequestParam("userAvatar") MultipartFile userAvatar, BindingResult errors) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		String relativePath;
		try {
			Cookie[] cookies = request.getCookies();
			UsersModel currentUser = null;

			if (cookies != null) {
				for (Cookie cookie : cookies) {
					if (cookie.getName().equals("userId")) {
						String userId = cookie.getValue();
						String hqlUser = "FROM UsersModel WHERE userId = :userId";
						Query<UsersModel> queryUser = session.createQuery(hqlUser);
						queryUser.setParameter("userId", Integer.parseInt(userId));
						currentUser = queryUser.uniqueResult();
						break;
					}
				}
			}

			String name = user.getName();
			String taxCode = user.getTaxCode();
			String phonenumber = user.getPhonenumber();

			if (name == null || name.trim().length() == 0) {
				errors.rejectValue("name", "user", "Họ và tên không được để trống!");
			}

			if (phonenumber != null && !phonenumber.isEmpty()) {
				// Kiểm tra xem số điện thoại đã tồn tại chưa
				String hqlPhoneCheck = "FROM UsersModel WHERE phonenumber = :phonenumber AND userId != :userId";
				Query<UsersModel> queryPhoneCheck = session.createQuery(hqlPhoneCheck);
				queryPhoneCheck.setParameter("phonenumber", phonenumber);
				queryPhoneCheck.setParameter("userId", currentUser.getUserId());
				UsersModel existingUserWithPhone = queryPhoneCheck.uniqueResult();

				if (existingUserWithPhone != null) {
					errors.rejectValue("phonenumber", "user", "Số điện thoại đã tồn tại!");
				}
			}

			if (taxCode != null && !taxCode.isEmpty()) {
				String hqlTaxCodeCheck = "FROM UsersModel WHERE taxCode = :taxCode AND userId != :userId";
				Query<UsersModel> queryTaxCodeCheck = session.createQuery(hqlTaxCodeCheck);
				queryTaxCodeCheck.setParameter("taxCode", phonenumber);
				queryTaxCodeCheck.setParameter("userId", currentUser.getUserId());
				UsersModel existingUserWithTC = queryTaxCodeCheck.uniqueResult();

				if (existingUserWithTC != null) {
					errors.rejectValue("taxCode", "user", "Mã số thuế cá nhân đã tồn tại!");
				}
			}

			if (errors.hasErrors()) {
				if (errors.hasFieldErrors("name")) {
					model.addAttribute("nameError", "Họ và tên không được để trống!");
				}
				if (errors.hasFieldErrors("taxCode")) {
					model.addAttribute("taxCodeError", "Mã số thuế cá nhân đã tồn tại!");
				}

				if (!Vadilator.isValidPhoneNumber(phonenumber)) {
					model.addAttribute("phonenumberError", "Số điện thoại không đúng định dạng!");
				} else if (errors.hasFieldErrors("phonenumber")) {
					model.addAttribute("phonenumberError", "Số điện thoại đã tồn tại!");
				}

				request.setAttribute("edit", "true");
				model.addAttribute("user", currentUser);
				return "client/sellernet/manageAccount";
			}

			if (!userAvatar.isEmpty()) {
				String uploadDir = "D:/Workspace Java/DoAnLTW/batdongsan/src/main/webapp/images/";
				String fileExtension = FilenameUtils.getExtension(userAvatar.getOriginalFilename());
				String uniqueFileName = UUID.randomUUID().toString() + "." + fileExtension;
				String filePath = uploadDir + uniqueFileName;

				File directory = new File(uploadDir);
				if (!directory.exists()) {
					directory.mkdirs();
				}

				userAvatar.transferTo(new File(filePath));

				relativePath = uniqueFileName;
			} else {
				relativePath = currentUser.getAvatar();
			}

			currentUser.setName(user.getName());
			currentUser.setAvatar(relativePath);
			currentUser.setTaxCode(user.getTaxCode());
			currentUser.setPhonenumber(user.getPhonenumber());
			session.update(currentUser);
			t.commit();
			return "redirect:/sellernet/thong-tin-ca-nhan.html?edit=true";
		} catch (Exception e) {
			t.rollback();
			System.out.println(e);
			return "redirect:/sellernet/thong-tin-ca-nhan.html?edit=true";
		} finally {
			session.close();
		}
	}

	@RequestMapping(value = { "updatePassword" }, method = RequestMethod.POST)
	public String updatePassword(ModelMap model, HttpServletRequest request, @RequestParam("password") String password,
			@RequestParam("newPassword") String newPassword, @RequestParam("reNewPassword") String reNewPassword) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			Cookie[] cookies = request.getCookies();
			UsersModel user = null;

			if (cookies != null) {
				for (Cookie cookie : cookies) {
					if (cookie.getName().equals("userId")) {
						String userId = cookie.getValue();
						String hqlUser = "FROM UsersModel WHERE userId = :userId";
						Query<UsersModel> queryUser = session.createQuery(hqlUser);
						queryUser.setParameter("userId", Integer.parseInt(userId));
						user = queryUser.uniqueResult();
						break;
					}
				}
			}

			Boolean isError = false;

			if (!PasswordHashing.checkPassword(password, user.getPassword())) {
				request.setAttribute("passwordError", "Mật khẩu không khớp với mật khẩu cũ");
				isError = true;
			}
			if (!newPassword.equals(reNewPassword)) {
				isError = true;
			}

			request.setAttribute("user", user);
			request.setAttribute("setting", "setting");
			request.setAttribute("edit", null);

			if (!isError) {
				String hashPassword = PasswordHashing.hashPassword(newPassword);
				user.setPassword(hashPassword);
				session.update(user);
				t.commit();
				return "redirect:/sellernet/thong-tin-ca-nhan.html?setting=true";
			} else {
				return "client/sellernet/manageAccount";
			}
		} catch (Exception e) {
			t.rollback();
			System.out.println(e);
			return "redirect:/sellernet/thong-tin-ca-nhan.html?setting=true";
		} finally {
			session.close();
		}
	}
}
