package batdongsan.controllers.admin;

import java.io.PrintWriter;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import batdongsan.models.CategoryModel;
import batdongsan.models.EmployeeModel;
import batdongsan.models.HCMRealEstateModel;
import batdongsan.utils.LoadAdminComponents;

@Controller
@RequestMapping("/admin/")
public class SmartController {
	@Autowired
	SessionFactory factory;

	@RequestMapping(value = { "thong-minh" }, method = RequestMethod.GET)
	public String getListPostPage(HttpServletRequest request, ModelMap model,
	        @RequestParam(name = "searchInput", required = false) String searchInput,
	        @RequestParam(name = "interest", defaultValue = "0", required = false) int interest,
	        @RequestParam(name = "categoryId", defaultValue = "0", required = false) int categoryId,
	        @RequestParam(name = "pageAll", defaultValue = "1") int pageAll,
	        @RequestParam(name = "size", defaultValue = "5") int size) {
	    Session session = factory.openSession();
	    try {
	    	// Load Category
	    	String hql = "FROM CategoryModel c WHERE 1=1 AND c.status = 1";
	        hql += " ORDER BY categoryId ASC";
	        Query<CategoryModel> queryAllCate = session.createQuery(hql, CategoryModel.class);
	        if (searchInput != null && !searchInput.isEmpty()) {
	        	queryAllCate.setParameter("searchInput", "%" + searchInput + "%");
	        }
	        List<CategoryModel> allCategories = queryAllCate.list();
	    	
	    	
	    	
	    	
	    	
	    	// Load Realestate
	    	String hqlAll = "FROM HCMRealEstateModel r WHERE 1=1";
	    	if (interest > 0) {
	    	    hqlAll += " AND r.interestedClick >= :interest";
	    	}
	    	if (searchInput != null && !searchInput.trim().isEmpty()) {
	    	    hqlAll += " AND (r.address LIKE :searchInput OR r.title LIKE :searchInput OR r.description LIKE :searchInput)";
	    	}
	    	if (categoryId > 0) {
	    		hqlAll += " AND r.category.categoryId = :categoryId";
	    	}

	    	Query<HCMRealEstateModel> queryAll = session.createQuery(hqlAll, HCMRealEstateModel.class);
	    	if (interest > 0) {
	    	    queryAll.setParameter("interest", interest);
	    	}
	    	if (searchInput != null && !searchInput.trim().isEmpty()) {
	    	    queryAll.setParameter("searchInput", "%" + searchInput.trim() + "%");
	    	}
	    	if (categoryId > 0) {
	    		queryAll.setParameter("categoryId", categoryId);
	    	}
	        int totalAllResults = queryAll.list().size();
	        queryAll.setFirstResult((pageAll - 1) * size);
	        queryAll.setMaxResults(size);

	        List<HCMRealEstateModel> allRealEstates = queryAll.list();
	        request.setAttribute("allRealEstates", allRealEstates);

	        request.setAttribute("currentAllPage", pageAll);
	        request.setAttribute("totalAllResults", totalAllResults);
	        request.setAttribute("totalAllPages", (int) Math.ceil((double) totalAllResults / size));
	        request.setAttribute("categories", allCategories);
	        
	        EmployeeModel emp = LoadAdminComponents.getEmployeeFromCookies(request, factory);
	        if (emp != null) {
	            model.addAttribute("loginEmp", emp);
	            List<Integer> permissions = LoadAdminComponents.getPermissions(emp.getId(), session);
	            model.addAttribute("permissions", permissions);
	        } else {
	            model.addAttribute("employee", null);
	            model.addAttribute("permissions", Collections.emptyList());
	        }
	        
	        return "admin/listSmartRealEstate";
	    } finally {
	        session.close();
	    }
	}
	
	@RequestMapping(value = { "thong-minh/download" }, method = RequestMethod.GET)
	public void downloadRealEstateCsv(HttpServletResponse response,
	                                  @RequestParam(name = "searchInput", required = false) String searchInput,
	                                  @RequestParam(name = "interest", defaultValue = "0") int interest,
	                                  @RequestParam(name = "categoryId", defaultValue = "0", required = false) int categoryId) {

	    response.setContentType("text/csv");
	    response.setHeader(HttpHeaders.CONTENT_DISPOSITION, "attachment;filename=realestate_data.csv");

	    List<HCMRealEstateModel> realEstateList;
	    try (Session session = factory.openSession()) {
	    	String hqlAll = "FROM HCMRealEstateModel r WHERE 1=1";
	    	if (interest > 0) {
	    	    hqlAll += " AND r.interestedClick >= :interest";
	    	}
	    	if (searchInput != null && !searchInput.trim().isEmpty()) {
	    	    hqlAll += " AND (r.address LIKE :searchInput OR r.title LIKE :searchInput OR r.description LIKE :searchInput)";
	    	}
	    	if (categoryId > 0) {
	    		hqlAll += " AND r.category.categoryId = :categoryId";
	    	}

	    	Query<HCMRealEstateModel> queryAll = session.createQuery(hqlAll, HCMRealEstateModel.class);
	    	if (interest > 0) {
	    	    queryAll.setParameter("interest", interest);
	    	}
	    	if (searchInput != null && !searchInput.trim().isEmpty()) {
	    	    queryAll.setParameter("searchInput", "%" + searchInput.trim() + "%");
	    	}
	    	if (categoryId > 0) {
	    		queryAll.setParameter("categoryId", categoryId);
	    	}
	        realEstateList = queryAll.list();
	    } catch (Exception e) {
	        e.printStackTrace();
	        return;
	    }

	    // Writing CSV data
	    try (PrintWriter writer = response.getWriter()) {
	        // CSV header
	        writer.println("title,price,address,price_m2,rooms,toilets,direction,property_status,balcony_direction,property_legal_document,apartment_type,furnishing_sell,size,apartment_feature");

	        // CSV data rows
	        for (HCMRealEstateModel realEstate : realEstateList) {
	            writer.printf("\"%s\",%d,\"%s\",%.2f,%d,%d,\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",%.2f,\"%s\"%n",
	                sanitizeCsvField(realEstate.getTitle()), // title
	                realEstate.getPrice(), // price
	                sanitizeCsvField(realEstate.getAddress()), // address
	                realEstate.getSize() > 0 ? realEstate.getPrice() / realEstate.getSize() : 0, // price per square meter
	                realEstate.getRooms(), // rooms, fallback to 0 if null
	                realEstate.getToilets(), // toilets, fallback to 0 if null
	                sanitizeCsvField(realEstate.getDirection()), // direction
	                sanitizeCsvField(realEstate.getPropertyStatus()), // property status
	                sanitizeCsvField(realEstate.getBalconyDirection()), // balcony direction
	                sanitizeCsvField(realEstate.getPropertyLegalDocument()), // property legal document
	                "", // apartment_type placeholder
	                sanitizeCsvField(realEstate.getFurnishingSell()), // furnishing sell
	                realEstate.getSize(), // size
	                "" // apartment_feature placeholder
	            );
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}

	// Utility method to handle nulls and escape quotes for CSV
	private String sanitizeCsvField(String field) {
	    return field == null ? "" : field.replace("\"", "\"\"");
	}


}
