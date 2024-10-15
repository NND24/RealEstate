package batdongsan.controllers.client;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

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

import batdongsan.models.CategoryModel;
import batdongsan.models.UsersModel;

@Controller
@RequestMapping("/sellernet/")
public class RechargeController {
	@Autowired
	SessionFactory factory;

	@RequestMapping(value = { "nap-tien" }, method = RequestMethod.GET)
	public String getRechargePage(ModelMap model, HttpServletRequest request) {
		Session session = factory.openSession();
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

			request.setAttribute("user", user);
			return "client/sellernet/recharge";
		} finally {
			session.close();
		}
	}

	@RequestMapping(value = { "recharge" }, method = RequestMethod.POST)
	public String recharge(ModelMap model, HttpServletRequest request,
			@RequestParam("money") int money) {
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
			int updatedMoney = currentUser.getAccountBalance() + money;
			currentUser.setAccountBalance(updatedMoney);
			session.update(currentUser);
			t.commit();

			return "redirect:/sellernet/nap-tien.html";
		} catch (Exception e) {
			t.rollback();
			System.out.println(e);
			return "redirect:/sellernet/nap-tien.html";
		} finally {
			session.close();
		}
	}
	

	@ModelAttribute("categoriesSell")
	public List<CategoryModel> getTypesSell() {
		Session session = factory.openSession();
		try {
			String hql = "FROM CategoryModel WHERE type = :type AND status=0";
			Query<CategoryModel> query = session.createQuery(hql);
			query.setParameter("type", "Nhà đất bán");
			List<CategoryModel> categories = query.list();

			return categories;
		} catch (Exception e) {
			System.out.println(e);
			return null;
		} finally {
			session.close();
		}
	}
}
