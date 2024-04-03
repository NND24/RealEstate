package batdongsan.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {
    @RequestMapping(value= {"/", "/trang-chu"}, method = RequestMethod.GET)
    public String index() {
        return "client/home";
    }
    
}
