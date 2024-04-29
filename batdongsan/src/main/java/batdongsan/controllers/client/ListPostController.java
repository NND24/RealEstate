package batdongsan.controllers.client;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import batdongsan.models.CategoryModel;
import batdongsan.models.DistrictsModel;
import batdongsan.models.FavouriteModel;
import batdongsan.models.ProvincesModel;
import batdongsan.models.RealEstateModel;
import batdongsan.models.UsersModel;
import batdongsan.models.WardsModel;

@Controller
@RequestMapping("/sellernet/")
public class ListPostController {
	@Autowired
	SessionFactory factory;

	@RequestMapping(value = { "quan-ly-tin-rao-ban-cho-thue" }, method = RequestMethod.GET)
	public String getListPostPage(HttpServletRequest request,
			@RequestParam(name = "searchInput", required = false) String searchInput) {
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
				
				String hqlAll = "SELECT re FROM RealEstateModel re JOIN re.user AS user WHERE re.status = :status AND user.userId = :userId";
				if (searchInput != null && !searchInput.isEmpty()) {
					hqlAll += " AND (address LIKE :searchInput0 OR title LIKE :searchInput1 OR description LIKE :searchInput2)";
				}
				Query<RealEstateModel> queryAll = session.createQuery(hqlAll);
				queryAll.setParameter("userId", Integer.parseInt(userId));
				queryAll.setParameter("status", "Đang hiển thị");
				if (searchInput != null && !searchInput.isEmpty()) {
					queryAll.setParameter("searchInput0", "%" + searchInput + "%");
					queryAll.setParameter("searchInput1", "%" + searchInput + "%");
					queryAll.setParameter("searchInput2", "%" + searchInput + "%");
				}
				List<RealEstateModel> allRealEstates = queryAll.list();
				request.setAttribute("allRealEstates", allRealEstates);
				
				String hqlExpired = "SELECT re FROM RealEstateModel re JOIN re.user AS user WHERE re.status = :status AND user.userId = :userId AND re.expirationDate < :today";
				if (searchInput != null && !searchInput.isEmpty()) {
					hqlExpired += " AND (address LIKE :searchInput0 OR title LIKE :searchInput1 OR description LIKE :searchInput2)";
				}
				Query<RealEstateModel> queryExpired = session.createQuery(hqlExpired);
				queryExpired.setParameter("userId", Integer.parseInt(userId));
				queryExpired.setParameter("today", java.sql.Date.valueOf(LocalDate.now()));
				queryExpired.setParameter("status", "Đang hiển thị");
				if (searchInput != null && !searchInput.isEmpty()) {
					queryExpired.setParameter("searchInput0", "%" + searchInput + "%");
					queryExpired.setParameter("searchInput1", "%" + searchInput + "%");
					queryExpired.setParameter("searchInput2", "%" + searchInput + "%");
				}
				List<RealEstateModel> expiredRealEstates = queryExpired.list();
				request.setAttribute("expiredRealEstates", expiredRealEstates);
				
				// Construct the range for expiration dates
				LocalDate startDate = LocalDate.now().plusDays(1); // Start 2 days from now
				LocalDate endDate = LocalDate.now().plusDays(3); // End 4 days from now

				String hqlNearExpired = "SELECT re FROM RealEstateModel re JOIN re.user AS user WHERE re.status = :status AND user.userId = :userId AND re.expirationDate >= :startDate AND re.expirationDate <= :endDate";
				if (searchInput != null && !searchInput.isEmpty()) {
					hqlNearExpired += " AND (address LIKE :searchInput0 OR title LIKE :searchInput1 OR description LIKE :searchInput2)";
				}
				Query<RealEstateModel> queryNearExpired = session.createQuery(hqlNearExpired); 
				queryNearExpired.setParameter("userId", Integer.parseInt(userId));
				queryNearExpired.setParameter("startDate", java.sql.Date.valueOf(startDate));
				queryNearExpired.setParameter("endDate", java.sql.Date.valueOf(endDate));
				queryNearExpired.setParameter("status", "Đang hiển thị");
				if (searchInput != null && !searchInput.isEmpty()) {
					queryNearExpired.setParameter("searchInput0", "%" + searchInput + "%");
					queryNearExpired.setParameter("searchInput1", "%" + searchInput + "%");
					queryNearExpired.setParameter("searchInput2", "%" + searchInput + "%");
				}
				List<RealEstateModel> nearExpiredRealEstates = queryNearExpired.list();
				request.setAttribute("nearExpiredRealEstates", nearExpiredRealEstates);

				String hqlDisplay = "SELECT re FROM RealEstateModel re JOIN re.user AS user WHERE re.status = :status";
				if (searchInput != null && !searchInput.isEmpty()) {
					hqlDisplay += " AND (address LIKE :searchInput0 OR title LIKE :searchInput1 OR description LIKE :searchInput2)";
				}
				Query<RealEstateModel> queryDisplay = session.createQuery(hqlDisplay);
				queryDisplay.setParameter("status", "Đang hiển thị");
				if (searchInput != null && !searchInput.isEmpty()) {
					queryDisplay.setParameter("searchInput0", "%" + searchInput + "%");
					queryDisplay.setParameter("searchInput1", "%" + searchInput + "%");
					queryDisplay.setParameter("searchInput2", "%" + searchInput + "%");
				}
				List<RealEstateModel> displayRealEstates = queryDisplay.list();
				request.setAttribute("displayRealEstates", displayRealEstates);

			} else {
				UsersModel user = null;
				request.setAttribute("user", user);
			}
			return "client/sellernet/listPost";
		} finally {
			session.close();
		}
	}

	
	@RequestMapping(value = "deleteRealEstate", method = RequestMethod.GET)
	public String deleteRealEstate(ModelMap model, HttpServletRequest request,
			@RequestParam(name = "realEstateId") Integer realEstateId) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			String hql = "FROM RealEstateModel WHERE realEstateId = :realEstateId";
			Query<RealEstateModel> query = session.createQuery(hql);
			query.setParameter("realEstateId", realEstateId);
			RealEstateModel deletedRealEstate = query.uniqueResult();
			
			session.delete(deletedRealEstate);
			t.commit();
			return "redirect:/sellernet/quan-ly-tin-rao-ban-cho-thue.html";
		} catch (Exception e) {
			t.rollback();
			e.printStackTrace();
			return "redirect:/sellernet/quan-ly-tin-rao-ban-cho-thue.html";
		} finally {
			session.close();
		}
	}
	

	@ModelAttribute("categoriesSell")
	public List<CategoryModel> getTypesSell() {
		Session session = factory.openSession();
		try {
			String hql = "FROM CategoryModel WHERE type = :type";
			Query<CategoryModel> query = session.createQuery(hql);
			query.setParameter("type", "Nhà đất bán");
			List<CategoryModel> categories = query.list();

			return categories;
		} catch (Exception e) {
			System.out.println(e);
			return null;
		} finally {
			session.close();
		}
	}

	@ModelAttribute("categoriesRent")
	public List<CategoryModel> getTypesRent() {
		Session session = factory.openSession();
		try {
			String hql = "FROM CategoryModel WHERE type = :type";
			Query<CategoryModel> query = session.createQuery(hql);
			query.setParameter("type", "Nhà đất cho thuê");
			List<CategoryModel> categories = query.list();

			return categories;
		} catch (Exception e) {
			System.out.println(e);
			return null;
		} finally {
			session.close();
		}
	}
}
