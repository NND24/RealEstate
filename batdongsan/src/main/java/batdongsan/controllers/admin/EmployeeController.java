package batdongsan.controllers.admin;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import batdongsan.models.EmployeeModel;
import batdongsan.models.NewsModel;
import batdongsan.models.PermissionModel;
import batdongsan.models.RoleModel;
import batdongsan.utils.LoadAdminComponents;
import batdongsan.utils.PasswordHashing;
import batdongsan.utils.Vadilator;

@Controller
@RequestMapping("/admin/")
public class EmployeeController {
	@Autowired
	SessionFactory factory;

	@RequestMapping(value = "listEmployee", method = RequestMethod.GET)
	public String index(ModelMap model, HttpServletRequest request, 
			@RequestParam(name = "searchInput", required = false) String searchInput,
	        @RequestParam(name = "pageAll", defaultValue = "1") int pageAll,
	        @RequestParam(name = "size", defaultValue = "5") int size) {
		Session session = factory.openSession();
		try {
			EmployeeModel empCurrent = LoadAdminComponents.getEmployeeFromCookies(request, factory);
			String hql = "FROM EmployeeModel e WHERE e.id != :id ";
	        if (searchInput != null && !searchInput.isEmpty()) {
	        	hql += " AND e.id LIKE :searchInput OR e.fullname LIKE :searchInput OR e.email LIKE :searchInput";
	        }
	        hql += " ORDER BY createDate DESC";
	        Query<EmployeeModel> queryAll = session.createQuery(hql, EmployeeModel.class);
	        queryAll.setParameter("id", empCurrent.getId());
	        if (searchInput != null && !searchInput.isEmpty()) {
	            queryAll.setParameter("searchInput", "%" + searchInput + "%");
	        }

	        int totalAllResults = queryAll.list().size();
	        queryAll.setFirstResult((pageAll - 1) * size);
	        queryAll.setMaxResults(size);

	        List<EmployeeModel> employees = queryAll.list();
	        request.setAttribute("employees", employees);
	        request.setAttribute("currentAllPage", pageAll);
	        request.setAttribute("totalAllResults", totalAllResults);
	        request.setAttribute("totalAllPages", (int) Math.ceil((double) totalAllResults / size));
	        
	        LoadAdminComponents.showOnSidebarAndHeader(model, request, session, factory);

	        return "admin/Employee/listEmployee";
	    } finally {
	        session.close();
	    }
	}

	// Thêm nhân viên
	@RequestMapping(value = "listEmployee/add", method = RequestMethod.GET)
	public String add(ModelMap model, HttpServletRequest request) {
		Session session = factory.openSession();
		String hql = "FROM EmployeeModel ORDER BY createDate DESC";
		Query query = session.createQuery(hql);
		List<EmployeeModel> list = query.list();
		model.addAttribute("employees", list);
		model.addAttribute("employee", new EmployeeModel());
		EmployeeModel emp = LoadAdminComponents.getEmployeeFromCookies(request, factory);         
        if (emp != null) {
        	model.addAttribute("loginEmp", emp);
        	List<Integer> permissions = LoadAdminComponents.getPermissions(emp.getId(), session);
            model.addAttribute("permissions", permissions);
        } else {
            model.addAttribute("employee", null);
            model.addAttribute("permissions", Collections.emptyList());
        }
		session.close();
		return "admin/Employee/listEmployeeAdd";
	}

	@Transactional
	@RequestMapping(value = "listEmployee/addEmployee", method = RequestMethod.POST)
	public String addEmployee(ModelMap model, @ModelAttribute("employee") EmployeeModel employee,
			BindingResult errors, HttpServletRequest request) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();

