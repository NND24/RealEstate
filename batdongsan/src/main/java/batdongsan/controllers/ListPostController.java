package batdongsan.controllers;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import batdongsan.models.UsersModel;

@Controller
@RequestMapping("/sellernet/")
public class ListPostController {
	@Autowired
	SessionFactory factory;
	
    @RequestMapping(value= {"quan-ly-tin-rao-ban-cho-thue"}, method = RequestMethod.GET)
    public String getListPostPage(HttpServletRequest request) {
    	Session session = factory.openSession();
    	
    	try {
    		Cookie[] cookies = request.getCookies();
    		String userId = null;

    		if (cookies != null) {
    			for (Cookie cookie : cookies) {
    				if (cookie.getName().equals("userId")) {
    					userId = cookie.getValue();
    					break;
    				}
    			}
    		}

    		if (userId != null) {
    			String hqlUser = "FROM UsersModel WHERE userId = :userId";
    			Query<UsersModel> queryUser = session.createQuery(hqlUser);
    			queryUser.setParameter("userId", Integer.parseInt(userId));
    			UsersModel user = queryUser.uniqueResult();
    			request.setAttribute("user", user);
    		} else {
    			UsersModel user = null;
    			request.setAttribute("user", user);
    		}
        	
        	return "client/sellernet/listPost";
		} finally {
			session.close();
		}
    }
    
}
