package batdongsan.controllers.admin;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Random;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import batdongsan.models.EmployeeModel;
import batdongsan.models.NewsModel;

@Controller
@RequestMapping("/admin/")
public class EmployeeController {
	@Autowired
	SessionFactory factory;

	@RequestMapping("listEmployee")
	public String index(ModelMap model) {
		Session session = factory.openSession();
		String hql = "FROM EmployeeModel ORDER BY createDate DESC";
		Query query = session.createQuery(hql);
		List<EmployeeModel> list = query.list();
		model.addAttribute("employees", list);
		model.addAttribute("employee", new EmployeeModel());
		session.close();
		return "admin/listEmployee";
	}

	// Thêm nhân viên
	@Transactional
	@RequestMapping(value = "listEmployee/addEmployee", method = RequestMethod.POST)
	public String addEmployee(ModelMap model, @ModelAttribute("employee") EmployeeModel employee) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			String id = generateId();
			employee.setId(id);
			Date today = new Date(Calendar.getInstance().getTime().getTime());
			employee.setCreateDate(today);
			employee.setPassword(employee.getPhoneNumber());
			employee.setStatus(true);
			session.save(employee);
			t.commit();
			model.addAttribute("message", "Thêm mới thành công");
		} catch (Exception e) {
			t.rollback();
			model.addAttribute("message", "Thao tác thất bại: " + e.getMessage());
		} finally {
			session.close();
		}
		return "redirect:/admin/listEmployee.html";
	}

	// Xóa nhân viên: Thực ra là chuyển trạng thái thành ẩn (Status)
	public boolean isEmployeeInNews(String id) {
		Session session = factory.openSession();
		String hql = "FROM NewsModel WHERE idWritter = :id";
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<NewsModel> newsList = query.list();
		session.close();
		return !newsList.isEmpty();
	}

	@RequestMapping(value = "listEmployee/delete/{id}", method = RequestMethod.GET)
	public String deleteEmployee(ModelMap model, @PathVariable("id") String id) {
		Session session = factory.openSession();
		Transaction t = null;
		try {
			t = session.beginTransaction();
			EmployeeModel empToDelete = session.get(EmployeeModel.class, id);
			if (empToDelete != null) {
				if (isEmployeeInNews(id)) {
					empToDelete.setStatus(false);
					Date today = new Date(Calendar.getInstance().getTime().getTime());
					empToDelete.setDeleteDate(today);
					session.update(empToDelete);
				} else {
					session.delete(empToDelete);
				}
				t.commit();
			} else {
				model.addAttribute("message", "Nhân viên không tồn tại!");
			}
		} catch (Exception e) {
			if (t != null) {
				t.rollback();
			}
			model.addAttribute("message", "Xóa nhân viên thất bại!");
		} finally {
			session.close();
		}
		return "redirect:/admin/listEmployee.html";
	}

	// Các thao tác cập nhật
	@RequestMapping(value = "listEmployee/update/{id}", method = RequestMethod.GET)
	public String getUpdate(ModelMap model, @PathVariable("id") String id) {
		Session session = factory.openSession();
		String hql = "FROM EmployeeModel WHERE status = :status ORDER BY createDate DESC";
		Query query = session.createQuery(hql);
		query.setParameter("status", true);
		List<EmployeeModel> list = query.list();
		model.addAttribute("employees", list);
		model.addAttribute("employee", new EmployeeModel());

		EmployeeModel emp = (EmployeeModel) session.get(EmployeeModel.class, id);
		model.addAttribute("employee", emp);
		return "admin/listEmployeeUpdate";
	}

	@RequestMapping(value = "listEmployee/update/listEmployee/update", method = RequestMethod.POST)
	public String updateEmp(ModelMap model, @ModelAttribute("employee") EmployeeModel employee) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			EmployeeModel existingEmp = (EmployeeModel) session.get(EmployeeModel.class, employee.getId());
			if (existingEmp != null) {
				existingEmp.setFullname(employee.getFullname());
				existingEmp.setEmail(employee.getEmail());
				existingEmp.setBirthday(employee.getBirthday());
				existingEmp.setPhoneNumber(employee.getPhoneNumber());
				existingEmp.setAddress(employee.getAddress());
				existingEmp.setCccd(employee.getCccd());
				session.merge(existingEmp);
				t.commit();
				model.addAttribute("message", "Cập nhật thành công");
			}
		} catch (Exception e) {
			t.rollback();
			model.addAttribute("message", "Thao tác thất bại: " + e.getMessage());
		} finally {
			session.close();
		}
		// Chuyển hướng người dùng về trang danh sách các danh mục sau khi cập nhật
		return "redirect:/admin/listEmployee.html";
	}

//	@RequestMapping(value = "listEmployee/update/listEmployee/update", method = RequestMethod.POST)
//	public String updateEmployee(@ModelAttribute("employee") EmployeeModel employee) {
//		Session session = factory.openSession();
//		Transaction t = session.beginTransaction();
//		try {
//			session.merge(employee);
//			t.commit();
//		} catch (Exception e) {
//			t.rollback();
//			e.printStackTrace();
//		} finally {
//			session.close();
//		}
//		return "redirect:/admin/listEmployee.html";
//	}

	@RequestMapping(value = "updateEmployee/cancel", method = RequestMethod.GET)
	public String cancelUpdate() {
		return "redirect:/admin/listEmployee.html";
	}
	
	// Chi Tiết nhân viên
	@RequestMapping(value = "listEmployee/detail/{id}", method = RequestMethod.GET)
	public String getDetail(ModelMap model, @PathVariable("id") String id) {
		Session session = factory.openSession();
		String hql = "FROM EmployeeModel WHERE status = :status ORDER BY createDate DESC";
		Query query = session.createQuery(hql);
		query.setParameter("status", true);
		List<EmployeeModel> list = query.list();
		model.addAttribute("employees", list);
		model.addAttribute("employee", new EmployeeModel());

		EmployeeModel emp = (EmployeeModel) session.get(EmployeeModel.class, id);
		
		model.addAttribute("status", emp.isStatus());
		model.addAttribute("employee", emp);
		return "admin/listEmployeeDetail";
	}
	

	// ================================================================
	public static String generateId() {
		java.util.Date now = new java.util.Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("mmss");
		String timeString = dateFormat.format(now);
		Random random = new Random();
		int randomNumber = random.nextInt(10000);
		String randomString = "NV" + timeString + randomNumber;
		return randomString;
	}
}