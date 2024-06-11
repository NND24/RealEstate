package batdongsan.controllers.admin;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Collections;
import java.io.File;
import java.sql.Date;
import org.apache.commons.io.FilenameUtils;

import java.util.List;
import java.util.Random;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import batdongsan.models.EmployeeModel;
import batdongsan.models.NewsModel;
import batdongsan.models.RealEstateModel;

@Controller
@RequestMapping("/admin/")
public class NewsController {

	@Autowired
	SessionFactory factory;
	ServletContext context;

	@RequestMapping("listNews")
	public String index(ModelMap model, HttpServletRequest request,
	                    @RequestParam(name = "searchInput", required = false) String searchInput,
	                    @RequestParam(name = "filter", required = false) Boolean filter,
	                    @RequestParam(name = "pageAll", defaultValue = "1") int pageAll,
	                    @RequestParam(name = "size", defaultValue = "5") int size) {
	    Session session = factory.openSession();
	    try {
	        String hql = "FROM NewsModel n WHERE 1=1";
	        if (searchInput != null && !searchInput.isEmpty()) {
	            hql += " AND (n.newsId LIKE :searchInput OR n.title LIKE :searchInput)";
	        }
	        if (filter != null) {
	            hql += " AND n.status = :filter";
	        }
	        hql += " ORDER BY dateUploaded DESC";
	        Query<NewsModel> queryAll = session.createQuery(hql, NewsModel.class);
	        if (searchInput != null && !searchInput.isEmpty()) {
	            queryAll.setParameter("searchInput", "%" + searchInput + "%");
	        }
	        if (filter != null) {
	            queryAll.setParameter("filter", filter);
	        }
	        int totalAllResults = queryAll.list().size();
	        queryAll.setFirstResult((pageAll - 1) * size);
	        queryAll.setMaxResults(size);

	        List<NewsModel> allNews = queryAll.list();

	        request.setAttribute("listOfNews", allNews);
	        request.setAttribute("currentAllPage", pageAll);
	        request.setAttribute("totalAllResults", totalAllResults);
	        request.setAttribute("totalAllPages", (int) Math.ceil((double) totalAllResults / size));

	        EmployeeModel emp = getEmployeeFromCookies(request);
	        if (emp != null) {
	            model.addAttribute("loginEmp", emp);
	            List<Integer> permissions = getPermissions(emp.getId(), session);
	            model.addAttribute("permissions", permissions);
	        } else {
	            model.addAttribute("employee", null);
	            model.addAttribute("permissions", Collections.emptyList());
	        }
	        return "admin/News/listNews";
	    } finally {
	        session.close();
	    }
	}

	// Thêm tin tức
	@RequestMapping(value = "listNews/add", method = RequestMethod.GET)
	public String add(ModelMap model, HttpServletRequest request) {
		Session session = factory.openSession();
		String hql = "FROM NewsModel ORDER BY dateUploaded DESC";
		Query query = session.createQuery(hql);
		List<NewsModel> list = query.list();
		model.addAttribute("listOfNews", list);
		model.addAttribute("news", new NewsModel());

		EmployeeModel emp = getEmployeeFromCookies(request);
		if (emp != null) {
			model.addAttribute("loginEmp", emp);
			List<Integer> permissions = getPermissions(emp.getId(), session);
			model.addAttribute("permissions", permissions);
		} else {
			model.addAttribute("employee", null);
			model.addAttribute("permissions", Collections.emptyList());
		}
		session.close();
		return "admin/News/listNewsAdd";
	}

