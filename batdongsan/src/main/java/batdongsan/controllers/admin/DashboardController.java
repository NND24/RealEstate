package batdongsan.controllers.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import batdongsan.models.NewsModel;

@Controller
@RequestMapping("/admin/")
public class DashboardController {
	@Autowired
	SessionFactory factory;

	@RequestMapping("dashboard")
	public String index(ModelMap model) {
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

		} finally {
			session.close();
		}
		return "admin/dashboard";
	}

}
