package batdongsan.controllers.admin;

import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.fasterxml.jackson.databind.ObjectMapper;

import batdongsan.models.EmployeeModel;
import batdongsan.utils.LoadAdminComponents;

@Controller
@RequestMapping("/admin/")
public class DashboardController {
	@Autowired
	SessionFactory factory;

	@RequestMapping("dashboard")
	public String index(ModelMap model, HttpServletRequest request) {
		Session session = factory.openSession();
		try {
			// Fetching total counts
			String hqlTotalEmployees = "SELECT COUNT(e) FROM UsersModel e";
			Query<Long> queryTotalEmployees = session.createQuery(hqlTotalEmployees, Long.class);
			Long countEmployees = queryTotalEmployees.uniqueResult();

			String hqlTotalRealEstates = "SELECT COUNT(r) FROM HCMRealEstateModel r";
			Query<Long> queryTotalRealEstates = session.createQuery(hqlTotalRealEstates, Long.class);
			Long countRealEstates = queryTotalRealEstates.uniqueResult();

			String hqlTotalNews = "SELECT COUNT(n) FROM NewsModel n";
			Query<Long> queryTotalNews = session.createQuery(hqlTotalNews, Long.class);
			Long countNews = queryTotalNews.uniqueResult();

			String hqlTotalRevenue = "SELECT SUM(re.totalMoney) FROM HCMRealEstateModel re";
			Query<Long> queryTotalRevenue = session.createQuery(hqlTotalRevenue, Long.class);
			Long totalRevenue = queryTotalRevenue.uniqueResult();
			
			NumberFormat numberFormat = NumberFormat.getNumberInstance(new Locale("vi", "VN"));
			numberFormat.setGroupingUsed(true); // Sử dụng dấu phân cách hàng nghìn
			String formattedTotalRevenue = numberFormat.format(totalRevenue != null ? totalRevenue : 0);
			
			model.addAttribute("totalUsers", countEmployees);
			model.addAttribute("totalPosts", countRealEstates);
			model.addAttribute("totalArticles", countNews);
			model.addAttribute("totalRevenue", formattedTotalRevenue);

			// Data for charts: Total posts per month (last 6 months)
			String hqlTotalPostsPerMonth = "SELECT MONTH(re.submittedDate), YEAR(re.submittedDate), COUNT(re) "
					+ "FROM HCMRealEstateModel re " + "WHERE re.submittedDate >= DATEADD(MONTH, -5, GETDATE()) "
					+ "GROUP BY MONTH(re.submittedDate), YEAR(re.submittedDate) "
					+ "ORDER BY YEAR(re.submittedDate), MONTH(re.submittedDate)";
			Query<Object[]> queryTotalPostsPerMonth = session.createQuery(hqlTotalPostsPerMonth, Object[].class);
			List<Object[]> totalPostsPerMonth = queryTotalPostsPerMonth.getResultList();

			// Data for charts: Total money per month (last 6 months)
			String hqlTotalMoneyPerMonth = "SELECT MONTH(re.submittedDate), YEAR(re.submittedDate), SUM(re.totalMoney) "
					+ "FROM HCMRealEstateModel re " + "WHERE re.submittedDate >= DATEADD(MONTH, -5, GETDATE()) "
					+ "GROUP BY MONTH(re.submittedDate), YEAR(re.submittedDate) "
					+ "ORDER BY YEAR(re.submittedDate), MONTH(re.submittedDate)";
			Query<Object[]> queryTotalMoneyPerMonth = session.createQuery(hqlTotalMoneyPerMonth, Object[].class);
			List<Object[]> totalMoneyPerMonth = queryTotalMoneyPerMonth.getResultList();

			// Prepare data for Google Charts
			List<Map<String, Object>> postsChartData = new ArrayList<>();
			for (Object[] row : totalPostsPerMonth) {
				Map<String, Object> map = new HashMap<>();
				map.put("month", row[0]);
				map.put("year", row[1]);
				map.put("count", row[2]);
				postsChartData.add(map);
			}

			List<Map<String, Object>> moneyChartData = new ArrayList<>();
			for (Object[] row : totalMoneyPerMonth) {
				Map<String, Object> map = new HashMap<>();
				map.put("month", row[0]);
				map.put("year", row[1]);
				map.put("amount", row[2]);
				moneyChartData.add(map);
			}

			// Convert chartData to JSON
			ObjectMapper mapper = new ObjectMapper();
			String jsonPostsChartData = mapper.writeValueAsString(postsChartData);
			String jsonMoneyChartData = mapper.writeValueAsString(moneyChartData);

			// Add chart data to the model
			model.addAttribute("postsChartData", jsonPostsChartData);
			model.addAttribute("moneyChartData", jsonMoneyChartData);

			LoadAdminComponents.showOnSidebarAndHeader(model,request,session, factory);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return "admin/dashboard";
	}
	//=================================================
	
	@RequestMapping(value = "changePassword/{id}", method = RequestMethod.GET)
	public String changePasswrod(ModelMap model, @PathVariable("id") String id ,  HttpServletRequest request) {
		Session session = factory.openSession();
		try {
			String hqlTotalEmployees = "SELECT COUNT(e) FROM EmployeeModel e";
			Query<Long> queryTotalEmployees = session.createQuery(hqlTotalEmployees, Long.class);
			Long countEmployees = queryTotalEmployees.uniqueResult();

			String hqlTotalRealEstates = "SELECT COUNT(r) FROM HCMRealEstateModel r";
			Query<Long> queryTotalRealEstates = session.createQuery(hqlTotalRealEstates, Long.class);
			Long countRealEstates = queryTotalRealEstates.uniqueResult();

			String hqlTotalNews = "SELECT COUNT(n) FROM NewsModel n";
			Query<Long> queryTotalNews = session.createQuery(hqlTotalNews, Long.class);
			Long countNews = queryTotalNews.uniqueResult();

//            String hqlTotalRevenue = "SELECT SUM(re.totalMoney) FROM HCMRealEstateModel re WHERE MONTH(re.submittedDate) = MONTH(GETDATE()) AND YEAR(re.submittedDate) = YEAR(GETDATE())";
			String hqlTotalRevenue = "SELECT SUM(re.totalMoney) FROM HCMRealEstateModel re";
			Query<Long> queryTotalRevenue = session.createQuery(hqlTotalRevenue, Long.class);
			Long totalRevenue = queryTotalRevenue.uniqueResult();

			model.addAttribute("totalUsers", countEmployees);
			model.addAttribute("totalPosts", countRealEstates);
			model.addAttribute("totalArticles", countNews);
			model.addAttribute("totalRevenue", totalRevenue != null ? totalRevenue : 0);

			// Dữ liệu biểu đồ cho tổng số tiền theo từng tháng 
            String hqlTotalMoneyPerMonth = "SELECT MONTH(re.submittedDate), YEAR(re.submittedDate), SUM(re.totalMoney) " +
                                           "FROM HCMRealEstateModel re " +
                                           "WHERE re.submittedDate >= DATEADD(MONTH, -5, GETDATE()) " +
                                           "GROUP BY MONTH(re.submittedDate), YEAR(re.submittedDate) " +
                                           "ORDER BY YEAR(re.submittedDate), MONTH(re.submittedDate)";
            Query<Object[]> queryTotalMoneyPerMonth = session.createQuery(hqlTotalMoneyPerMonth, Object[].class);
            List<Object[]> totalMoneyPerMonth = queryTotalMoneyPerMonth.getResultList();
            
            // Dữ liệu biểu đồ cho số bài đăng theo từng tháng 
            String hqlTotalPostsPerMonth = "SELECT MONTH(re.submittedDate), YEAR(re.submittedDate), COUNT(re) " +
                                           "FROM HCMRealEstateModel re " +
                                           "WHERE re.submittedDate >= DATEADD(MONTH, -5, GETDATE()) " +
                                           "GROUP BY MONTH(re.submittedDate), YEAR(re.submittedDate) " +
                                           "ORDER BY YEAR(re.submittedDate), MONTH(re.submittedDate)";
            Query<Object[]> queryTotalPostsPerMonth = session.createQuery(hqlTotalPostsPerMonth, Object[].class);
            List<Object[]> totalPostsPerMonth = queryTotalPostsPerMonth.getResultList();
            
            // Chuyển dữ liệu thành JSON
            model.addAttribute("totalMoneyPerMonth", totalMoneyPerMonth);
            model.addAttribute("totalPostsPerMonth", totalPostsPerMonth);
            
            LoadAdminComponents.showOnSidebarAndHeader(model,request,session, factory);

		} finally {
			session.close();
		}
		return "admin/changePassword";
	}
	
}
