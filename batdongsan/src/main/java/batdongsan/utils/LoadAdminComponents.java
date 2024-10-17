package batdongsan.utils;

import java.util.Collections;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;

import batdongsan.models.EmployeeModel;

public class LoadAdminComponents {

	// lấy id Nhân viên từ khi đăng nhập
	public static EmployeeModel getEmployeeFromCookies(HttpServletRequest request, SessionFactory factory) {
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

	public static List<Integer> getPermissions(String empId, Session session) {
		String hqlPermissions = "SELECT role.roleId FROM PermissionModel WHERE employee.id = :idEmp AND status = true";
		Query<Integer> queryPermissions = session.createQuery(hqlPermissions, Integer.class);
		queryPermissions.setParameter("idEmp", empId);
		return queryPermissions.getResultList();
	}

	public static void showOnSidebarAndHeader(ModelMap model, HttpServletRequest request, Session session, SessionFactory factory) {
		EmployeeModel emp = getEmployeeFromCookies(request, factory);
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