		try {
			// Kiểm tra thông tin nhân viên
			if (employee.getFullname() == null || employee.getFullname().isEmpty()) {
				errors.rejectValue("fullname", "employee", "Vui lòng nhập họ và tên!");
			}
			if (employee.getEmail() == null || employee.getEmail().isEmpty()) {
				errors.rejectValue("email", "employee", "Vui lòng nhập email!");
			} else if (!Vadilator.isValidEmail(employee.getEmail())) {
				errors.rejectValue("email", "employee", "Email không hợp lệ");
			} else if (checkEmpExists(employee.getEmail())) {
				errors.rejectValue("email", "employee", "Email đã tồn tại");
			}
			if (employee.getPhoneNumber() == null || employee.getPhoneNumber().isEmpty()) {
				errors.rejectValue("phoneNumber", "employee", "Vui lòng nhập số điện thoại!");
			} else if (!Vadilator.isValidPhoneNumber(employee.getPhoneNumber())) {
				errors.rejectValue("phoneNumber", "employee", "Số điện thoại không hợp lệ");
			}
			if (employee.getCccd() == null || employee.getCccd().isEmpty()) {
				errors.rejectValue("cccd", "employee", "Vui lòng nhập căn cước!");
			} else if (!Vadilator.isValidCccd(employee.getCccd())) {
				errors.rejectValue("cccd", "employee", "Căn cước không hợp lệ");
			}
			if (errors.hasErrors()) {
				model.addAttribute("message", "Có lỗi");
				String hql = "FROM EmployeeModel ORDER BY createDate DESC";
				Query query = session.createQuery(hql);
				List<EmployeeModel> list = query.list();
				model.addAttribute("employees", list);
				LoadAdminComponents.showOnSidebarAndHeader(model, request, session, factory);
				session.close();
				return "admin/Employee/listEmployeeAdd";
			} else {
				// Xử lý thêm nhân viên
				String id = generateId();
				employee.setId(id);
				Date today = new Date(Calendar.getInstance().getTime().getTime());
				employee.setCreateDate(today);
				String password = PasswordHashing.hashPassword(employee.getPhoneNumber());
				employee.setPassword(password);
				employee.setStatus(true);
				session.save(employee);

				// Xử lý thêm quyền cho nhân viên
				session.flush(); // Đảm bảo các thay đổi trước đó được lưu vào database

				List<RoleModel> roles = session.createQuery("FROM RoleModel").list();
				for (RoleModel role : roles) {
					PermissionModel permission = new PermissionModel();
					permission.setEmployee(employee);
					permission.setRole(role);
					permission.setStatus(false); // Mặc định là False
					session.save(permission);
				}

				t.commit();
			}
		} catch (Exception e) {
			t.rollback();
			model.addAttribute("message", "Thao tác thất bại: " + e.getMessage());
		} finally {
			session.close();
		}
		return "redirect:/admin/listEmployee.html";
	}

	// Xóa nhân viên: Thực ra là chuyển trạng thái thành ẩn (Status)
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
	public String getUpdate(ModelMap model, @PathVariable("id") String id, HttpServletRequest request) {
		Session session = factory.openSession();
		String hql = "FROM EmployeeModel WHERE status = :status ORDER BY createDate DESC";
		Query query = session.createQuery(hql);
		query.setParameter("status", true);
		List<EmployeeModel> list = query.list();
		model.addAttribute("employees", list);
		model.addAttribute("employee", new EmployeeModel());
		EmployeeModel emp = (EmployeeModel) session.get(EmployeeModel.class, id);
		model.addAttribute("employee", emp);
		EmployeeModel empLog = LoadAdminComponents.getEmployeeFromCookies(request, factory);         
        if (empLog != null) {
        	model.addAttribute("loginEmp", empLog);
        	List<Integer> permissions = LoadAdminComponents.getPermissions(empLog.getId(), session);
            model.addAttribute("permissions", permissions);
        } else {
            model.addAttribute("loginEmp", null);
            model.addAttribute("permissions", Collections.emptyList());
        }
		return "admin/Employee/listEmployeeUpdate";
	}

	@RequestMapping(value = "listEmployee/update/{id}", method = RequestMethod.POST)
	public String updateEmp(ModelMap model, @ModelAttribute("employee") EmployeeModel employee, BindingResult errors,
			HttpServletRequest request) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		EmployeeModel existingEmp = (EmployeeModel) session.get(EmployeeModel.class, employee.getId());
		// Kiểm tra họ và tên
		if (employee.getFullname().isEmpty()) {
			errors.rejectValue("fullname", "employee", "Vui lòng nhập họ và tên!");
		}
		// Kiểm tra email
		if (employee.getEmail().isEmpty()) {
			errors.rejectValue("email", "employee", "Vui lòng nhập email!");
		} else if (!Vadilator.isValidEmail(employee.getEmail())) {
			errors.rejectValue("email", "employee", "Email không hợp lệ");
		} else if (checkEmpExists(employee.getEmail()) && !existingEmp.getEmail().equals(employee.getEmail())) {
			errors.rejectValue("email", "employee", "Email đã tồn tại");
		}
		// Kiểm tra số điện thoại
		if (employee.getPhoneNumber().isEmpty()) {
			errors.rejectValue("phoneNumber", "employee", "Vui lòng nhập số điện thoại!");
		} else if (!Vadilator.isValidPhoneNumber(employee.getPhoneNumber())) {
			errors.rejectValue("phoneNumber", "employee", "Số điện thoại không hợp lệ");
		}
		// Kiểm tra căn cước công dân
		if (employee.getCccd().isEmpty()) {
			errors.rejectValue("cccd", "employee", "Vui lòng nhập căn cước!");
		} else if (!Vadilator.isValidCccd(employee.getCccd())) {
			errors.rejectValue("cccd", "employee", "Căn cước không hợp lệ");
		}
		if (errors.hasErrors()) {
			model.addAttribute("message", "Có lỗi");
			String hql = "FROM EmployeeModel ORDER BY createDate DESC";
			Query query = session.createQuery(hql);
			List<EmployeeModel> list = query.list();
			model.addAttribute("employees", list);
			LoadAdminComponents.showOnSidebarAndHeader(model, request, session, factory);
			return "admin/Employee/listEmployeeUpdate";
		}
		try {
			
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

	@RequestMapping(value = "updateEmployee/cancel", method = RequestMethod.GET)
	public String cancelUpdate() {
		return "redirect:/admin/listEmployee.html";
	}

	// Chi Tiết nhân viên
	@RequestMapping(value = "listEmployee/detail/{id}", method = RequestMethod.GET)
	public String getDetail(ModelMap model, @PathVariable("id") String id, HttpServletRequest request) {
		Session session = factory.openSession();
		String hql = "FROM EmployeeModel WHERE status = :status ORDER BY createDate DESC";
		Query query = session.createQuery(hql);
		query.setParameter("status", true);
		List<EmployeeModel> list = query.list();
		model.addAttribute("employees", list);
		model.addAttribute("employee", new EmployeeModel());
		String roleName = getEmployeeRole(session, id);
		model.addAttribute("roleName", roleName);
		EmployeeModel emp = (EmployeeModel) session.get(EmployeeModel.class, id);
		EmployeeModel empLogin = LoadAdminComponents.getEmployeeFromCookies(request, factory);
        model.addAttribute("loginEmp", empLogin);
		model.addAttribute("status", emp.isStatus());
		model.addAttribute("employee", emp);      
		LoadAdminComponents.showOnSidebarAndHeader(model, request, session, factory);
		
		return "admin/Employee/listEmployeeDetail";
	}

	// Phân quyền
	@RequestMapping(value = "listEmployee/authorization/{id}", method = RequestMethod.GET)
	public String authorization(@PathVariable("id") String id, ModelMap model) {
		Session session = factory.openSession();
		String hql = "FROM EmployeeModel WHERE status = :status ORDER BY createDate DESC";
		Query query = session.createQuery(hql);
		query.setParameter("status", true);
		List<EmployeeModel> list = query.list();
		model.addAttribute("employees", list);

		EmployeeModel emp = (EmployeeModel) session.get(EmployeeModel.class, id);
		model.addAttribute("employee", emp);

		// Lấy danh sách vai trò chỉ cho nhân viên được chỉ định
		List<RoleModel> roles = session.createQuery(
				"SELECT p.role FROM PermissionModel p WHERE p.employee.id = :employeeId")
				.setParameter("employeeId", id).list();
		model.addAttribute("roles", roles);

		// Lấy danh sách quyền cho mỗi vai trò
		Map<RoleModel, List<PermissionModel>> rolePermissions = new HashMap<>();
		for (RoleModel role : roles) {
			Query queryAuth = session
					.createQuery("FROM PermissionModel p WHERE p.role = :role AND p.employee.id = :employeeId");
			queryAuth.setParameter("role", role);
			queryAuth.setParameter("employeeId", id);
			List<PermissionModel> permissions = queryAuth.list();
			rolePermissions.put(role, permissions);
		}
		model.addAttribute("rolePermissions", rolePermissions);
		PermissionModel permission = new PermissionModel();
		permission.setEmployee(emp); // Set id của nhân viên cho permission
		model.addAttribute("permissions", permission);
		session.close();
		return "admin/Employee/listEmployeeAuthorization";
	}

	@RequestMapping(value = "listEmployee/authorization/confirm", method = RequestMethod.POST)
	public String updatePermissions(ModelMap model, @RequestParam("permissionIds") List<Integer> permissionIds,
			@RequestParam(value = "unselectedPermissionIds", required = false) List<Integer> unselectedPermissionIds) {
		Session session = factory.openSession();
		Transaction t = null;
		try {
			t = session.beginTransaction();
			for (Integer permissionId : permissionIds) {
				PermissionModel permission = (PermissionModel) session.get(PermissionModel.class, permissionId);
				permission.setStatus(true);
				session.merge(permission);
			}

			if (unselectedPermissionIds != null && !unselectedPermissionIds.isEmpty()) {
				for (Integer unselectedPermissionId : unselectedPermissionIds) {
					PermissionModel unselectedPermission = session.get(PermissionModel.class, unselectedPermissionId);
					unselectedPermission.setStatus(false);
					session.merge(unselectedPermission);
				}
			}
			// Commit transaction sau khi cập nhật thành công
			t.commit();
			model.addAttribute("message", "Cập nhật thành công");
		} catch (Exception e) {
			if (t != null) {
				t.rollback();
			}
			model.addAttribute("message", "Thao tác thất bại: " + e.getMessage());
			e.printStackTrace(); // In ra lỗi để debug
		} finally {
			// Đóng session sau khi sử dụng xong
			session.close();
		}
		// Chuyển hướng người dùng về trang danh sách nhân viên sau khi cập nhật
		return "redirect:/admin/listEmployee.html";
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

	private boolean checkEmpExists(String email) {
		Session session = factory.openSession();
		List<EmployeeModel> employees = new ArrayList<>();
		try {
			String hql = "FROM EmployeeModel WHERE email = :email";
			Query<EmployeeModel> query = session.createQuery(hql, EmployeeModel.class);
			query.setParameter("email", email);
			employees = query.list();
		} finally {
			session.close();
		}
		return !employees.isEmpty();
	}

	public boolean isEmployeeInNews(String id) {
		Session session = factory.openSession();
		String hql = "FROM NewsModel WHERE idWritter = :id";
		Query query = session.createQuery(hql);
		query.setParameter("id", id);
		List<NewsModel> newsList = query.list();
		session.close();
		return !newsList.isEmpty();
	}

	private String getEmployeeRole(Session session, String empId) {
		String hql = "SELECT r.roleName FROM RoleModel r " + "JOIN r.permissions p "
				+ "WHERE p.employee.id = :empId AND p.status = true";
		Query<String> query = session.createQuery(hql, String.class);
		query.setParameter("empId", empId);
		// Execute the query and get the list of role names
		List<String> roleNames = query.list();
		// Join the role names into a single string
		String roles = String.join(", ", roleNames);
		return roles;
	}

}