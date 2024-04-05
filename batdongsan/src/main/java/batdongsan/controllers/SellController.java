package batdongsan.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import batdongsan.models.RealEstateModel;

@Controller
public class SellController {
	@Autowired
	SessionFactory factory;
	
    @RequestMapping(value= {"/nha-dat-ban"}, method = RequestMethod.GET)
    public String index(HttpServletRequest request) {
    	Session session = factory.openSession();
		try {
			String hql = "FROM RealEstateModel";
			Query<RealEstateModel> query = session.createQuery(hql);
			List<RealEstateModel> listRealEsate = query.list();
			
			request.setAttribute("realEstates", listRealEsate);
        return "client/sell";
		} finally {
			session.close();
		}
    }
}
