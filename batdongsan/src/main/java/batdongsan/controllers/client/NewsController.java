package batdongsan.controllers.client;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Calendar;
import java.awt.PageAttributes.MediaType;
import java.io.File;
import java.io.IOException;
import java.sql.Date;

import java.util.List;
import java.util.Random;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import batdongsan.models.CategoryModel;
import batdongsan.models.NewsModel;

@Controller
@RequestMapping("/admin/")
public class NewsController {

	@Autowired
	SessionFactory factory;
	ServletContext context;

	@RequestMapping("listNews")
	public String index(ModelMap model) {
		Session session = factory.openSession();
		String hql = "FROM NewsModel ORDER BY dateUploaded DESC";
		Query query = session.createQuery(hql);
		List<NewsModel> list = query.list();
		model.addAttribute("listOfNews", list);
		model.addAttribute("news", new NewsModel());
		return "admin/listNews";
	}

	@Transactional
	@RequestMapping(value = "listNews/addNews", method = RequestMethod.POST)
	public String addNews(ModelMap model, @ModelAttribute("news") NewsModel news) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			String newsId = generateNewsId();
			news.setNewsId(newsId);
			Date today = new Date(Calendar.getInstance().getTime().getTime());
			news.setDateUploaded(today);			
		
			session.save(news);
			t.commit();
			model.addAttribute("message", "Thêm mới thành công");
		} catch (Exception e) {
			t.rollback();
			model.addAttribute("message", "Thao tác thất bại: " + e.getMessage());
		} finally {
			session.close();
		}
		return "redirect:/admin/listNews.html";
	}

	// Duyệt tin
	@RequestMapping(value = "listNews/approve/{newsId}", method = RequestMethod.GET)
	public String approveNews(ModelMap model, @PathVariable("newsId") String newsId) {
		Session session = factory.openSession();
		Transaction t = null;
		try {
			t = session.beginTransaction();
			NewsModel newsToUpdate = session.get(NewsModel.class, newsId); // Lấy tin tức cần cập nhật từ cơ sở dữ liệu
			if (newsToUpdate != null) {
				// Thực hiện cập nhật trạng thái tin tức ở đây
				newsToUpdate.setStatus(true); // Giả sử thuộc tính trạng thái là status và giá trị mới là "approved"
				session.update(newsToUpdate); // Cập nhật tin tức
				t.commit(); // Commit giao dịch sau khi cập nhật thành công
			} else {
				model.addAttribute("message", "Tin tức không tồn tại!");
			}
		} catch (Exception e) {
			if (t != null) {
				t.rollback(); // Rollback giao dịch nếu có lỗi xảy ra
			}
			model.addAttribute("message", "Cập nhật trạng thái tin tức thất bại!");
		} finally {
			session.close();
		}
		return "redirect:/admin/listNews.html";
	}

	// Ẩn tin
	@RequestMapping(value = "listNews/hide/{newsId}", method = RequestMethod.GET)
	public String hideNews(ModelMap model, @PathVariable("newsId") String newsId) {
		Session session = factory.openSession();
		Transaction t = null;
		try {
			t = session.beginTransaction();
			NewsModel newsToUpdate = session.get(NewsModel.class, newsId); // Lấy tin tức cần cập nhật từ cơ sở dữ liệu
			if (newsToUpdate != null) {
				// Thực hiện cập nhật trạng thái tin tức ở đây
				newsToUpdate.setStatus(false); // Giả sử thuộc tính trạng thái là status và giá trị mới là "approved"
				session.update(newsToUpdate); // Cập nhật tin tức
				t.commit(); // Commit giao dịch sau khi cập nhật thành công
			} else {
				model.addAttribute("message", "Tin tức không tồn tại!");
			}
		} catch (Exception e) {
			if (t != null) {
				t.rollback(); // Rollback giao dịch nếu có lỗi xảy ra
			}
			model.addAttribute("message", "Cập nhật trạng thái tin tức thất bại!");
		} finally {
			session.close();
		}
		return "redirect:/admin/listNews.html";
	}

	// Xóa tin
	@RequestMapping(value = "listNews/delete/{newsId}", method = RequestMethod.GET)
	public String deleteNews(ModelMap model, @PathVariable("newsId") String newsId) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			NewsModel newsToDelete = session.get(NewsModel.class, newsId);
			if (newsToDelete != null) {
				session.delete(newsToDelete);
				t.commit();
				model.addAttribute("message", "Xóa thành công!");
			} else {
				model.addAttribute("message", "Không tồn tại!");
			}
		} catch (Exception e) {
			t.rollback();
			model.addAttribute("message", "Xóa thất bại!");
		} finally {
			session.close();
		}
		return "redirect:/admin/listNews.html";
	}

	// =======
	@RequestMapping(value = "listNews/update/{newsId}", method = RequestMethod.GET)
	public String getUpdate(ModelMap model, @PathVariable("newsId") String newsId) {
		Session session = factory.openSession();
		String hql = "FROM NewsModel ORDER BY dateUploaded DESC";
		Query query = session.createQuery(hql);
		List<NewsModel> list = query.list();
		model.addAttribute("listOfNews", list);
		model.addAttribute("news", new NewsModel());

		NewsModel news = (NewsModel) session.get(NewsModel.class, newsId);
		model.addAttribute("news", news);
		String description = news.getDescription();
		model.addAttribute("description", description);
		return "admin/listNewsUpdate";
	}

