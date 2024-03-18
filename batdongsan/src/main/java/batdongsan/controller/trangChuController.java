package batdongsan.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/")
public class trangChuController {
	@RequestMapping("/trangchu")
	public String welcome() {
		return "/trangChu/trangChu";
	}
}
