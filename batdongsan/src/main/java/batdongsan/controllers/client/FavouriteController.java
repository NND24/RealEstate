package batdongsan.controllers.client;

import java.util.Date;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import batdongsan.models.CategoryModel;
import batdongsan.models.FavouriteModel;
import batdongsan.models.RealEstateModel;
import batdongsan.models.UsersModel;

@Controller
@Transactional
public class FavouriteController {
	@Autowired
	SessionFactory factory;

	@RequestMapping(value = { "/tin-da-luu" }, method = RequestMethod.GET)
	public String getFavoutirePage(HttpServletRequest request,
			@RequestParam(name = "addedDate", required = false) String addedDate,
			@RequestParam(name = "newPost", required = false) String newPost,
			@RequestParam(name = "priceLowToHigh", required = false) String priceLowToHigh,
			@RequestParam(name = "priceHighToLow", required = false) String priceHighToLow,
			@RequestParam(name = "areaLowToHigh", required = false) String areaLowToHigh,
			@RequestParam(name = "areaHighToLow", required = false) String areaHighToLow) {
		Session session = factory.openSession();
		try {
			String hql = "SELECT re FROM RealEstateModel re JOIN re.favourite fa WHERE re.status = :status AND fa.user.userId = :userId";


			// ORDER BY
			String orderByClause = "";
			if (addedDate != null) {
				orderByClause = " ORDER BY addedDate DESC";
			}

			if (newPost != null) {
				orderByClause = " ORDER BY submittedDate DESC";
			}

			if (priceLowToHigh != null) {
				orderByClause = " ORDER BY price ASC";
			}

			if (priceHighToLow != null) {
				orderByClause = " ORDER BY price DESC";
			}

			if (areaLowToHigh != null) {
				orderByClause = " ORDER BY area ASC";
			}

			if (areaHighToLow != null) {
				orderByClause = " ORDER BY area DESC";
			}

			// Append the ORDER BY clause to the HQL query
			hql += orderByClause;

			Query<RealEstateModel> query = session.createQuery(hql);
			query.setParameter("status", "Đang hiển thị");
			
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
			query.setParameter("userId", Integer.parseInt(userId));

			List<RealEstateModel> listRealEstate = query.list();

			request.setAttribute("realEstates", listRealEstate);
			request.setAttribute("amountRealEstate", listRealEstate.size());
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

			return "client/favourite";
		} finally {
			session.close();
		}
	}

	@ResponseBody
	@RequestMapping("addToFavourite")
	public String addToFavourite(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(name = "realEstateId") String realEstateId) {
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

			if (userId != null && !userId.isEmpty()) {
				Session session = factory.getCurrentSession();

				// Kiểm tra realEstateId và userId không null và không rỗng
				if (realEstateId != null && !realEstateId.isEmpty()) {
					String hql = "FROM FavouriteModel WHERE userId = :userId AND realEstateId = :realEstateId";
					Query<FavouriteModel> query = session.createQuery(hql);
					query.setParameter("userId", Integer.parseInt(userId));
					query.setParameter("realEstateId", Integer.parseInt(realEstateId));
					FavouriteModel fa = query.uniqueResult();

					UsersModel user = session.get(UsersModel.class, Integer.parseInt(userId));
					RealEstateModel realEstate = session.get(RealEstateModel.class, Integer.parseInt(realEstateId));
					Date currentTime = new Date();
					FavouriteModel favourite = new FavouriteModel(user, realEstate, currentTime);

					if (fa != null) {
						FavouriteModel favouriteToDelete = session.get(FavouriteModel.class, fa.getFavouriteId());
						session.delete(favouriteToDelete);
						return "Thành công";
					} else {
						session.save(favourite);
						return "Thành công";
					}
				} else {
					// Xử lý khi realEstateId null hoặc rỗng
					System.out.println("RealEstateId is null or empty");
					return "redirect:/tao-mat-khau.html"; // Redirect to error page or handle as appropriate
				}
			} else {
				// Xử lý khi userId không tồn tại
				System.out.println("User ID not found in cookies");
				return "redirect:/dang-nhap.html"; // Redirect to login page or handle as appropriate
			}
		} catch (NumberFormatException e) {
			// Xử lý khi không thể chuyển đổi realEstateId hoặc userId thành số nguyên
			System.out.println("NumberFormatException occurred: " + e.getMessage());
			return "redirect:/tao-mat-khau.html"; // Redirect to error page or handle as appropriate
		} catch (Exception e) {
			// Xử lý ngoại lệ chung
			System.out.println("Exception occurred: " + e.getMessage());
			return "redirect:/tao-mat-khau.html"; // Redirect to error page or handle as appropriate
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
