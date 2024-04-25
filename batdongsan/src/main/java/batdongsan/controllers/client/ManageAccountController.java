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
			model.addAttribute("user", user);

			return "client/sellernet/manageAccount";
		} finally {
			session.close();
		}
	}

	@RequestMapping(value = { "updateAccount" }, method = RequestMethod.POST)
	public String updateAccount(ModelMap model, HttpServletRequest request, @ModelAttribute("user") UsersModel user,
			@RequestParam("userAvatar") MultipartFile userAvatar) {
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

				relativePath = "images/" + uniqueFileName;

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
	public String updatePassword(ModelMap model, HttpServletRequest request, @ModelAttribute("user") UsersModel user,
	        BindingResult errors, @RequestParam("password") String password, @RequestParam("newPassword") String newPassword,
	        @RequestParam("reNewPassword") String reNewPassword) {
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

			Boolean isError = false;

			if (!password.equals(currentUser.getPassword())) {
				request.setAttribute("passwordError", "Mật khẩu không khớp với mật khẩu cũ");
				isError = true;
			}
			if (!newPassword.equals(reNewPassword)) {
				isError = true;
			}

			if (!isError) {
				currentUser.setPassword(newPassword);
				session.update(currentUser);
				t.commit();
			} 
			
			request.setAttribute("user", currentUser);
			request.setAttribute("setting", "setting");
			request.setAttribute("edit", null);
			return "client/sellernet/manageAccount";
		} catch (Exception e) {
			t.rollback();
			System.out.println(e);
			return "client/sellernet/manageAccount";
		} finally {
			session.close();
		}
	}
}
