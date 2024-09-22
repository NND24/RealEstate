package batdongsan.controllers.client;

import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import batdongsan.models.CategoryModel;
import batdongsan.models.DistrictsModel;
import batdongsan.models.HCMDistrictsModel;
import batdongsan.models.HCMWardsModel;
import batdongsan.models.NewsModel;
import batdongsan.models.ProvincesModel;
import batdongsan.models.RealEstateModel;
import batdongsan.models.UsersModel;
import batdongsan.models.WardsModel;

@Controller
public class SellController {
	@Autowired
	SessionFactory factory;

	@RequestMapping(value = { "/nha-dat-ban" }, method = RequestMethod.GET)
	public String getSellPage(HttpServletRequest request,
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
	        @RequestParam(name = "directions", required = false) List<String> directions,
	        @RequestParam(name = "newPost", required = false) String newPost,
	        @RequestParam(name = "priceLowToHigh", required = false) String priceLowToHigh,
	        @RequestParam(name = "priceHighToLow", required = false) String priceHighToLow,
	        @RequestParam(name = "areaLowToHigh", required = false) String areaLowToHigh,
	        @RequestParam(name = "areaHighToLow", required = false) String areaHighToLow,
	        @RequestParam(name = "page", defaultValue = "1") int page,
	        @RequestParam(name = "size", defaultValue = "10") int size) {
	    Session session = factory.openSession();
	    Transaction t = session.beginTransaction();
	    try {
	        // Fetch expired real estates
	        String hqlExpired = "SELECT re FROM RealEstateModel re WHERE re.expirationDate < :today";
	        Query<RealEstateModel> queryExpired = session.createQuery(hqlExpired, RealEstateModel.class);
	        queryExpired.setParameter("today", java.sql.Date.valueOf(LocalDate.now()));
	        List<RealEstateModel> expiredRealEstates = queryExpired.list();

	        // Update status of all real estates to "Ẩn"
	        expiredRealEstates.forEach(re -> {
	            re.setStatus("Ẩn");
	            session.merge(re);
	        });

	        String hql = "SELECT re FROM RealEstateModel re JOIN re.category cat JOIN re.province pro JOIN re.district dis JOIN re.ward ward WHERE re.status = :status AND cat.type LIKE :type";

	        // Search by input
	        if (searchInput != null && !searchInput.isEmpty()) {
	            hql += " AND (address LIKE :searchInput0 OR title LIKE :searchInput1 OR description LIKE :searchInput2 OR cat.name LIKE :searchInput3)";
	        }

	        // Search by category
	        if (categoryIds != null && !categoryIds.isEmpty()) {
	            if (categoryIds.size() == 1) {
	                hql += " AND cat.categoryId = :categoryId0";
	            } else {
	                hql += " AND (cat.categoryId = :categoryId0";
	                for (int i = 1; i < categoryIds.size(); i++) {
	                    hql += " OR cat.categoryId = :categoryId" + i;
	                }
	                hql += ")";
	            }
	        }

	        // Search by address
	        if (provinceId != null && districtId == null && wardId == null) {
	            hql += " AND pro.provinceId = :provinceId";
	        } else if (provinceId != null && districtId != null && wardId == null) {
	            hql += " AND pro.provinceId = :provinceId AND dis.districtId = :districtId";
	        } else if (provinceId != null && districtId != null && wardId != null) {
	            hql += " AND pro.provinceId = :provinceId AND dis.districtId = :districtId AND ward.wardId = :wardId";
	        }

	        // Search by number of bedrooms
	        if (numberOfBedrooms != null && !numberOfBedrooms.isEmpty()) {
	            if (numberOfBedrooms.size() == 1) {
	                hql += " AND re.numberOfBedrooms = :numberOfBedrooms0";
	            } else {
	                hql += " AND (re.numberOfBedrooms = :numberOfBedrooms0";
	                for (int i = 1; i < numberOfBedrooms.size(); i++) {
	                    hql += " OR re.numberOfBedrooms = :numberOfBedrooms" + i;
	                }
	                hql += ")";
	            }
	        }

	        // Search by number of toilets
	        if (numberOfToilets != null && !numberOfToilets.isEmpty()) {
	            if (numberOfToilets.size() == 1) {
	                hql += " AND re.numberOfToilets = :numberOfToilets0";
	            } else {
	                hql += " AND (re.numberOfToilets = :numberOfToilets0";
	                for (int i = 1; i < numberOfToilets.size(); i++) {
	                    hql += " OR re.numberOfToilets = :numberOfToilets" + i;
	                }
	                hql += ")";
	            }
	        }

	        // Search by direction
	        if (directions != null && !directions.isEmpty()) {
	            if (directions.size() == 1) {
	                hql += " AND re.direction = :direction0";
	            } else {
	                hql += " AND (re.direction = :direction0";
	                for (int i = 1; i < directions.size(); i++) {
	                    hql += " OR re.direction = :direction" + i;
	                }
	                hql += ")";
	            }
	        }

	        // Search by price
	        if (minPrice != null && maxPrice != null) {
	            hql += " AND (re.price >= :minPrice AND re.price <= :maxPrice)";
	        }

	        // Search by area
	        if (minArea != null && maxArea != null) {
	            hql += " AND (re.area >= :minArea AND re.area <= :maxArea)";
	        }

	        // Search by unit
	        if (unit != null && !unit.isEmpty()) {
	            hql += " AND re.unit = :unit ";
	        }

	        // ORDER BY
	        String orderByClause = "";

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

	        // Search by type
	        query.setParameter("type", "Nhà đất bán");
	        query.setParameter("status", "Đang hiển thị");

	        if (unit != null && !unit.isEmpty()) {
	            query.setParameter("unit", "Thỏa thuận");
	        }

	        // Search by input
	        if (searchInput != null && !searchInput.isEmpty()) {
	            query.setParameter("searchInput0", "%" + searchInput + "%");
	            query.setParameter("searchInput1", "%" + searchInput + "%");
	            query.setParameter("searchInput2", "%" + searchInput + "%");
	            query.setParameter("searchInput3", "%" + searchInput + "%");
	        }

	        // Search by category
	        if (categoryIds != null && !categoryIds.isEmpty()) {
	            for (int i = 0; i < categoryIds.size(); i++) {
	                query.setParameter("categoryId" + i, categoryIds.get(i));
	            }
	        }

	        // Search by address
	        if (provinceId != null && districtId == null && wardId == null) {
	            query.setParameter("provinceId", provinceId);
	        } else if (provinceId != null && districtId != null && wardId == null) {
	            query.setParameter("provinceId", provinceId);
	            query.setParameter("districtId", districtId);
	        } else if (provinceId != null && districtId != null && wardId != null) {
	            query.setParameter("provinceId", provinceId);
	            query.setParameter("districtId", districtId);
	            query.setParameter("wardId", wardId);
	        }

	        // Search by number of bedrooms
	        if (numberOfBedrooms != null && !numberOfBedrooms.isEmpty()) {
	            for (int i = 0; i < numberOfBedrooms.size(); i++) {
	                query.setParameter("numberOfBedrooms" + i, numberOfBedrooms.get(i));
	            }
	        }

	        if (numberOfToilets != null && !numberOfToilets.isEmpty()) {
	            for (int i = 0; i < numberOfToilets.size(); i++) {
	                query.setParameter("numberOfToilets" + i, numberOfToilets.get(i));
	            }
	        }

	        if (directions != null && !directions.isEmpty()) {
	            for (int i = 0; i < directions.size(); i++) {
	                query.setParameter("direction" + i, directions.get(i));
	            }
	        }

	        if (minPrice != null && maxPrice != null) {
	            query.setParameter("minPrice", minPrice);
	            query.setParameter("maxPrice", maxPrice);
	        }

	        if (minArea != null && maxArea != null) {
	            query.setParameter("minArea", minArea);
	            query.setParameter("maxArea", maxArea);
	        }

	        // Pagination
	        int totalResults = query.list().size();
	        query.setFirstResult((page - 1) * size);
	        query.setMaxResults(size);

	        List<RealEstateModel> listRealEstate = query.list();

	        request.setAttribute("realEstates", listRealEstate);
	        request.setAttribute("page", "sell");
	        request.setAttribute("categoryIds", categoryIds);
	        request.setAttribute("minPrice", minPrice);
	        request.setAttribute("maxPrice", maxPrice);
	        request.setAttribute("unit", unit);
	        request.setAttribute("minArea", minArea);
	        request.setAttribute("maxArea", maxArea);

	        // Pagination attributes
	        request.setAttribute("currentPage", page);
	        request.setAttribute("totalResults", totalResults);
	        request.setAttribute("totalPages", (int) Math.ceil((double) totalResults / size));

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

	        t.commit();
	        return "client/sell";
	    } catch (Exception e) {
	        t.rollback();
	        throw e;
	    } finally {
	        session.close();
	    }
	}


