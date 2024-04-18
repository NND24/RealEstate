package batdongsan.controllers;

import java.nio.charset.StandardCharsets;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import batdongsan.models.CategoryModel;
import batdongsan.models.DistrictsModel;
import batdongsan.models.ProvincesModel;
import batdongsan.models.RealEstateModel;
import batdongsan.models.WardsModel;

@Controller
public class FavouriteController {
	@Autowired
	SessionFactory factory;

	@RequestMapping(value = { "/tin-da-luu" }, method = RequestMethod.GET)
	public String getFavoutirePage(HttpServletRequest request, 
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
	        @RequestParam(name = "areaHighToLow", required = false) String areaHighToLow
	        ) {
	    Session session = factory.openSession();
	    try {
	    	String hql = "SELECT re FROM RealEstateModel re JOIN re.category cat JOIN re.province pro JOIN re.district dis JOIN re.ward ward WHERE cat.type LIKE :type";
	        
	    	// Search by input
	    	if(searchInput != null && !searchInput.isEmpty()) {
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
	        if(provinceId!=null && districtId==null && wardId==null) {
	        	hql += " AND pro.provinceId = :provinceId";
	        } else if(provinceId!=null && districtId!=null && wardId==null) {
	        	hql += " AND pro.provinceId = :provinceId AND dis.districtId = :districtId";
	        } else if(provinceId!=null && districtId!=null && wardId!=null) {
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
	        
	        // Search by price
	        if(minPrice != null && maxPrice != null) {
	            hql += " AND (re.price >= :minPrice AND re.price <= :maxPrice)";
	        }
	        
	        // Search by area
	        if(minArea != null && maxArea != null) {
	            hql += " AND (re.area >= :minArea AND re.area <= :maxArea)";
	        }
	        
	        // Search by unit
	        if(unit != null && unit.isEmpty()) {
	            hql += " AND re.unit = 'Thỏa thuận' ";
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
	        hql += orderByClause;

	        Query<RealEstateModel> query = session.createQuery(hql);
	        
	        // Search by type
	        query.setParameter("type", "Nhà đất bán");
	        
	    	// Search by input
	        if(searchInput != null && !searchInput.isEmpty()) {
		        query.setParameter("searchInput0", "%"+searchInput+"%");
		        query.setParameter("searchInput1", "%"+searchInput+"%");
		        query.setParameter("searchInput2", "%"+searchInput+"%");
		        query.setParameter("searchInput3", "%"+searchInput+"%");
	        }

	        // Search by category
	        if (categoryIds != null && !categoryIds.isEmpty()) {
	            for (int i = 0; i < categoryIds.size(); i++) {
	                query.setParameter("categoryId" + i, categoryIds.get(i));
	            }
	        }
	        
	        // Search by address
	        if(provinceId!=null && districtId==null && wardId==null) {
	        	query.setParameter("provinceId", provinceId);
	        } else if(provinceId!=null && districtId!=null && wardId==null) {
	        	query.setParameter("provinceId", provinceId);
	        	query.setParameter("districtId", districtId);
	        } else if(provinceId!=null && districtId!=null && wardId!=null) {
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
	        
	        if(minPrice != null && maxPrice != null) {
	            query.setParameter("minPrice", minPrice);
	            query.setParameter("maxPrice", maxPrice);
	        }
	        
	        if(minArea != null && maxArea != null) {
	            query.setParameter("minArea", minArea);
	            query.setParameter("maxArea", maxArea);
	        }

	        List<RealEstateModel> listRealEstate = query.list();

	        request.setAttribute("realEstates", listRealEstate);
	        request.setAttribute("page", "sell");
	        request.setAttribute("categoryIds", categoryIds);
	        request.setAttribute("minPrice", minPrice);
	        request.setAttribute("maxPrice", maxPrice);
	        request.setAttribute("unit", unit);
	        request.setAttribute("minArea", minArea);
	        request.setAttribute("maxArea", maxArea);
	        
	        request.setAttribute("amountRealEstate", listRealEstate.size());
	                
	        return "client/favourite";
	    } finally {
	        session.close();
	    }
	}
}
