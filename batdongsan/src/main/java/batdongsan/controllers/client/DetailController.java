package batdongsan.controllers.client;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import batdongsan.models.CategoryModel;
import batdongsan.models.HCMRealEstateModel;
import batdongsan.models.UsersModel;

@Controller
public class DetailController {
	@Autowired
	SessionFactory factory;
	
    @RequestMapping(value= {"/chi-tiet"}, method = RequestMethod.GET)
    public String index(HttpServletRequest request, @RequestParam("realEstateId") int realEstateId) {
    	Session session = factory.openSession();
		try {
			String hql = "FROM HCMRealEstateModel WHERE realEstateId = :realEstateId";
			Query<HCMRealEstateModel> query = session.createQuery(hql);
			query.setParameter("realEstateId", realEstateId);
			HCMRealEstateModel realEsate = query.getSingleResult();
			
			request.setAttribute("realEstate", realEsate);
			
			String hql1 = "SELECT re FROM HCMRealEstateModel re JOIN re.category cat WHERE re.status = :status AND cat.type LIKE :type";
	        
			Query<HCMRealEstateModel> query1 = session.createQuery(hql1);
			
			query1.setParameter("type", realEsate.getCategory().getType());
			query1.setParameter("status", "Đang hiển thị");
			
	        List<HCMRealEstateModel> realEstates = query1.list();

	        request.setAttribute("realEstates", realEstates);
	        request.setAttribute("page", "sell");
	        
	        request.setAttribute("amountRealEstate", realEstates.size());
	        
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
				String hqlUser = "FROM UsersModel WHERE userId = :userId";
				Query<UsersModel> queryUser = session.createQuery(hqlUser);
				queryUser.setParameter("userId", Integer.parseInt(userId));
				UsersModel user = queryUser.uniqueResult();
				request.setAttribute("user", user);
			} else {
				UsersModel user = null;
				request.setAttribute("user", user);
			}
			
			return "client/detail";
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
