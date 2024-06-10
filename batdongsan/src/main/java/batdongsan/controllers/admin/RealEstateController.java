package batdongsan.controllers.admin;

import java.util.List;

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

import batdongsan.models.RealEstateModel;

@Controller
@RequestMapping("/admin/")
public class RealEstateController {
	@Autowired
	SessionFactory factory;

	@RequestMapping(value = { "quan-ly-bat-dong-san" }, method = RequestMethod.GET)
	public String getListPostPage(HttpServletRequest request,
	        @RequestParam(name = "searchInput", required = false) String searchInput,
	        @RequestParam(name = "pageAll", defaultValue = "1") int pageAll,
	        @RequestParam(name = "size", defaultValue = "5") int size) {
	    Session session = factory.openSession();
	    try {
	        String hqlAll = "FROM RealEstateModel r";
	        if (searchInput != null && !searchInput.isEmpty()) {
	            hqlAll += " WHERE r.address LIKE :searchInput OR r.title LIKE :searchInput OR r.description LIKE :searchInput";
	        }
	        Query<RealEstateModel> queryAll = session.createQuery(hqlAll, RealEstateModel.class);
	        if (searchInput != null && !searchInput.isEmpty()) {
	            queryAll.setParameter("searchInput", "%" + searchInput + "%");
	        }

	        int totalAllResults = queryAll.list().size();
	        queryAll.setFirstResult((pageAll - 1) * size);
	        queryAll.setMaxResults(size);

	        List<RealEstateModel> allRealEstates = queryAll.list();
	        request.setAttribute("allRealEstates", allRealEstates);

	        request.setAttribute("currentAllPage", pageAll);
	        request.setAttribute("totalAllResults", totalAllResults);
	        request.setAttribute("totalAllPages", (int) Math.ceil((double) totalAllResults / size));

	        return "admin/listRealEstate";
	    } finally {
	        session.close();
	    }
	}

	
	@RequestMapping(value= {"/chi-tiet"}, method = RequestMethod.GET)
    public String getDetailPage(HttpServletRequest request, @RequestParam("realEstateId") int realEstateId) {
    	Session session = factory.openSession();
		try {
			String hql = "FROM RealEstateModel WHERE realEstateId = :realEstateId";
			Query<RealEstateModel> query = session.createQuery(hql);
			query.setParameter("realEstateId", realEstateId);
			RealEstateModel realEsate = query.getSingleResult();
			
			request.setAttribute("realEstate", realEsate);
			
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
			String hql = "FROM RealEstateModel WHERE realEstateId = :realEstateId";
			Query<RealEstateModel> query = session.createQuery(hql);
			query.setParameter("realEstateId", realEstateId);
			RealEstateModel deletedRealEstate = query.uniqueResult();
			
			session.delete(deletedRealEstate);
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
			String hql = "FROM RealEstateModel WHERE realEstateId = :realEstateId";
			Query<RealEstateModel> query = session.createQuery(hql);
			query.setParameter("realEstateId", realEstateId);
			RealEstateModel updatedRealEstate = query.uniqueResult();
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
	        String hql = "FROM RealEstateModel WHERE realEstateId = :realEstateId";
	        Query<RealEstateModel> query = session.createQuery(hql);
	        query.setParameter("realEstateId", realEstateId);
	        RealEstateModel updatedRealEstate = query.uniqueResult();

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
