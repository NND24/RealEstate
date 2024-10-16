package batdongsan.controllers.client;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import batdongsan.models.CategoryModel;
import batdongsan.models.HCMDistrictsModel;
import batdongsan.models.HCMRealEstateModel;
import batdongsan.models.UsersModel;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/du-doan-gia-nha")
public class PricePredictController {
	@Autowired
	SessionFactory factory;
	
    @GetMapping
    public String getHomePage(ModelMap model,HttpServletRequest request,
            @RequestParam(name = "categoryId", required = false) Integer categoryId) {
    	Session session = factory.openSession();
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

		String hqlCat = "FROM CategoryModel WHERE type = :type AND status=1";
		Query<CategoryModel> queryCat = session.createQuery(hqlCat);
		queryCat.setParameter("type", "Nhà đất bán");
		List<CategoryModel> categories = queryCat.list();

		String hqlDistrict = "FROM HCMDistrictsModel";
		Query<HCMDistrictsModel> queryDis = session.createQuery(hqlDistrict);
		List<HCMDistrictsModel> districts = queryDis.list();

		request.setAttribute("categories", categories);
		request.setAttribute("category", categoryId);
		request.setAttribute("districts", districts);
		request.setAttribute("user", user);
		model.addAttribute("realEstate", new HCMRealEstateModel());
		
		String hql1 = "SELECT re FROM HCMRealEstateModel re JOIN re.category cat WHERE re.status = :status";
        
		Query<HCMRealEstateModel> query1 = session.createQuery(hql1);
		
		query1.setParameter("status", "Đang hiển thị");
		
        List<HCMRealEstateModel> realEstates = query1.list();
        request.setAttribute("realEstates", realEstates);
        
        return "client/predict";
    }
}
