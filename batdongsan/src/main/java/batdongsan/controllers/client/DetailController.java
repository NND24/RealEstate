package batdongsan.controllers.client;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import batdongsan.models.CategoryModel;
import batdongsan.models.RealEstateModel;
import batdongsan.models.UsersModel;

@Controller
public class DetailController {
	@Autowired
	SessionFactory factory;
	
    @RequestMapping(value= {"/chi-tiet"}, method = RequestMethod.GET)
    public String index(HttpServletRequest request, @RequestParam("realEstateId") int realEstateId,
    		@RequestParam(name = "searchInput", required = false) String searchInput,
	        @RequestParam(name = "categoryIds", required = false) List<Integer> categoryIds,
	        @RequestParam(name = "provinceId", required = false) Integer provinceId,
	        @RequestParam(name = "districtId", required = false) Integer districtId,
	        @RequestParam(name = "wardId", required = false) Integer wardId,
	        @RequestParam(name = "minPrice", required = false) Float minPrice,
	        @RequestParam(name = "maxPrice", required = false) Float maxPrice,
	        @RequestParam(name = "unit", required = false) String unit,
	        @RequestParam(name = "minArea", required = false) Float minArea,
	        @RequestParam(name = "maxArea", required = false) Float maxArea,
	        @RequestParam(name = "numberOfBedrooms", required = false) List<Integer> numberOfBedrooms,
	        @RequestParam(name = "numberOfToilets", required = false) List<Integer> numberOfToilets,
	        @RequestParam(name = "verify", required = false) String verify,
	        @RequestParam(name = "newPost", required = false) String newPost,
	        @RequestParam(name = "priceLowToHigh", required = false) String priceLowToHigh,
	        @RequestParam(name = "priceHighToLow", required = false) String priceHighToLow,
	        @RequestParam(name = "areaLowToHigh", required = false) String areaLowToHigh,
	        @RequestParam(name = "areaHighToLow", required = false) String areaHighToLow) {
    	Session session = factory.openSession();
		try {
			String hql = "FROM RealEstateModel WHERE realEstateId = :realEstateId";
			Query<RealEstateModel> query = session.createQuery(hql);
			query.setParameter("realEstateId", realEstateId);
			RealEstateModel realEsate = query.getSingleResult();
			
			request.setAttribute("realEstate", realEsate);
			
			String hql1 = "SELECT re FROM RealEstateModel re JOIN re.category cat JOIN re.province pro JOIN re.district dis JOIN re.ward ward WHERE cat.type LIKE :type";
	        
	    	// Search by input
	    	if(searchInput != null && !searchInput.isEmpty()) {
	    		hql1 += " AND (address LIKE :searchInput0 OR title LIKE :searchInput1 OR description LIKE :searchInput2 OR cat.name LIKE :searchInput3)";
	    	}
	    	
	        // Search by category
	        if (categoryIds != null && !categoryIds.isEmpty()) {
	            if (categoryIds.size() == 1) {
	            	hql1 += " AND cat.categoryId = :categoryId0";
	            } else {
	            	hql1 += " AND (cat.categoryId = :categoryId0";
	                for (int i = 1; i < categoryIds.size(); i++) {
	                	hql1 += " OR cat.categoryId = :categoryId" + i;
	                }
	                hql1 += ")";
	            }
	        }
	        
	        // Search by address
	        if(provinceId!=null && districtId==null && wardId==null) {
	        	hql1 += " AND pro.provinceId = :provinceId";
	        } else if(provinceId!=null && districtId!=null && wardId==null) {
	        	hql1 += " AND pro.provinceId = :provinceId AND dis.districtId = :districtId";
	        } else if(provinceId!=null && districtId!=null && wardId!=null) {
	        	hql1 += " AND pro.provinceId = :provinceId AND dis.districtId = :districtId AND ward.wardId = :wardId";
	        }
	        
	        // Search by number of bedrooms
	        if (numberOfBedrooms != null && !numberOfBedrooms.isEmpty()) {
	            if (numberOfBedrooms.size() == 1) {
	            	hql1 += " AND re.numberOfBedrooms = :numberOfBedrooms0";
	            } else {
	            	hql1 += " AND (re.numberOfBedrooms = :numberOfBedrooms0";
	                for (int i = 1; i < numberOfBedrooms.size(); i++) {
	                	hql1 += " OR re.numberOfBedrooms = :numberOfBedrooms" + i;
	                }
	                hql1 += ")";
	            }
	        }
	        
	        // Search by number of toilets
	        if (numberOfToilets != null && !numberOfToilets.isEmpty()) {
	            if (numberOfToilets.size() == 1) {
	            	hql1 += " AND re.numberOfToilets = :numberOfToilets0";
	            } else {
	            	hql1 += " AND (re.numberOfToilets = :numberOfToilets0";
	                for (int i = 1; i < numberOfToilets.size(); i++) {
	                	hql1 += " OR re.numberOfToilets = :numberOfToilets" + i;
	                }
	                hql1 += ")";
	            }
	        }
	        
	        // Search by price
	        if(minPrice != null && maxPrice != null) {
	        	hql1 += " AND (re.price >= :minPrice AND re.price <= :maxPrice)";
	        }
	        
	        // Search by area
	        if(minArea != null && maxArea != null) {
	        	hql1 += " AND (re.area >= :minArea AND re.area <= :maxArea)";
	        }
	        
	        // Search by unit
	        if(unit != null && unit.isEmpty()) {
	        	hql1 += " AND re.unit = 'Thỏa thuận' ";
	        }
	        
	     // ORDER BY
	        String orderByClause = "";
	        if (verify != null) {
	            orderByClause = " ORDER BY updatedDate DESC";
	        }

	        if (newPost != null) {
	            orderByClause = " ORDER BY updatedDate DESC";
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
	        hql1 += orderByClause;

	        Query<RealEstateModel> query1 = session.createQuery(hql1);
	        
	        // Search by type
	        query1.setParameter("type", "Nhà đất bán");
	        
	    	// Search by input
	        if(searchInput != null && !searchInput.isEmpty()) {
	        	query1.setParameter("searchInput0", "%"+searchInput+"%");
	        	query1.setParameter("searchInput1", "%"+searchInput+"%");
	        	query1.setParameter("searchInput2", "%"+searchInput+"%");
	        	query1.setParameter("searchInput3", "%"+searchInput+"%");
	        }

	        // Search by category
	        if (categoryIds != null && !categoryIds.isEmpty()) {
	            for (int i = 0; i < categoryIds.size(); i++) {
	            	query1.setParameter("categoryId" + i, categoryIds.get(i));
	            }
	        }
	        
	        // Search by address
	        if(provinceId!=null && districtId==null && wardId==null) {
	        	query1.setParameter("provinceId", provinceId);
	        } else if(provinceId!=null && districtId!=null && wardId==null) {
	        	query1.setParameter("provinceId", provinceId);
	        	query1.setParameter("districtId", districtId);
	        } else if(provinceId!=null && districtId!=null && wardId!=null) {
	        	query1.setParameter("provinceId", provinceId);
	        	query1.setParameter("districtId", districtId);
	        	query1.setParameter("wardId", wardId);
	        }
	        
	        // Search by number of bedrooms
	        if (numberOfBedrooms != null && !numberOfBedrooms.isEmpty()) {
	            for (int i = 0; i < numberOfBedrooms.size(); i++) {
	            	query1.setParameter("numberOfBedrooms" + i, numberOfBedrooms.get(i));
	            }
	        }
	        
	        if (numberOfToilets != null && !numberOfToilets.isEmpty()) {
	            for (int i = 0; i < numberOfToilets.size(); i++) {
	            	query1.setParameter("numberOfToilets" + i, numberOfToilets.get(i));
	            }
	        }
	        
	        if(minPrice != null && maxPrice != null) {
	        	query1.setParameter("minPrice", minPrice);
	        	query1.setParameter("maxPrice", maxPrice);
	        }
	        
	        if(minArea != null && maxArea != null) {
	        	query1.setParameter("minArea", minArea);
	        	query1.setParameter("maxArea", maxArea);
	        }

	        List<RealEstateModel> realEstates = query.list();

	        request.setAttribute("realEstates", realEstates);
	        request.setAttribute("page", "sell");
	        request.setAttribute("categoryIds", categoryIds);
	        request.setAttribute("minPrice", minPrice);
	        request.setAttribute("maxPrice", maxPrice);
	        request.setAttribute("unit", unit);
	        request.setAttribute("minArea", minArea);
	        request.setAttribute("maxArea", maxArea);
	        
	        request.setAttribute("amountRealEstate", realEstates.size());
	        
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
			
			return "client/detail";
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
