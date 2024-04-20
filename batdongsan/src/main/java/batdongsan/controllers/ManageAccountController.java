package batdongsan.controllers;

import java.nio.charset.StandardCharsets;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import batdongsan.models.CategoryModel;
import batdongsan.models.DistrictsModel;
import batdongsan.models.ProvincesModel;
import batdongsan.models.RealEstateModel;
import batdongsan.models.WardsModel;

@Controller
@RequestMapping("/sellernet/")
public class ManageAccountController {
	@RequestMapping(value= {"thong-tin-ca-nhan"}, method = RequestMethod.GET)
    public String getManageAccountPage(HttpServletRequest request, 
    		@RequestParam(name = "edit", required = false) String edit,
	        @RequestParam(name = "setting", required = false) String setting
    		) {
		if(edit != null) {
	        request.setAttribute("edit", edit);
		}
		if(setting != null) {
	        request.setAttribute("setting", setting);
		}
    	return "client/sellernet/manageAccount";
    }
}