//	@RequestMapping(value = "listNews/update/listNews/udpate", method = RequestMethod.POST)
//	public String updateNews(ModelMap model, @ModelAttribute("news") NewsModel news) {
//	    Session session = factory.openSession();
//	    Transaction t = session.beginTransaction();
//	    try {
//	        // Cập nhật danh mục	
//	    	NewsModel existingNews = (NewsModel) session.get(NewsModel.class, news.getNewsId());
//	    	if (existingNews != null) {
//	            session.update(existingNews);
//	            t.commit();
//	            model.addAttribute("message", "Cập nhật thành công");
//	    	}
//	    } catch (Exception e) {
//	        t.rollback();
//	        model.addAttribute("message", "Thao tác thất bại: " + e.getMessage());
//	    } finally {
//	        session.close();
//	    }
//	    // Chuyển hướng người dùng về trang danh sách các danh mục sau khi cập nhật
//	    return "redirect:/admin/listNews.html";
//	}

	@RequestMapping(value = "listNews/update/listNews/udpate", method = RequestMethod.POST)
	public String updateNews(@ModelAttribute("news") NewsModel news) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			// Sử dụng merge để cập nhật đối tượng news
			session.merge(news);
			t.commit();
		} catch (Exception e) {
			t.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}
		return "redirect:/admin/listNews.html";
	}

	@RequestMapping(value = "updateNews/cancel", method = RequestMethod.GET)
	public String cancelUpdate() {
		// Redirect về trang danh sách danh mục
		return "redirect:/admin/listNews.html";
	}

	// ========
	@RequestMapping(value = "/listNews/detail/{newsId}", method = RequestMethod.GET)
	public String getDetail(ModelMap model, @PathVariable("newsId") String newsId) {
		try (Session session = factory.openSession()) {
			NewsModel news = session.get(NewsModel.class, newsId);
			if (news == null) {
				return "redirect:/admin/listNews.html";
			}
			model.addAttribute("news", news);
			return "admin/detail";
		} catch (Exception e) {
			return "redirect:/admin/listNews.html";
		}
	}

	// ========
	public static String generateNewsId() {
		java.util.Date now = new java.util.Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("mmss");
		String timeString = dateFormat.format(now);
		Random random = new Random();
		int randomNumber = random.nextInt(10000);
		String randomString = "NW" + timeString + randomNumber;
		return randomString;
	}

}
