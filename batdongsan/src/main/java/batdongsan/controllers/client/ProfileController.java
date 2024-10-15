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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import batdongsan.models.CategoryModel;
import batdongsan.models.HCMRealEstateModel;
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

	        String hqlSell = "SELECT re FROM HCMRealEstateModel re JOIN re.category cat JOIN re.user AS user WHERE re.status = :status AND user.userId = :userId AND cat.type LIKE :type";
	        Query<HCMRealEstateModel> querySell = session.createQuery(hqlSell);
	        querySell.setParameter("userId", userId);
	        querySell.setParameter("type", "Nhà đất bán");
	        querySell.setParameter("status", "Đang hiển thị");
	        List<HCMRealEstateModel> sellRealEstates = querySell.list();
	        request.setAttribute("sellRealEstates", sellRealEstates);

	        String hqlRent = "SELECT re FROM HCMRealEstateModel re JOIN re.category cat JOIN re.user AS user WHERE re.status = :status AND user.userId = :userId AND cat.type LIKE :type";
	        Query<HCMRealEstateModel> queryRent = session.createQuery(hqlRent);
	        queryRent.setParameter("userId", userId);
	        queryRent.setParameter("type", "Nhà đất cho thuê");
	        queryRent.setParameter("status", "Đang hiển thị");
	        List<HCMRealEstateModel> rentRealEstates = queryRent.list();
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

	        if (currentUserId != null) {
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