	@RequestMapping(value = { "/nha-dat-cho-thue" }, method = RequestMethod.GET)
	public String getRentPage(HttpServletRequest request,
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
			@RequestParam(name = "directions", required = false) List<String> directions,
			@RequestParam(name = "newPost", required = false) String newPost,
			@RequestParam(name = "priceLowToHigh", required = false) String priceLowToHigh,
			@RequestParam(name = "priceHighToLow", required = false) String priceHighToLow,
			@RequestParam(name = "areaLowToHigh", required = false) String areaLowToHigh,
			@RequestParam(name = "areaHighToLow", required = false) String areaHighToLow,
			@RequestParam(name = "page", defaultValue = "1") int page,
	        @RequestParam(name = "size", defaultValue = "10") int size) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			// Fetch expired real estates
            String hqlExpired = "SELECT re FROM RealEstateModel re WHERE re.expirationDate < :today";
            Query<RealEstateModel> queryExpired = session.createQuery(hqlExpired, RealEstateModel.class);
            queryExpired.setParameter("today", java.sql.Date.valueOf(LocalDate.now()));
            List<RealEstateModel> expiredRealEstates = queryExpired.list();

            // Update status of all real estates to "Ẩn"
            expiredRealEstates.forEach(re -> {
                re.setStatus("Ẩn");
                session.merge(re);
            });
			
