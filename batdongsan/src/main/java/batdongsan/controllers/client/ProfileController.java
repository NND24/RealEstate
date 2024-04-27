package batdongsan.controllers.client;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import batdongsan.models.CategoryModel;
import batdongsan.models.RealEstateModel;
import batdongsan.models.UsersModel;

@Controller
@Transactional
public class ProfileController {
	@Autowired
	SessionFactory factory;

	@RequestMapping(value = { "/profile" }, method = RequestMethod.GET)
	public String getFavoutirePage(HttpServletRequest request,
			@RequestParam(name = "userId") Integer userId) {
		Session session = factory.openSession();
		try {
			Session currentSession = factory.getCurrentSession();
			UsersModel userInfo = currentSession.find(UsersModel.class, userId);
			request.setAttribute("userInfo", userInfo);
			
			String hqlSell = "SELECT re FROM RealEstateModel re JOIN re.category cat JOIN re.user AS user WHERE user.userId = :userId AND cat.type LIKE :type";
			Query<RealEstateModel> querySell = session.createQuery(hqlSell);
			querySell.setParameter("userId", userId);
			querySell.setParameter("type", "Nhà đất bán");
			List<RealEstateModel> sellRealEstates = querySell.list();
			request.setAttribute("sellRealEstates", sellRealEstates);
			
			String hqlRent = "SELECT re FROM RealEstateModel re JOIN re.category cat JOIN re.user AS user WHERE user.userId = :userId AND cat.type LIKE :type";
			Query<RealEstateModel> queryRent = session.createQuery(hqlRent);
			queryRent.setParameter("userId", userId);
			queryRent.setParameter("type", "Nhà đất cho thuê");
			List<RealEstateModel> rentRealEstates = queryRent.list();
			request.setAttribute("rentRealEstates", rentRealEstates);
			
			Cookie[] cookies = request.getCookies();
			String currentUserId = null;

			if (cookies != null) {
				for (Cookie cookie : cookies) {
					if (cookie.getName().equals("userId")) {
						currentUserId = cookie.getValue();
						break;
					}
				}
			}

			if (userId != null) {
				String hqlUser = "FROM UsersModel WHERE userId = :userId";
				Query<UsersModel> queryUser = session.createQuery(hqlUser);
				queryUser.setParameter("userId", Integer.parseInt(currentUserId));
				UsersModel user = queryUser.uniqueResult();
				request.setAttribute("user", user);
			} else {
				UsersModel user = null;
				request.setAttribute("user", user);
			}

			return "client/profile";
		} finally {
			session.close();
		}
	}
}
