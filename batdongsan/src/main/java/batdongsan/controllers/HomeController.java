package batdongsan.controllers;

import java.util.List;

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

@Controller
@RequestMapping("/")
public class HomeController {
	@Autowired
	SessionFactory factory;

	@RequestMapping(value= {"/", "/trang-chu"}, method = RequestMethod.GET)
	public String index(HttpServletRequest request) {
		Session session = factory.openSession();
		try {
			String hql = "FROM RealEstateModel";
			Query<RealEstateModel> query = session.createQuery(hql);
			List<RealEstateModel> listRealEsate = query.list();
			
			request.setAttribute("realEstates", listRealEsate);
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
