package batdongsan.controllers.client;

import java.time.LocalDate;
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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import batdongsan.models.CategoryModel;
import batdongsan.models.HCMRealEstateModel;
import batdongsan.models.UsersModel;

@Controller
@RequestMapping("/sellernet/")
public class ListPostController {
	@Autowired
	SessionFactory factory;

	@RequestMapping(value = { "quan-ly-tin-rao-ban-cho-thue" }, method = RequestMethod.GET)
	public String getListPostPage(HttpServletRequest request,
	        @RequestParam(name = "searchInput", required = false) String searchInput,
	        @RequestParam(name = "pageAll", defaultValue = "1") int pageAll,
	        @RequestParam(name = "pageExpired", defaultValue = "1") int pageExpired,
	        @RequestParam(name = "pageNearExpired", defaultValue = "1") int pageNearExpired,
	        @RequestParam(name = "pageDisplay", defaultValue = "1") int pageDisplay,
	        @RequestParam(name = "size", defaultValue = "5") int size) {
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
	                String hqlAll = "SELECT re FROM HCMRealEstateModel re JOIN re.user AS user WHERE user.userId = :userId";
	                if (searchInput != null && !searchInput.isEmpty()) {
	                    hqlAll += " AND (address LIKE :searchInput OR title LIKE :searchInput OR description LIKE :searchInput)";
	                }
	                Query<HCMRealEstateModel> queryAll = session.createQuery(hqlAll, HCMRealEstateModel.class);
	                queryAll.setParameter("userId", parsedUserId);
	                if (searchInput != null && !searchInput.isEmpty()) {
	                    queryAll.setParameter("searchInput", "%" + searchInput + "%");
	                }

	                int totalAllResults = queryAll.list().size();
	                queryAll.setFirstResult((pageAll - 1) * size);
	                queryAll.setMaxResults(size);

	                List<HCMRealEstateModel> allRealEstates = queryAll.list();
	                request.setAttribute("allRealEstates", allRealEstates);

	                request.setAttribute("currentAllPage", pageAll);
	                request.setAttribute("totalAllResults", totalAllResults);
	                request.setAttribute("totalAllPages", (int) Math.ceil((double) totalAllResults / size));

	                // Fetch expired real estates
	                String hqlExpired = "SELECT re FROM HCMRealEstateModel re JOIN re.user AS user WHERE user.userId = :userId AND re.expirationDate < :today";
	                if (searchInput != null && !searchInput.isEmpty()) {
	                    hqlExpired += " AND (address LIKE :searchInput OR title LIKE :searchInput OR description LIKE :searchInput)";
	                }
	                Query<HCMRealEstateModel> queryExpired = session.createQuery(hqlExpired, HCMRealEstateModel.class);
	                queryExpired.setParameter("userId", parsedUserId);
	                queryExpired.setParameter("today", java.sql.Date.valueOf(LocalDate.now()));
	                if (searchInput != null && !searchInput.isEmpty()) {
	                    queryExpired.setParameter("searchInput", "%" + searchInput + "%");
	                }

	                int totalExpiredResults = queryExpired.list().size();
	                queryExpired.setFirstResult((pageExpired - 1) * size);
	                queryExpired.setMaxResults(size);

	                List<HCMRealEstateModel> expiredRealEstates = queryExpired.list();
	                request.setAttribute("expiredRealEstates", expiredRealEstates);

	                // Update status of all real estates to "Ẩn"
	                expiredRealEstates.forEach(re -> {
	                    re.setStatus("Ẩn");
	                    session.merge(re);
	                });

	                // Construct the range for near-expiration dates
	                LocalDate startDate = LocalDate.now().plusDays(1);
	                LocalDate endDate = LocalDate.now().plusDays(3);

	                request.setAttribute("currentExpiredPage", pageExpired);
	                request.setAttribute("totalExpiredResults", totalExpiredResults);
	                request.setAttribute("totalExpiredPages", (int) Math.ceil((double) totalExpiredResults / size));

	                // Fetch near-expired real estates
	                String hqlNearExpired = "SELECT re FROM HCMRealEstateModel re JOIN re.user AS user WHERE user.userId = :userId AND re.expirationDate >= :startDate AND re.expirationDate <= :endDate";
	                if (searchInput != null && !searchInput.isEmpty()) {
	                    hqlNearExpired += " AND (address LIKE :searchInput OR title LIKE :searchInput OR description LIKE :searchInput)";
	                }
	                Query<HCMRealEstateModel> queryNearExpired = session.createQuery(hqlNearExpired, HCMRealEstateModel.class);
	                queryNearExpired.setParameter("userId", parsedUserId);
	                queryNearExpired.setParameter("startDate", java.sql.Date.valueOf(startDate));
	                queryNearExpired.setParameter("endDate", java.sql.Date.valueOf(endDate));
	                if (searchInput != null && !searchInput.isEmpty()) {
	                    queryNearExpired.setParameter("searchInput", "%" + searchInput + "%");
	                }

	                int totalNearExpiredResults = queryNearExpired.list().size();
	                queryNearExpired.setFirstResult((pageNearExpired - 1) * size);
	                queryNearExpired.setMaxResults(size);

	                List<HCMRealEstateModel> nearExpiredRealEstates = queryNearExpired.list();
	                request.setAttribute("nearExpiredRealEstates", nearExpiredRealEstates);

	                request.setAttribute("currentNearExpiredPage", pageNearExpired);
	                request.setAttribute("totalNearExpiredResults", totalNearExpiredResults);
	                request.setAttribute("totalNearExpiredPages", (int) Math.ceil((double) totalNearExpiredResults / size));

	                // Fetch real estates that are currently displayed
	                String hqlDisplay = "SELECT re FROM HCMRealEstateModel re JOIN re.user AS user WHERE re.status = :status AND user.userId = :userId";
	                if (searchInput != null && !searchInput.isEmpty()) {
	                    hqlDisplay += " AND (address LIKE :searchInput OR title LIKE :searchInput OR description LIKE :searchInput)";
	                }
	                Query<HCMRealEstateModel> queryDisplay = session.createQuery(hqlDisplay, HCMRealEstateModel.class);
	                queryDisplay.setParameter("userId", parsedUserId);
	                queryDisplay.setParameter("status", "Đang hiển thị");
	                if (searchInput != null && !searchInput.isEmpty()) {
	                    queryDisplay.setParameter("searchInput", "%" + searchInput + "%");
	                }

	                int totalDisplayResults = queryDisplay.list().size();
	                queryDisplay.setFirstResult((pageDisplay - 1) * size);
	                queryDisplay.setMaxResults(size);

	                List<HCMRealEstateModel> displayRealEstates = queryDisplay.list();
	                request.setAttribute("displayRealEstates", displayRealEstates);

	                request.setAttribute("currentDisplayPage", pageDisplay);
	                request.setAttribute("totalDisplayResults", totalDisplayResults);
	                request.setAttribute("totalDisplayPages", (int) Math.ceil((double) totalDisplayResults / size));

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
			String hql = "FROM HCMRealEstateModel WHERE realEstateId = :realEstateId";
			Query<HCMRealEstateModel> query = session.createQuery(hql);
			query.setParameter("realEstateId", realEstateId);
			HCMRealEstateModel deletedRealEstate = query.uniqueResult();

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
			String hql = "FROM CategoryModel WHERE type = :type AND status=0";
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