	@Transactional
	@RequestMapping(value = "listNews/addNews", method = RequestMethod.POST)
	public String addNews(ModelMap model, HttpServletRequest request,
			@RequestParam(name = "thumbnail") MultipartFile file, @RequestParam(name = "title") String title,
			@RequestParam(name = "shortDescription") String shortDescription,
			@RequestParam(name = "description") String description, @RequestParam(name = "status") Boolean status) {

		boolean hasErrors = false;

		// Tạo một đối tượng NewsModel và thiết lập các thuộc tính
		NewsModel news = new NewsModel();
		news.setTitle(title);
		news.setShortDescription(shortDescription);
		news.setDescription(description);
		news.setStatus(status);
		EmployeeModel emp = getEmployeeFromCookies(request);
		news.setEmployee(emp);

		// Kiểm tra tiêu đề
		if (title == null || title.isEmpty()) {
			model.addAttribute("titleError", "Vui lòng nhập tiêu đề!");
			hasErrors = true;
		}

		// Kiểm tra mô tả
		if (shortDescription == null || shortDescription.isEmpty()) {
			model.addAttribute("shortDescriptionError", "Vui lòng nhập mô tả!");
			hasErrors = true;
		}

		if (hasErrors) {
			loadListOfNews(model);
			model.addAttribute("message", "Có lỗi");
			model.addAttribute("news", news);

			// Load danh sách tin tức để hiển thị lại trong trường hợp có lỗi
			Session session = factory.openSession();
			String hql = "FROM NewsModel ORDER BY dateUploaded DESC";
			Query query = session.createQuery(hql);
			List<NewsModel> list = query.list();
			model.addAttribute("listOfNews", list);
			session.close();

			return "admin/News/listNewsAdd";
		} else {
			Session session = factory.openSession();
			Transaction t = session.beginTransaction();
			try {
				String newsId = generateNewsId();
				news.setNewsId(newsId);

				if (!file.isEmpty()) {
					String uploadDir = "D:/Workspace Java/BatDongSan/batdongsan/src/main/webapp/images/News/";
					String fileExtension = FilenameUtils.getExtension(file.getOriginalFilename());
					String uniqueFileName = UUID.randomUUID().toString() + "." + fileExtension;
					String filePath = uploadDir + uniqueFileName;

					File directory = new File(uploadDir);
					if (!directory.exists()) {
						directory.mkdirs();
					}

					file.transferTo(new File(filePath));
					news.setThumbnail(uniqueFileName);
				} else {
					news.setThumbnail("default-thumbnail.png"); // hoặc đặt giá trị mặc định nếu cần
				}

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
	}

	// Duyệt tin
		@RequestMapping(value = "listNews/approve/{newsId}", method = RequestMethod.GET)
		public String approveNews(ModelMap model, @PathVariable("newsId") String newsId) {
			Session session = factory.openSession();
			Transaction t = null;
			try {
				t = session.beginTransaction();
				String hql = "FROM NewsModel WHERE newsId = :newsId";
		        Query<NewsModel> query = session.createQuery(hql);
		        query.setParameter("newsId", newsId);
		        NewsModel newsToUpdate = query.uniqueResult();
		        
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
				String hql = "FROM NewsModel WHERE newsId = :newsId";
		        Query<NewsModel> query = session.createQuery(hql);
		        query.setParameter("newsId", newsId);
		        NewsModel newsToUpdate = query.uniqueResult();
				if (newsToUpdate != null) {
					newsToUpdate.setStatus(false);
					session.update(newsToUpdate); 
					t.commit();
				} else {
					model.addAttribute("message", "Tin tức không tồn tại!");
				}
			} catch (Exception e) {
				if (t != null) {
					t.rollback(); // Rollback giao dịch nếu có lỗi xảy ra
				}
				System.out.println("Cập nhật trạng thái tin tức thất bại: " + e.getMessage());
				model.addAttribute("message", "Cập nhật trạng thái tin tức thất bại!");
				String allNewsHql = "FROM NewsModel";
	            Query<NewsModel> allNewsQuery = session.createQuery(allNewsHql, NewsModel.class);
	            List<NewsModel> allNewsList = allNewsQuery.list();
	            System.out.println("Tất cả các tin tức:");
	            for (NewsModel news : allNewsList) {
	            	System.out.println(news.getNewsId());
	                System.out.println(news);
	            }
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
			System.out.println("Cập nhật trạng thái tin tức thất bại: " + e.getMessage());
		} finally {
			session.close();
		}
		return "redirect:/admin/listNews.html";
	}

	// Cập nhật
	@RequestMapping(value = "listNews/update/{newsId}", method = RequestMethod.GET)
	public String getUpdate(ModelMap model, @PathVariable("newsId") String newsId, HttpServletRequest request) {
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
		EmployeeModel emp = getEmployeeFromCookies(request);
		if (emp != null) {
			model.addAttribute("loginEmp", emp);
			List<Integer> permissions = getPermissions(emp.getId(), session);
			model.addAttribute("permissions", permissions);
		} else {
			model.addAttribute("employee", null);
			model.addAttribute("permissions", Collections.emptyList());
		}
		return "admin/News/listNewsUpdate";
	}

	@RequestMapping(value = "listNews/update/{newsId}", method = RequestMethod.POST)
	public String updateNews(ModelMap model, HttpServletRequest request, @RequestParam(name = "newsId") String newsId,
			@RequestParam(name = "thumbnail", required = false) MultipartFile file,
			@RequestParam(name = "title") String title,
			@RequestParam(name = "shortDescription") String shortDescription,
			@RequestParam(name = "description") String description, @RequestParam(name = "status") Boolean status) {

		boolean hasErrors = false;

		// Lấy đối tượng NewsModel từ cơ sở dữ liệu
		Session session = factory.openSession();
		String hql = "FROM NewsModel WHERE newsId = :newsId";
        Query<NewsModel> query = session.createQuery(hql);
        query.setParameter("newsId", newsId);
        NewsModel news = query.uniqueResult();
		session.close();

		if (news == null) {
			model.addAttribute("message", "Không tìm thấy tin tức với ID: " + newsId);
			return "redirect:/admin/listNews.html";
		}

		// Kiểm tra tiêu đề
		if (title == null || title.isEmpty()) {
			model.addAttribute("titleError", "Vui lòng nhập tiêu đề!");
			hasErrors = true;
		}

		// Kiểm tra mô tả
		if (shortDescription == null || shortDescription.isEmpty()) {
			model.addAttribute("shortDescriptionError", "Vui lòng nhập mô tả!");
			hasErrors = true;
		}

		if (hasErrors) {
			model.addAttribute("message", "Có lỗi");
			model.addAttribute("news", news);

			// Load danh sách tin tức để hiển thị lại trong trường hợp có lỗi
			loadListOfNews(model);

			return "admin/News/listNewsUpdate";
		} else {
			session = factory.openSession();
			Transaction t = session.beginTransaction();
			try {
				String filePath = null;
				String newPathThumbnail = null;
				if (file != null && !file.isEmpty()) {
					String uploadDir = "D:/Workspace Java/BatDongSan/batdongsan/src/main/webapp/images/News/";
					String fileExtension = FilenameUtils.getExtension(file.getOriginalFilename());
					String uniqueFileName = UUID.randomUUID().toString() + "." + fileExtension;
					filePath = uploadDir + uniqueFileName;
					newPathThumbnail = uniqueFileName;
					File directory = new File(uploadDir);
					if (!directory.exists()) {
						directory.mkdirs();
					}

					file.transferTo(new File(filePath));
				}
				news.setTitle(title);
				if (filePath != null) {
					news.setThumbnail(newPathThumbnail);
				}
				news.setShortDescription(shortDescription);
				news.setDescription(description);
				news.setStatus(status);

				session.merge(news);
				t.commit();
				model.addAttribute("message", "Cập nhật thành công");
			} catch (Exception e) {
				t.rollback();
				model.addAttribute("message", "Thao tác thất bại: " + e.getMessage());
			} finally {
				session.close();
			}
			return "redirect:/admin/listNews.html";
		}
	}

	@RequestMapping(value = "updateNews/cancel", method = RequestMethod.GET)
	public String cancelUpdate() {
		// Redirect về trang danh sách danh mục
		return "redirect:/admin/listNews.html";
	}

	// Xem chi tiết tin
	@RequestMapping(value = "/listNews/detailNews/{newsId}", method = RequestMethod.GET)
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
			EmployeeModel emp = getEmployeeFromCookies(request);
	        if (emp != null) {
	            model.addAttribute("loginEmp", emp);
	            List<Integer> permissions = getPermissions(emp.getId(), session);
	            model.addAttribute("permissions", permissions);
	        } else {
	            model.addAttribute("employee", null);
	            model.addAttribute("permissions", Collections.emptyList());
	        }
			return "admin/News/detailNews";
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

	private void loadListOfNews(ModelMap model) {
		Session session = factory.openSession();
		String hql = "FROM NewsModel ORDER BY dateUploaded DESC";
		Query query = session.createQuery(hql);
		List<NewsModel> list = query.list();
		model.addAttribute("listOfNews", list);
		session.close();
	}

	// lấy id Nhân viên từ khi đăng nhập
	private EmployeeModel getEmployeeFromCookies(HttpServletRequest request) {
		Session session = factory.openSession();
		Cookie[] cookies = request.getCookies();
		String empId = null;

		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("id")) {
					empId = cookie.getValue();
					System.out.println(empId);
					break;
				}
			}
		}

		if (empId != null) {
			String hqlEmp = "FROM EmployeeModel WHERE id = :id";
			Query<EmployeeModel> queryEmp = session.createQuery(hqlEmp, EmployeeModel.class);
			queryEmp.setParameter("id", empId);
			EmployeeModel emp = queryEmp.uniqueResult();
			return emp;
		} else {
			System.out.println("Không tìm thấy");
			return null;
		}
	}

	private List<Integer> getPermissions(String empId, Session session) {
		String hqlPermissions = "SELECT role.roleId FROM PermissionModel WHERE employee.id = :idEmp AND status = true";
		Query<Integer> queryPermissions = session.createQuery(hqlPermissions, Integer.class);
		queryPermissions.setParameter("idEmp", empId);
		return queryPermissions.getResultList();
	}

}
