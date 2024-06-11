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
	public String moreNews(ModelMap model, HttpServletRequest request,
			@RequestParam(name = "searchInput", required = false) String searchInput,
			@RequestParam(name = "pageAll", defaultValue = "1") int pageAll,
			@RequestParam(name = "size", defaultValue = "5") int size) {
		Session session = factory.openSession();
		try {
			String hql = "FROM NewsModel n WHERE status = true";
			if (searchInput != null && !searchInput.isEmpty()) {
				hql += " AND (n.title LIKE :searchInput)";
			}
			hql += " ORDER BY dateUploaded DESC";
			Query<NewsModel> queryAll = session.createQuery(hql, NewsModel.class);
			if (searchInput != null && !searchInput.isEmpty()) {
				queryAll.setParameter("searchInput", "%" + searchInput + "%");
			}
			int totalAllResults = queryAll.list().size();
			queryAll.setFirstResult((pageAll - 1) * size);
			queryAll.setMaxResults(size);

			List<NewsModel> allNews = queryAll.list();

			request.setAttribute("listOfNews", allNews);
			request.setAttribute("currentAllPage", pageAll);
			request.setAttribute("totalAllResults", totalAllResults);
			request.setAttribute("totalAllPages", (int) Math.ceil((double) totalAllResults / size));
			
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
			
			return "client/news/listNews2";
		} finally {
			session.close();
		}

	}

	// Chi tiết tin
	@RequestMapping(value = "/tin-tuc/{newsId}", method = RequestMethod.GET)
	public String getDetail(ModelMap model, @PathVariable("newsId") String newsId, HttpServletRequest request) {
		try (Session session = factory.openSession()) {
			String hql = "FROM NewsModel WHERE newsId = :newsId";
	        Query<NewsModel> query = session.createQuery(hql);
	        query.setParameter("newsId", newsId);
	        NewsModel news = query.uniqueResult();
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
