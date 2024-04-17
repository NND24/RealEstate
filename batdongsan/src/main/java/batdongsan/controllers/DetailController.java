package batdongsan.controllers;

import java.util.List;

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
import batdongsan.models.RealEstateModel;

@Controller
public class DetailController {
	@Autowired
	SessionFactory factory;
	
    @RequestMapping(value= {"/chi-tiet"}, method = RequestMethod.GET)
    public String index(HttpServletRequest request, @RequestParam("realEstateId") int realEstateId) {
    	Session session = factory.openSession();
		try {
			String hql = "FROM RealEstateModel WHERE realEstateId = :realEstateId";
			Query<RealEstateModel> query = session.createQuery(hql);
			query.setParameter("realEstateId", realEstateId);
			RealEstateModel realEsate = query.getSingleResult();
			
			request.setAttribute("realEstate", realEsate);
        return "client/detail";
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
