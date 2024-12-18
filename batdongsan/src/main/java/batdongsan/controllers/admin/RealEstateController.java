package batdongsan.controllers.admin;

import java.util.Collections;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import batdongsan.models.CategoryModel;
import batdongsan.models.EmployeeModel;
import batdongsan.models.HCMRealEstateModel;
import batdongsan.utils.LoadAdminComponents;

@Controller
@RequestMapping("/admin/")
public class RealEstateController {
	@Autowired
	SessionFactory factory;

	@RequestMapping(value = { "quan-ly-bat-dong-san" }, method = RequestMethod.GET)
	public String getListPostPage(HttpServletRequest request, ModelMap model,
	        @RequestParam(name = "searchInput", required = false) String searchInput,
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
	    	if (searchInput != null && !searchInput.trim().isEmpty()) {
	    	    hqlAll += " AND (r.address LIKE :searchInput OR r.title LIKE :searchInput OR r.description LIKE :searchInput)";
	    	}
	    	if (categoryId > 0) {
	    		hqlAll += " AND r.category.categoryId = :categoryId";
	    	}

	    	Query<HCMRealEstateModel> queryAll = session.createQuery(hqlAll, HCMRealEstateModel.class);
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
	        
	        return "admin/listRealEstate";
	    } finally {
	        session.close();
	    }
	}

	
	@RequestMapping(value= {"/chi-tiet"}, method = RequestMethod.GET)
    public String getDetailPage(HttpServletRequest request, @RequestParam("realEstateId") int realEstateId, ModelMap model) {
    	Session session = factory.openSession();
		try {
			String hql = "FROM HCMRealEstateModel WHERE realEstateId = :realEstateId";
			Query<HCMRealEstateModel> query = session.createQuery(hql);
			query.setParameter("realEstateId", realEstateId);
			HCMRealEstateModel realEsate = query.getSingleResult();
			
			request.setAttribute("realEstate", realEsate);
			
			EmployeeModel emp = LoadAdminComponents.getEmployeeFromCookies(request, factory);
	        if (emp != null) {
	            model.addAttribute("loginEmp", emp);
	            List<Integer> permissions = LoadAdminComponents.getPermissions(emp.getId(), session);
	            model.addAttribute("permissions", permissions);
	        } else {
	            model.addAttribute("employee", null);
	            model.addAttribute("permissions", Collections.emptyList());
	        }
			
			return "admin/detailRealEstate";
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
			String hql = "FROM HCMRealEstateModel WHERE realEstateId = :realEstateId";
			Query<HCMRealEstateModel> query = session.createQuery(hql);
			query.setParameter("realEstateId", realEstateId);
			HCMRealEstateModel deletedRealEstate = query.uniqueResult();
			
			if  ( deletedRealEstate.getInterestedClick() <= 0 ) {
				session.delete(deletedRealEstate);
			}
			else {
				deletedRealEstate.setDeleteStatus(true);
				session.update(deletedRealEstate);
			}
			t.commit();
			return "redirect:/admin/quan-ly-bat-dong-san.html";
		} catch (Exception e) {
			t.rollback();
			e.printStackTrace();
			return "redirect:/admin/quan-ly-bat-dong-san.html";
		} finally {
			session.close();
		}
	}
	
	@RequestMapping(value = "browseRealEstate", method = RequestMethod.GET)
	public String browseRealEstate(ModelMap model, HttpServletRequest request,
			@RequestParam(name = "realEstateId") Integer realEstateId) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			String hql = "FROM HCMRealEstateModel WHERE realEstateId = :realEstateId";
			Query<HCMRealEstateModel> query = session.createQuery(hql);
			query.setParameter("realEstateId", realEstateId);
			HCMRealEstateModel updatedRealEstate = query.uniqueResult();
			updatedRealEstate.setStatus("Đang hiển thị");
			
			session.update(updatedRealEstate);
			t.commit();
			return "redirect:/admin/quan-ly-bat-dong-san.html";
		} catch (Exception e) {
			t.rollback();
			e.printStackTrace();
			return "redirect:/admin/quan-ly-bat-dong-san.html";
		} finally {
			session.close();
		}
	}
	
	@RequestMapping(value = "hideDisplayRealEstate", method = RequestMethod.GET)
	public String hideDisplayRealEstate(ModelMap model, HttpServletRequest request,
	        @RequestParam(name = "realEstateId") Integer realEstateId) {
	    Session session = factory.openSession();
	    Transaction t = session.beginTransaction();
	    try {
	        String hql = "FROM HCMRealEstateModel WHERE realEstateId = :realEstateId";
	        Query<HCMRealEstateModel> query = session.createQuery(hql);
	        query.setParameter("realEstateId", realEstateId);
	        HCMRealEstateModel updatedRealEstate = query.uniqueResult();

	        String status = updatedRealEstate.getStatus();
	        if ("Đang hiển thị".equals(status)) {
	            updatedRealEstate.setStatus("Ẩn");
	        } else if ("Chưa được duyệt".equals(status)) {
	            updatedRealEstate.setStatus("Chưa được duyệt");
	        } else {
	            updatedRealEstate.setStatus("Đang hiển thị");
	        }

	        session.update(updatedRealEstate);
	        t.commit();
	        return "redirect:/admin/quan-ly-bat-dong-san.html";
	    } catch (Exception e) {
	        t.rollback();
	        e.printStackTrace();
	        return "redirect:/admin/quan-ly-bat-dong-san.html";
	    } finally {
	        session.close();
	    }
	}

}
