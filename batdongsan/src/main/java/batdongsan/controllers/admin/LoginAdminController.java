package batdongsan.controllers.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/admin/")
public class LoginAdminController {
	@RequestMapping("login")
	public String index(ModelMap model) {
		return "admin/loginAdmin";
	}
}
