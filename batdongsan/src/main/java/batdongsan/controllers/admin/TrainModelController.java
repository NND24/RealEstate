package batdongsan.controllers.admin;

import java.util.Collections;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import batdongsan.models.CategoryModel;
import batdongsan.models.EmployeeModel;
import batdongsan.utils.LoadAdminComponents;

@Controller
@RequestMapping("/admin/")
public class TrainModelController {
	@Autowired
	SessionFactory factory;

	@RequestMapping("AImodel")
	public String index(ModelMap model, HttpServletRequest request) {
		Session session = factory.openSession();
		try {
	        LoadAdminComponents.showOnSidebarAndHeader(model,request,session, factory);
	        return "admin/modelAI";
	    } finally {
	    	session.close();
	    }		
	}
	
}
