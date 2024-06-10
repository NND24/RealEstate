package batdongsan.controllers.client;

import java.util.Collections;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import batdongsan.models.EmployeeModel;
import batdongsan.models.NewsModel;
import batdongsan.models.UsersModel;

@Controller
public class NewsClientController {
	@Autowired
	SessionFactory factory;

	@RequestMapping(value = { "/tin-tuc" }, method = RequestMethod.GET)
	public String getNewsPage(ModelMap model, HttpServletRequest request) {
		Session session = factory.openSession();
		String hql = "SELECT n FROM NewsModel n WHERE n.status = true ORDER BY n.dateUploaded DESC";
		Query<NewsModel> query = session.createQuery(hql, NewsModel.class);

		List<NewsModel> fullNewsList = query.getResultList();
		List<NewsModel> firstFourNews = fullNewsList.subList(0, Math.min(4, fullNewsList.size()));

		model.addAttribute("firstFourNews", firstFourNews);
		model.addAttribute("initialNews", fullNewsList.subList(4, Math.min(9, fullNewsList.size())));
		
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

	    // Lấy tham số search từ request
	    String search = request.getParameter("search");
	    String hql = "FROM NewsModel WHERE status = true"; // Chỉ lấy các tin có trạng thái là true

	    // Thêm điều kiện tìm kiếm nếu có
	    if (search != null && !search.isEmpty()) {
	        hql += " AND (title LIKE :search OR shortDescription LIKE :search)";
	    }

	    hql += " ORDER BY dateUploaded DESC";
	    Query query = session.createQuery(hql);
	    query.setFirstResult(startIndex);
	    query.setMaxResults(pageSize);

	    // Thiết lập giá trị cho tham số tìm kiếm nếu có
	    if (search != null && !search.isEmpty()) {
	        query.setParameter("search", "%" + search + "%");
	    }

	    List<NewsModel> list = query.list();

	    // Tính toán tổng số trang
	    String countHql = "SELECT count(n.id) FROM NewsModel n WHERE status = true"; // Đếm tổng số tin có status là true
	    if (search != null && !search.isEmpty()) {
	        countHql += " AND (title LIKE :search OR shortDescription LIKE :search)";
	    }
	    Query countQuery = session.createQuery(countHql);

	    // Thiết lập giá trị cho tham số tìm kiếm nếu có
	    if (search != null && !search.isEmpty()) {
	        countQuery.setParameter("search", "%" + search + "%");
	    }

	    Long countResult = (Long) countQuery.uniqueResult();
	    int totalPages = (int) Math.ceil((double) countResult / pageSize);

	    model.addAttribute("listOfNews", list);
	    model.addAttribute("news", new NewsModel());
	    model.addAttribute("totalNews", countResult);
	    model.addAttribute("currentPage", currentPage);
	    model.addAttribute("totalPages", totalPages);
	    model.addAttribute("search", search); // Thêm tham số tìm kiếm vào model
	    
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

	    session.close();
	    return "client/news/listNews";
	}


	// Chi tiết tin
	@RequestMapping(value = "/tin-tuc/{newsId}", method = RequestMethod.GET)
	public String getDetail(ModelMap model, @PathVariable("newsId") String newsId, HttpServletRequest request) {
		try (Session session = factory.openSession()) {
			NewsModel news = session.get(NewsModel.class, newsId);
			if (news == null) {
				return "redirect:/admin/listNews.html";
			}
			model.addAttribute("news", news);
			
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
			
			return "client/news/detailNews";
		} catch (Exception e) {
			return "redirect:/tin-tuc.html";
		}
	}

}
