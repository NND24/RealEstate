package batdongsan.controllers.client;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.hibernate.query.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import batdongsan.models.CategoryModel;
import batdongsan.models.RealEstateModel;
import batdongsan.models.UsersModel;

@Controller
@RequestMapping("/")
public class HomeController {
	@Autowired
	SessionFactory factory;

	@RequestMapping(value = { "/", "/trang-chu" }, method = RequestMethod.GET)
	public String getHomePage(HttpServletRequest request) {
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

			String hql = "FROM RealEstateModel re WHERE re.status = :status ";

			if (user != null) {
				hql += " AND NOT EXISTS (SELECT 1 FROM FavouriteModel fa WHERE fa.realEstate = id AND fa.user = :user)";
			}
			Query<RealEstateModel> query = session.createQuery(hql);
			query.setParameter("status", "Đang hiển thị");
			if (user != null) {
				query.setParameter("user", user);
			}
			List<RealEstateModel> listRealEstate = query.list();

			request.setAttribute("realEstates", listRealEstate);
			request.setAttribute("user", user);

			return "client/home";
		} finally {
			session.close();
		}
	}

	@ModelAttribute("categoriesSell")
	public List<CategoryModel> getTypesSell() {
		Session session = factory.openSession();
		try {
			String hql = "FROM CategoryModel WHERE type = :type";
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

	@ModelAttribute("categoriesRent")
	public List<CategoryModel> getTypesRent() {
		Session session = factory.openSession();
		try {
			String hql = "FROM CategoryModel WHERE type = :type";
			Query<CategoryModel> query = session.createQuery(hql);
			query.setParameter("type", "Nhà đất cho thuê");
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