			String hql = "SELECT re FROM RealEstateModel re JOIN re.category cat JOIN re.province pro JOIN re.district dis JOIN re.ward ward WHERE re.status = :status AND cat.type LIKE :type";

			// Search by input
			if (searchInput != null && !searchInput.isEmpty()) {
				hql += " AND (address LIKE :searchInput0 OR title LIKE :searchInput1 OR description LIKE :searchInput2 OR cat.name LIKE :searchInput3)";
			}

			// Search by category
			if (categoryIds != null && !categoryIds.isEmpty()) {
				if (categoryIds.size() == 1) {
					hql += " AND cat.categoryId = :categoryId0";
				} else {
					hql += " AND (cat.categoryId = :categoryId0";
					for (int i = 1; i < categoryIds.size(); i++) {
						hql += " OR cat.categoryId = :categoryId" + i;
					}
					hql += ")";
				}
			}

			// Search by address
			if (provinceId != null && districtId == null && wardId == null) {
				hql += " AND pro.provinceId = :provinceId";
			} else if (provinceId != null && districtId != null && wardId == null) {
				hql += " AND pro.provinceId = :provinceId AND dis.districtId = :districtId";
			} else if (provinceId != null && districtId != null && wardId != null) {
				hql += " AND pro.provinceId = :provinceId AND dis.districtId = :districtId AND ward.wardId = :wardId";
			}

			// Search by number of bedrooms
			if (numberOfBedrooms != null && !numberOfBedrooms.isEmpty()) {
				if (numberOfBedrooms.size() == 1) {
					hql += " AND re.numberOfBedrooms = :numberOfBedrooms0";
				} else {
					hql += " AND (re.numberOfBedrooms = :numberOfBedrooms0";
					for (int i = 1; i < numberOfBedrooms.size(); i++) {
						hql += " OR re.numberOfBedrooms = :numberOfBedrooms" + i;
					}
					hql += ")";
				}
			}

			// Search by number of toilets
			if (numberOfToilets != null && !numberOfToilets.isEmpty()) {
				if (numberOfToilets.size() == 1) {
					hql += " AND re.numberOfToilets = :numberOfToilets0";
				} else {
					hql += " AND (re.numberOfToilets = :numberOfToilets0";
					for (int i = 1; i < numberOfToilets.size(); i++) {
						hql += " OR re.numberOfToilets = :numberOfToilets" + i;
					}
					hql += ")";
				}
			}

