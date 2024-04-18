package batdongsan.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/sellernet/")
public class ListPostController {
    @RequestMapping(value= {"quan-ly-tin-rao-ban-cho-thue"}, method = RequestMethod.GET)
    public String getListPostPage() {
    	return "client/sellernet/listPost";
    }
    
}
