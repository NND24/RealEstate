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
	    try (Session session = factory.openSession()) {
	        Transaction t = session.beginTransaction();
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
	                int parsedUserId = Integer.parseInt(userId);

	                // Fetch user details
	                String hqlUser = "FROM UsersModel WHERE userId = :userId";
	                UsersModel user = session.createQuery(hqlUser, UsersModel.class)
	                                         .setParameter("userId", parsedUserId)
	                                         .uniqueResult();
	                request.setAttribute("user", user);

	                // Fetch all real estates
	                String hqlAll = "SELECT re FROM RealEstateModel re JOIN re.user AS user WHERE user.userId = :userId";
	                if (searchInput != null && !searchInput.isEmpty()) {
	                    hqlAll += " AND (address LIKE :searchInput OR title LIKE :searchInput OR description LIKE :searchInput)";
	                }
	                Query<RealEstateModel> queryAll = session.createQuery(hqlAll, RealEstateModel.class);
	                queryAll.setParameter("userId", parsedUserId);
	                if (searchInput != null && !searchInput.isEmpty()) {
	                    queryAll.setParameter("searchInput", "%" + searchInput + "%");
	                }
	                List<RealEstateModel> allRealEstates = queryAll.list();
	                request.setAttribute("allRealEstates", allRealEstates);

	                // Fetch expired real estates
	                String hqlExpired = "SELECT re FROM RealEstateModel re JOIN re.user AS user WHERE user.userId = :userId AND re.expirationDate < :today";
	                if (searchInput != null && !searchInput.isEmpty()) {
	                    hqlExpired += " AND (address LIKE :searchInput OR title LIKE :searchInput OR description LIKE :searchInput)";
	                }
	                Query<RealEstateModel> queryExpired = session.createQuery(hqlExpired, RealEstateModel.class);
	                queryExpired.setParameter("userId", parsedUserId);
	                queryExpired.setParameter("today", java.sql.Date.valueOf(LocalDate.now()));
	                if (searchInput != null && !searchInput.isEmpty()) {
	                    queryExpired.setParameter("searchInput", "%" + searchInput + "%");
	                }
	                List<RealEstateModel> expiredRealEstates = queryExpired.list();
	                request.setAttribute("expiredRealEstates", expiredRealEstates);

	                // Update status of all real estates to "Ẩn"
	                expiredRealEstates.forEach(re -> {
	                    re.setStatus("Ẩn");
	                    session.merge(re);
	                });

	                // Construct the range for near-expiration dates
	                LocalDate startDate = LocalDate.now().plusDays(1);
	                LocalDate endDate = LocalDate.now().plusDays(3);

	                // Fetch near-expired real estates
	                String hqlNearExpired = "SELECT re FROM RealEstateModel re JOIN re.user AS user WHERE user.userId = :userId AND re.expirationDate >= :startDate AND re.expirationDate <= :endDate";
	                if (searchInput != null && !searchInput.isEmpty()) {
	                    hqlNearExpired += " AND (address LIKE :searchInput OR title LIKE :searchInput OR description LIKE :searchInput)";
	                }
	                Query<RealEstateModel> queryNearExpired = session.createQuery(hqlNearExpired, RealEstateModel.class);
	                queryNearExpired.setParameter("userId", parsedUserId);
	                queryNearExpired.setParameter("startDate", java.sql.Date.valueOf(startDate));
	                queryNearExpired.setParameter("endDate", java.sql.Date.valueOf(endDate));
	                if (searchInput != null && !searchInput.isEmpty()) {
	                    queryNearExpired.setParameter("searchInput", "%" + searchInput + "%");
	                }
	                List<RealEstateModel> nearExpiredRealEstates = queryNearExpired.list();
	                request.setAttribute("nearExpiredRealEstates", nearExpiredRealEstates);

	                // Fetch real estates that are currently displayed
	                String hqlDisplay = "SELECT re FROM RealEstateModel re JOIN re.user AS user WHERE re.status = :status";
	                if (searchInput != null && !searchInput.isEmpty()) {
	                    hqlDisplay += " AND (address LIKE :searchInput OR title LIKE :searchInput OR description LIKE :searchInput)";
	                }
	                Query<RealEstateModel> queryDisplay = session.createQuery(hqlDisplay, RealEstateModel.class);
	                queryDisplay.setParameter("status", "Đang hiển thị");
	                if (searchInput != null && !searchInput.isEmpty()) {
	                    queryDisplay.setParameter("searchInput", "%" + searchInput + "%");
	                }
	                List<RealEstateModel> displayRealEstates = queryDisplay.list();
	                request.setAttribute("displayRealEstates", displayRealEstates);

	                t.commit();
	            } else {
	                request.setAttribute("user", null);
	            }

	            return "client/sellernet/listPost";
	        } catch (Exception e) {
	            t.rollback();
	            throw e;
	        }
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
