package batdongsan.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class DetailController {
    @RequestMapping(value= {"/chi-tiet"}, method = RequestMethod.GET)
    public String index() {
        return "client/detail";
    }
}
