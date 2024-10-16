package batdongsan.controllers.admin;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import batdongsan.models.EmployeeModel;
import batdongsan.models.HCMRealEstateModel;
import batdongsan.models.UsersModel;


@Controller
@RequestMapping("/admin/")
public class UserController {
	@Autowired
	SessionFactory factory;

	@RequestMapping("listUser")
	public String index(ModelMap model, HttpServletRequest request,
	                    @RequestParam(name = "searchInput", required = false) String searchInput,
	                    @RequestParam(name = "filter", required = false) Boolean filter,
	                    @RequestParam(name = "pageAll", defaultValue = "1") int pageAll,
	                    @RequestParam(name = "size", defaultValue = "5") int size) {
	    Session session = factory.openSession();
	    try {
	        String hql = "FROM UsersModel u WHERE 1=1";
	        if (searchInput != null && !searchInput.isEmpty()) {
	            hql += " AND (u.name LIKE :searchInput)";
	        }
	        hql += " ORDER BY userId ASC";
	        Query<UsersModel> queryAll = session.createQuery(hql, UsersModel.class);
	        if (searchInput != null && !searchInput.isEmpty()) {
	            queryAll.setParameter("searchInput", "%" + searchInput + "%");
	        }
	        if (filter != null) {
	            queryAll.setParameter("filter", filter);
	        }
	        int totalAllResults = queryAll.list().size();
	        queryAll.setFirstResult((pageAll - 1) * size);
	        queryAll.setMaxResults(size);

	        List<UsersModel> allUser = queryAll.list();
	        
	        System.out.println("User list: " + allUser);

	        request.setAttribute("listUsers", allUser);
	        request.setAttribute("currentAllPage", pageAll);
	        request.setAttribute("totalAllResults", totalAllResults);
	        request.setAttribute("totalAllPages", (int) Math.ceil((double) totalAllResults / size));
	        showOnSidebarAndHeader(model,request,session);
	        
	        return "admin/User/listUser";
	    } finally {
	        session.close();
	    }
	}
	
	// Xem chi tiết người dùng
	@RequestMapping(value = "/listUser/detail/{userId}", method = RequestMethod.GET)
	public String getDetail(ModelMap model, @PathVariable("userId") String userId, HttpServletRequest request) {
		Session session = factory.openSession();
		Integer id = Integer.parseInt(userId);
		String hql = "FROM UsersModel WHERE userId = :userId";
		Query<UsersModel> query = session.createQuery(hql);
		query.setParameter("userId", id);
		UsersModel user = query.uniqueResult();
		model.addAttribute("user", user);
		
		String hqlSell = "SELECT re FROM HCMRealEstateModel re JOIN re.category cat JOIN re.user AS user WHERE re.status = :status AND user.userId = :userId AND cat.type LIKE :type";
        Query<HCMRealEstateModel> querySell = session.createQuery(hqlSell);
        querySell.setParameter("userId", id);
        querySell.setParameter("type", "Nhà đất bán");
        querySell.setParameter("status", "Đang hiển thị");
        List<HCMRealEstateModel> sellRealEstates = querySell.list();
        model.addAttribute("sellRealEstates", sellRealEstates);
		
		showOnSidebarAndHeader(model,request,session);
		return "admin/User/detailUser";
	}
	
	// Khóa/Mở khóa tài khoản người dùng (Status)
		@RequestMapping(value = "listUser/change-status/{userId}", method = RequestMethod.GET)
		public String changeStatus(ModelMap model, @PathVariable("userId") String userId) {
			Session session = factory.openSession();
			Transaction t = null;
			try {
				t = session.beginTransaction();
				Integer id = Integer.parseInt(userId);
				UsersModel userToChangeStatus = session.get(UsersModel.class, id);
				if (userToChangeStatus == null)
					model.addAttribute("message", "Lỗi đổi trạng thái!");
				else {
					if(userToChangeStatus.getStatus() == true) {
						userToChangeStatus.setStatus(false);
					} else {
						userToChangeStatus.setStatus(true);
					}
					session.update(userToChangeStatus);
					t.commit();
				}
			} catch (Exception e) {
				if (t != null) {
					t.rollback();
				}
				e.printStackTrace();
				model.addAttribute("message", "Thất bại!");
			} finally {
				session.close();
			}
			return "redirect:/admin/listUser.html";
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

	// lấy id Nhân viên từ khi đăng nhập
	private EmployeeModel getEmployeeFromCookies(HttpServletRequest request) {
		Session session = factory.openSession();
		Cookie[] cookies = request.getCookies();
		String empId = null;

		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("id")) {
					empId = cookie.getValue();
					System.out.println(empId);
					break;
				}
			}
		}

		if (empId != null) {
			String hqlEmp = "FROM EmployeeModel WHERE id = :id";
			Query<EmployeeModel> queryEmp = session.createQuery(hqlEmp, EmployeeModel.class);
			queryEmp.setParameter("id", empId);
			EmployeeModel emp = queryEmp.uniqueResult();
			return emp;
		} else {
			System.out.println("Không tìm thấy");
			return null;
		}
	}
	
	private List<Integer> getPermissions(String empId, Session session) {
	    String hqlPermissions = "SELECT role.roleId FROM PermissionModel WHERE employee.id = :idEmp AND status = true";
	    Query<Integer> queryPermissions = session.createQuery(hqlPermissions, Integer.class);
	    queryPermissions.setParameter("idEmp", empId);
	    return queryPermissions.getResultList();
	}
	
	private void showOnSidebarAndHeader(ModelMap model, HttpServletRequest request, Session session) {
		EmployeeModel emp = getEmployeeFromCookies(request);
        if (emp != null) {
            model.addAttribute("loginEmp", emp);
            List<Integer> permissions = getPermissions(emp.getId(), session);
            model.addAttribute("permissions", permissions);
        } else {
            model.addAttribute("employee", null);
            model.addAttribute("permissions", Collections.emptyList());
        }
	}
	

}