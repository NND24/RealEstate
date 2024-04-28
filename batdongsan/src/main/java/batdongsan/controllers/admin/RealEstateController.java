package batdongsan.controllers.admin;

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
@RequestMapping("/admin/")
public class RealEstateController {
	@Autowired
	SessionFactory factory;

	@RequestMapping(value = { "quan-ly-bat-dong-san" }, method = RequestMethod.GET)
	public String getListPostPage(HttpServletRequest request,
			@RequestParam(name = "searchInput", required = false) String searchInput) {
		Session session = factory.openSession();
		try {
			String hqlAll = "FROM RealEstateModel";
			Query<RealEstateModel> queryAll = session.createQuery(hqlAll);
			List<RealEstateModel> allRealEstates = queryAll.list();
			request.setAttribute("allRealEstates", allRealEstates);
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