			// Search by direction
			if (directions != null && !directions.isEmpty()) {
				if (directions.size() == 1) {
					hql += " AND re.direction = :direction0";
				} else {
					hql += " AND (re.direction = :direction0";
					for (int i = 1; i < directions.size(); i++) {
						hql += " OR re.direction = :direction" + i;
					}
					hql += ")";
				}
			}

			// Search by price
			if (minPrice != null && maxPrice != null) {
				hql += " AND (re.price >= :minPrice AND re.price <= :maxPrice)";
			}

			// Search by area
			if (minArea != null && maxArea != null) {
				hql += " AND (re.area >= :minArea AND re.area <= :maxArea)";
			}

			// Search by unit
			if (unit != null && !unit.isEmpty()) {
				hql += " AND re.unit = :unit ";
			}

			// ORDER BY
			String orderByClause = "";

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

			// Search by type
			query.setParameter("type", "Nhà đất cho thuê");
			query.setParameter("status", "Đang hiển thị");

			if (unit != null && !unit.isEmpty()) {
				query.setParameter("unit", "Thỏa thuận");
			}

			// Search by input
			if (searchInput != null && !searchInput.isEmpty()) {
				query.setParameter("searchInput0", "%" + searchInput + "%");
				query.setParameter("searchInput1", "%" + searchInput + "%");
				query.setParameter("searchInput2", "%" + searchInput + "%");
				query.setParameter("searchInput3", "%" + searchInput + "%");
			}

			// Search by category
			if (categoryIds != null && !categoryIds.isEmpty()) {
				for (int i = 0; i < categoryIds.size(); i++) {
					query.setParameter("categoryId" + i, categoryIds.get(i));
				}
			}

			// Search by address
			if (provinceId != null && districtId == null && wardId == null) {
				query.setParameter("provinceId", provinceId);
			} else if (provinceId != null && districtId != null && wardId == null) {
				query.setParameter("provinceId", provinceId);
				query.setParameter("districtId", districtId);
			} else if (provinceId != null && districtId != null && wardId != null) {
				query.setParameter("provinceId", provinceId);
				query.setParameter("districtId", districtId);
				query.setParameter("wardId", wardId);
			}

			// Search by number of bedrooms
			if (numberOfBedrooms != null && !numberOfBedrooms.isEmpty()) {
				for (int i = 0; i < numberOfBedrooms.size(); i++) {
					query.setParameter("numberOfBedrooms" + i, numberOfBedrooms.get(i));
				}
			}

			if (numberOfToilets != null && !numberOfToilets.isEmpty()) {
				for (int i = 0; i < numberOfToilets.size(); i++) {
					query.setParameter("numberOfToilets" + i, numberOfToilets.get(i));
				}
			}

			if (directions != null && !directions.isEmpty()) {
				for (int i = 0; i < directions.size(); i++) {
					query.setParameter("direction" + i, directions.get(i));
				}
			}

			if (minPrice != null && maxPrice != null) {
				query.setParameter("minPrice", minPrice);
				query.setParameter("maxPrice", maxPrice);
			}

			if (minArea != null && maxArea != null) {
				query.setParameter("minArea", minArea);
				query.setParameter("maxArea", maxArea);
			}
			
			// Pagination
	        int totalResults = query.list().size();
	        query.setFirstResult((page - 1) * size);
	        query.setMaxResults(size);

			List<RealEstateModel> listRealEstate = query.list();

			request.setAttribute("realEstates", listRealEstate);
			request.setAttribute("page", "rent");
			request.setAttribute("categoryIds", categoryIds);
			request.setAttribute("minPrice", minPrice);
			request.setAttribute("maxPrice", maxPrice);
			request.setAttribute("unit", unit);
			request.setAttribute("minArea", minArea);
			request.setAttribute("maxArea", maxArea);
			
			// Pagination attributes
	        request.setAttribute("currentPage", page);
	        request.setAttribute("totalResults", totalResults);
	        request.setAttribute("totalPages", (int) Math.ceil((double) totalResults / size));

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

			t.commit();
			return "client/sell";
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
			String hql = "FROM CategoryModel WHERE type = :type AND status=0";
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

