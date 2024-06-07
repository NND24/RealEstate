package batdongsan.controllers.admin;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.hibernate.Session;
import org.hibernate.query.Query;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import batdongsan.models.NewsModel;

@Controller
@RequestMapping("/admin/")
public class DashboardController {
	
	@RequestMapping("dashboard")
	public String index(ModelMap model, HttpServletRequest request) {
	    return "admin/dashboard";
	}

}
