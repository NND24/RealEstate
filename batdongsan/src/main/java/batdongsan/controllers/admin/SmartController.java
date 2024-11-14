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
	        if(categoryId  > 0) {	        	
	        	request.setAttribute("categoryId", categoryId);
	        }
	        
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

	    // Determine the filename based on categoryId
	    String filename;
	    switch (categoryId) {
	        case 1:
	            filename = "home_data.csv";
	            break;
	        case 2:
	            filename = "apartment_data.csv";
	            break;
	        case 3:
	            filename = "commercial_data.csv";
	            break;
	        case 4:
	            filename = "land_data.csv";
	            break;
	        default:
	            filename = "realestate_data.csv";
	            break;
	    }

	    response.setContentType("text/csv");
	    response.setHeader(HttpHeaders.CONTENT_DISPOSITION, "attachment;filename=" + filename);

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
	        // Custom CSV header based on categoryId
	        switch (categoryId) {
	            case 1: 
	                writer.println("DistrictId,WardId,StreetId,Size,Rooms,Toilets,Floors,Type,FurnishingSell,Characteristics,Urgent,Price");
	                break;
	            case 2: 
	                writer.println("DistrictId,WardId,StreetId,Size,Rooms,Toilets,Type,FurnishingSell,Urgent,Price");
	                break;
	            case 3: 
	                writer.println("DistrictId,WardId,StreetId,Size,Type,FurnishingSell,Urgent,Price");
	                break;
	            case 4: 
	                writer.println("DistrictId,WardId,StreetId,Size,Type,Characteristics,Urgent,Price");
	                break;
	            default:
	                writer.println("DistrictId,WardId,StreetId,Size,Rooms,Toilets,Floors,Type,FurnishingSell,Characteristics,Urgent,Price");
	                break;
	        }

	        // CSV data rows based on categoryId
	        for (HCMRealEstateModel realEstate : realEstateList) {
	            switch (categoryId) {
	                case 1: 
	                	 writer.printf("%d,%d,%d,%.2f,%d,%d,%d,\"%s\",\"%s\",\"%s\",%d,%d%n",
	                             realEstate.getStreet().getWard().getDistrict().getDistrictId(), // DistrictId (int)
	                             realEstate.getStreet().getWard().getWardId(), // WardId (int)
	                             realEstate.getStreet().getStreetId(), // StreetId (int)
	                             realEstate.getSize(), // Size (float)
	                             realEstate.getRooms(), // Rooms (int)
	                             realEstate.getToilets(), // Toilets (int)
	                             realEstate.getFloors(), // Floors (int)
	                             sanitizeCsvField(realEstate.getType()), // Type (String)
	                             sanitizeCsvField(realEstate.getFurnishingSell()), // FurnishingSell (String)
	                             sanitizeCsvField(realEstate.getCharacteristics()), // Characteristics (String)
	                             realEstate.isUrgent() ? 1 : 0, // Urgent (1 if true, 0 if false)
	                             realEstate.getPrice() // Price (Long)
	                         );
	                    break;
	                case 2: 
	                	 writer.printf("%d,%d,%d,%.2f,%d,%d,\"%s\",\"%s\",%d,%d%n",
	                             realEstate.getStreet().getWard().getDistrict().getDistrictId(), // DistrictId (int)
	                             realEstate.getStreet().getWard().getWardId(), // WardId (int)
	                             realEstate.getStreet().getStreetId(), // StreetId (int)
	                             realEstate.getSize(), // Size (float)
	                             realEstate.getRooms(), // Rooms (int)
	                             realEstate.getToilets(), // Toilets (int)
	                             sanitizeCsvField(realEstate.getType()), // Type (String)
	                             sanitizeCsvField(realEstate.getFurnishingSell()), // FurnishingSell (String)
	                             realEstate.isUrgent() ? 1 : 0, // Urgent (1 if true, 0 if false)
	                             realEstate.getPrice() // Price (Long)
	                         );
	                    break;
	                case 3: 
	                	writer.printf("%d,%d,%d,%.2f,\"%s\",\"%s\",%d,%d%n",
	                            realEstate.getStreet().getWard().getDistrict().getDistrictId(), // DistrictId (int)
	                            realEstate.getStreet().getWard().getWardId(), // WardId (int)
	                             realEstate.getStreet().getStreetId(), // StreetId (int)
	                            realEstate.getSize(), // Size (float)
	                            sanitizeCsvField(realEstate.getType()), // Type (String)
	                            sanitizeCsvField(realEstate.getFurnishingSell()), // FurnishingSell (String)
	                            realEstate.isUrgent() ? 1 : 0, // Urgent (1 if true, 0 if false)
	                            realEstate.getPrice() // Price (Long)
	                        );
	                    break;
	                case 4: 
	                	writer.printf("%d,%d,%d,%.2f,\"%s\",\"%s\",%d,%d%n",
	                            realEstate.getStreet().getWard().getDistrict().getDistrictId(), // DistrictId (int)
	                            realEstate.getStreet().getWard().getWardId(), // WardId (int)
	                             realEstate.getStreet().getStreetId(), // StreetId (int)
	                            realEstate.getSize(), // Size (float)
	                            sanitizeCsvField(realEstate.getType()), // Type (String)
	                            sanitizeCsvField(realEstate.getCharacteristics()), // Characteristics (String)
	                            realEstate.isUrgent() ? 1 : 0, // Urgent (1 if true, 0 if false)
	                            realEstate.getPrice() // Price (Long)
	                        );
	                    break;
	                default:
	                	writer.printf("%d,%d,%d,%.2f,%d,%d,%d,\"%s\",\"%s\",\"%s\",%d,%d%n",
	                             realEstate.getStreet().getWard().getDistrict().getDistrictId(), // DistrictId (int)
	                             realEstate.getStreet().getWard().getWardId(), // WardId (int)
	                             realEstate.getStreet().getStreetId(), // StreetId (int)
	                             realEstate.getSize(), // Size (float)
	                             realEstate.getRooms(), // Rooms (int)
	                             realEstate.getToilets(), // Toilets (int)
	                             realEstate.getFloors(), // Floors (int)
	                             sanitizeCsvField(realEstate.getType()), // Type (String)
	                             sanitizeCsvField(realEstate.getFurnishingSell()), // FurnishingSell (String)
	                             sanitizeCsvField(realEstate.getCharacteristics()), // Characteristics (String)
	                             realEstate.isUrgent() ? 1 : 0, // Urgent (1 if true, 0 if false)
	                             realEstate.getPrice() // Price (Long)
	                         );
	                    break;
	            }
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
