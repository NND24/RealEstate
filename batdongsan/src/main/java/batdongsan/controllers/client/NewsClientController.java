package batdongsan.controllers.client;

import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import batdongsan.models.EmployeeModel;
import batdongsan.models.NewsModel;

@Controller
public class NewsClientController {
	@Autowired
	SessionFactory factory;
	
	@RequestMapping(value = { "/tin-tuc" }, method = RequestMethod.GET)
    public String getNewsPage(ModelMap model) {
        Session session = factory.openSession();
        String hql = "SELECT n FROM NewsModel n WHERE n.status = true ORDER BY n.dateUploaded DESC";
        Query<NewsModel> query = session.createQuery(hql, NewsModel.class);

        List<NewsModel> fullNewsList = query.getResultList();
        List<NewsModel> firstFourNews = fullNewsList.subList(0, Math.min(4, fullNewsList.size()));

        model.addAttribute("firstFourNews", firstFourNews);
        model.addAttribute("initialNews", fullNewsList.subList(4, Math.min(9, fullNewsList.size())));

        session.close();
        return "client/news/news";
    }
	
	@RequestMapping(value = { "/tin-tuc/danh-sach" }, method = RequestMethod.GET)
	public String moreNews(ModelMap model, HttpServletRequest request) {
	    Session session = factory.openSession();

	    // Phân trang
	    int pageSize = 5;
	    String pageParam = request.getParameter("page");
	    int currentPage = 1;
	    if (pageParam != null && !pageParam.isEmpty()) {
	        currentPage = Integer.parseInt(pageParam);
	    }
	    int startIndex = (currentPage - 1) * pageSize;

	    // Lấy tham số filter từ request
	    String filter = request.getParameter("filter");
	    String hql = "FROM NewsModel WHERE status = true"; // Chỉ lấy các tin có trạng thái là true

	    // Thêm điều kiện vào HQL nếu có filter
	    if (filter != null) {
	        switch (filter) {
	            case "approved":
	                // Không cần thêm điều kiện ở đây vì đã chỉ lấy các tin có status là true ở trên
	                break;
	            case "hidden":
	                // Không cần thêm điều kiện ở đây vì đã chỉ lấy các tin có status là true ở trên
	                break;
	            default:
	                break;
	        }
	    }

	    hql += " ORDER BY dateUploaded DESC";
	    Query query = session.createQuery(hql);
	    query.setFirstResult(startIndex);
	    query.setMaxResults(pageSize);
	    List<NewsModel> list = query.list();

	    // Tính toán tổng số trang
	    String countHql = "SELECT count(n.id) FROM NewsModel n WHERE status = true"; // Đếm tổng số tin có status là true
	    if (filter != null) {
	        switch (filter) {
	            case "approved":
	                // Không cần thêm điều kiện ở đây vì đã chỉ lấy các tin có status là true ở trên
	                break;
	            case "hidden":
	                // Không cần thêm điều kiện ở đây vì đã chỉ lấy các tin có status là true ở trên
	                break;
	            default:
	                break;
	        }
	    }
	    Query countQuery = session.createQuery(countHql);
	    Long countResult = (Long) countQuery.uniqueResult();
	    int totalPages = (int) Math.ceil((double) countResult / pageSize);

	    model.addAttribute("listOfNews", list);
	    model.addAttribute("news", new NewsModel());
	    model.addAttribute("totalNews", countResult);
	    model.addAttribute("currentPage", currentPage);
	    model.addAttribute("totalPages", totalPages);
	    
	    
	    session.close();
	    return "client/news/listNews";
	}



}
