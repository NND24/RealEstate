package batdongsan.interceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoggerInterceptor extends HandlerInterceptorAdapter{
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		if (!isUserLoggedIn(request)) {
	        response.sendRedirect(request.getContextPath() + "/admin/login.html");
	        return false;
	    }
	    return true;
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("LoggerInterceptor.postHandle()");
	}
	
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		System.out.println("LoggerInterceptor.afterCompletion()");
	}
	
	private boolean isUserLoggedIn(HttpServletRequest request) {
	    Cookie[] cookies = request.getCookies();
	    if (cookies != null) {
	        System.out.println("Cookies:");
	        for (Cookie cookie : cookies) {
	            System.out.println(cookie.getName() + ": " + cookie.getValue());
	            if (cookie.getName().equals("id") && cookie.getValue() != null && !cookie.getValue().isEmpty()) {
	                // Nếu cookie với tên là "id" tồn tại và có giá trị không rỗng, người dùng đã đăng nhập
	                return true;
	            }
	        }
	    }
	    // Người dùng chưa đăng nhập
	    return false;
	}

}