	@ModelAttribute("districts")
	public List<HCMDistrictsModel> getProvinces() {
		Session session = factory.openSession();
		String hql = "FROM HCMDistrictsModel";
		Query<HCMDistrictsModel> query = session.createQuery(hql);
		List<HCMDistrictsModel> list = query.list();
		session.close();
		return list;
	}

	@ResponseBody
	@GetMapping("/getDistrictsByProvince")
	public ResponseEntity<byte[]> getDistrictsByProvince(@RequestParam("provinceId") int provinceId) {
		Session session = factory.openSession();
		try {
			String hql = "FROM DistrictsModel WHERE provinceId = :provinceId";
			Query<DistrictsModel> query = session.createQuery(hql);
			query.setParameter("provinceId", provinceId);
			List<DistrictsModel> list = query.list();

			// Tạo một chuỗi text từ danh sách district
			StringBuilder result = new StringBuilder();
			for (DistrictsModel district : list) {
				result.append(district.getDistrictId()).append(":").append(district.getName()).append("\n");
			}

			// Chuyển đổi chuỗi thành mảng byte sử dụng encoding UTF-8
			byte[] data = result.toString().getBytes(StandardCharsets.UTF_8);

			return ResponseEntity.ok().contentType(MediaType.TEXT_PLAIN).body(data);
		} catch (Exception e) {
			System.out.println(e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body("Error occurred while fetching districts".getBytes(StandardCharsets.UTF_8));
		} finally {
			session.close();
		}
	}

	@ResponseBody
	@GetMapping("/getWardsByDistrict")
	public ResponseEntity<byte[]> getWardsByDistrict(@RequestParam("districtId") int districtId) {
		Session session = factory.openSession();
		try {
			String hql = "FROM HCMWardsModel WHERE districtId = :districtId";
			Query<HCMWardsModel> query = session.createQuery(hql);
			query.setParameter("districtId", districtId);
			List<HCMWardsModel> list = query.list();

			// Tạo một chuỗi text từ danh sách district
			StringBuilder result = new StringBuilder();
			for (HCMWardsModel ward : list) {
				result.append(ward.getWardId()).append(":").append(ward.getName()).append("\n");
			}

			// Chuyển đổi chuỗi thành mảng byte sử dụng encoding UTF-8
			byte[] data = result.toString().getBytes(StandardCharsets.UTF_8);

			return ResponseEntity.ok().contentType(MediaType.TEXT_PLAIN).body(data);
		} catch (Exception e) {
			System.out.println(e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body("Error occurred while fetching districts".getBytes(StandardCharsets.UTF_8));
		} finally {
			session.close();
		}
	}

	@ResponseBody
	@GetMapping("/getProvinceById")
	public String getProvinceById(@RequestParam("provinceId") int provinceId) {
		Session session = factory.openSession();
		try {
			String hql = "FROM ProvincesModel WHERE provinceId = :provinceId";
			Query<ProvincesModel> query = session.createQuery(hql);
			query.setParameter("provinceId", provinceId);
			ProvincesModel province = query.uniqueResult();

			return province.getName();
		} catch (Exception e) {
			return "Lỗi";
		} finally {
			session.close();
		}
	}

	@ResponseBody
	@GetMapping("/getDistrictById")
	public String getDistrictById(@RequestParam("districtId") int districtId) {
		Session session = factory.openSession();
		try {
			String hql = "FROM HCMDistrictsModel WHERE provinceId = :provinceId";
			Query<HCMDistrictsModel> query = session.createQuery(hql);
			query.setParameter("districtId", districtId);
			HCMDistrictsModel district = query.uniqueResult();

			return district.getName();
		} catch (Exception e) {
			return "Lỗi";
		} finally {
			session.close();
		}
	}
 
	@ResponseBody
	@GetMapping("/getWardById")
	public String getWardById(@RequestParam("wardId") int wardId) {
		Session session = factory.openSession();
		try {
			String hql = "FROM HCMWardsModel WHERE wardId = :wardId";
			Query<HCMWardsModel> query = session.createQuery(hql);
			query.setParameter("wardId", wardId);
			HCMWardsModel ward = query.uniqueResult();

			return ward.getName();
		} catch (Exception e) {
			return "Lỗi";
		} finally {
			session.close();
		}
	}
}
