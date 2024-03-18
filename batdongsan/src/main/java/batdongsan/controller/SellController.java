package batdongsan.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class SellController {
    @RequestMapping(value= {"/nha-dat-ban"}, method = RequestMethod.GET)
    public String index() {
        return "client/sell";
    }
}
