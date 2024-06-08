package batdongsan.controllers.admin;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import batdongsan.models.EmployeeModel;
import batdongsan.models.PermissionModel;

@Controller
@RequestMapping("/admin/")
public class DashboardController {
	@Autowired
	SessionFactory factory;

	@RequestMapping("dashboard")
	public String index(ModelMap model, HttpServletRequest request) {
		Session session = factory.openSession();
		try {
			String hqlTotalEmployees = "SELECT COUNT(e) FROM EmployeeModel e";
			Query<Long> queryTotalEmployees = session.createQuery(hqlTotalEmployees, Long.class);
			Long countEmployees = queryTotalEmployees.uniqueResult();

			String hqlTotalRealEstates = "SELECT COUNT(r) FROM RealEstateModel r";
			Query<Long> queryTotalRealEstates = session.createQuery(hqlTotalRealEstates, Long.class);
			Long countRealEstates = queryTotalRealEstates.uniqueResult();

			String hqlTotalNews = "SELECT COUNT(n) FROM NewsModel n";
			Query<Long> queryTotalNews = session.createQuery(hqlTotalNews, Long.class);
			Long countNews = queryTotalNews.uniqueResult();

//            String hqlTotalRevenue = "SELECT SUM(re.totalMoney) FROM RealEstateModel re WHERE MONTH(re.submittedDate) = MONTH(GETDATE()) AND YEAR(re.submittedDate) = YEAR(GETDATE())";
			String hqlTotalRevenue = "SELECT SUM(re.totalMoney) FROM RealEstateModel re";
			Query<Long> queryTotalRevenue = session.createQuery(hqlTotalRevenue, Long.class);
			Long totalRevenue = queryTotalRevenue.uniqueResult();

			model.addAttribute("totalUsers", countEmployees);
			model.addAttribute("totalPosts", countRealEstates);
			model.addAttribute("totalArticles", countNews);
			model.addAttribute("totalRevenue", totalRevenue != null ? totalRevenue : 0);

			// Dữ liệu biểu đồ cho tổng số tiền theo từng tháng (trong vòng 6 tháng gần nhất)
            String hqlTotalMoneyPerMonth = "SELECT MONTH(re.submittedDate), YEAR(re.submittedDate), SUM(re.totalMoney) " +
                                           "FROM RealEstateModel re " +
                                           "WHERE re.submittedDate >= DATEADD(MONTH, -5, GETDATE()) " +
                                           "GROUP BY MONTH(re.submittedDate), YEAR(re.submittedDate) " +
                                           "ORDER BY YEAR(re.submittedDate), MONTH(re.submittedDate)";
            Query<Object[]> queryTotalMoneyPerMonth = session.createQuery(hqlTotalMoneyPerMonth, Object[].class);
            List<Object[]> totalMoneyPerMonth = queryTotalMoneyPerMonth.getResultList();
            
            // Dữ liệu biểu đồ cho số bài đăng theo từng tháng (trong vòng 6 tháng gần nhất)
            String hqlTotalPostsPerMonth = "SELECT MONTH(re.submittedDate), YEAR(re.submittedDate), COUNT(re) " +
                                           "FROM RealEstateModel re " +
                                           "WHERE re.submittedDate >= DATEADD(MONTH, -5, GETDATE()) " +
                                           "GROUP BY MONTH(re.submittedDate), YEAR(re.submittedDate) " +
                                           "ORDER BY YEAR(re.submittedDate), MONTH(re.submittedDate)";
            Query<Object[]> queryTotalPostsPerMonth = session.createQuery(hqlTotalPostsPerMonth, Object[].class);
            List<Object[]> totalPostsPerMonth = queryTotalPostsPerMonth.getResultList();
            
            System.out.println("Total Money Per Month:");
            for (Object[] item : totalMoneyPerMonth) {
                for (Object obj : item) {
                    System.out.print(obj + " ");
                }
                System.out.println();
            }

            // In ra giá trị của totalPostsPerMonth
            System.out.println("Total Posts Per Month:");
            for (Object[] item : totalPostsPerMonth) {
                for (Object obj : item) {
                    System.out.print(obj + " ");
                }
                System.out.println();
            }
            
            // Chuyển dữ liệu thành JSON
            model.addAttribute("totalMoneyPerMonth", totalMoneyPerMonth);
            model.addAttribute("totalPostsPerMonth", totalPostsPerMonth);
            
            EmployeeModel emp = getEmployeeFromCookies(request, session);         
            if (emp != null) {
            	model.addAttribute("loginEmp", emp);
                // Kiểm tra quyền
//                boolean hasPermissions = checkPermissions(emp.getId(), session);
            	List<Integer> permissions = getPermissions(emp.getId(), session);
                model.addAttribute("permissions", permissions);
            } else {
                model.addAttribute("employee", null);
                model.addAttribute("permissions", Collections.emptyList());
            }

		} finally {
			session.close();
		}
		return "admin/dashboard";
	}
	
	// lấy id Nhân viên từ khi đăng nhập
	private EmployeeModel getEmployeeFromCookies(HttpServletRequest request, Session session) {
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
	
	private boolean checkPermissions(String empId, Session session) {
	    String hqlPermissions = "FROM PermissionModel WHERE idEmp = :idEmp AND status = true";
	    Query<PermissionModel> queryPermissions = session.createQuery(hqlPermissions, PermissionModel.class);
	    queryPermissions.setParameter("idEmp", empId);
	    List<PermissionModel> activePermissions = queryPermissions.getResultList();
	    for (PermissionModel item : activePermissions) {
	        System.out.println("Permission ID: " + item.getPermissionId());
	        System.out.println("Permission ID: " + item.isStatus());
	        System.out.println("Permission ID: " + item.getRole().getRoleName());
	        // In các thuộc tính khác của PermissionModel nếu có

	        System.out.println(); // In một dòng trống giữa các mục
	    }
	    return !activePermissions.isEmpty();
	}
	
	private List<Integer> getPermissions(String empId, Session session) {
	    String hqlPermissions = "SELECT role.roleId FROM PermissionModel WHERE employee.id = :idEmp AND status = true";
	    Query<Integer> queryPermissions = session.createQuery(hqlPermissions, Integer.class);
	    queryPermissions.setParameter("idEmp", empId);
	    return queryPermissions.getResultList();
	}

}
