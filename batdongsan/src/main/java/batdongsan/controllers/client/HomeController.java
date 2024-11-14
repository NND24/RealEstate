package batdongsan.controllers.client;

import java.time.LocalDate;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.hibernate.query.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import batdongsan.models.NewsModel;
import batdongsan.models.HCMRealEstateModel;
import batdongsan.models.UsersModel;

@Controller
@RequestMapping("/")
public class HomeController {
	@Autowired
	SessionFactory factory;

	@RequestMapping(value = { "/", "/trang-chu" }, method = RequestMethod.GET)
	public String getHomePage(HttpServletRequest request) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			Cookie[] cookies = request.getCookies();
			UsersModel user = null;

			if (cookies != null) {
				for (Cookie cookie : cookies) {
					if (cookie.getName().equals("userId")) {
						String userId = cookie.getValue();
						String hqlUser = "FROM UsersModel WHERE userId = :userId";
						Query<UsersModel> queryUser = session.createQuery(hqlUser);
						queryUser.setParameter("userId", Integer.parseInt(userId));
						user = queryUser.uniqueResult();
						break;
					}
				}
			}
			
			// Fetch expired real estates
            String hqlExpired = "SELECT re FROM HCMRealEstateModel re WHERE re.expirationDate < :today AND re.deleteStatus = False";
            Query<HCMRealEstateModel> queryExpired = session.createQuery(hqlExpired, HCMRealEstateModel.class);
            queryExpired.setParameter("today", java.sql.Date.valueOf(LocalDate.now()));
            List<HCMRealEstateModel> expiredRealEstates = queryExpired.list();

            // Update status of all real estates to "Ẩn"
            expiredRealEstates.forEach(re -> {
                re.setStatus("Ẩn");
                session.merge(re);
            });

			String hqlREForYou = "FROM HCMRealEstateModel re WHERE re.status = :status AND re.deleteStatus = False";
			if (user != null) {
				hqlREForYou += " AND NOT EXISTS (SELECT 1 FROM FavouriteModel fa WHERE fa.realEstate = id AND fa.user = :user)";
			}
			Query<HCMRealEstateModel> queryREForYou = session.createQuery(hqlREForYou);
			queryREForYou.setParameter("status", "Đang hiển thị");
			if (user != null) {
				queryREForYou.setParameter("user", user);
			}
			List<HCMRealEstateModel> listREForYou = queryREForYou.list();
			request.setAttribute("listREForYou", listREForYou);
			
			int amountREHCM = 0;
			int amountREHN = 0;
			int amountREDaNang = 0;
			int amountREBD = 0;
			int amountREDongNai = 0;
			
			for(HCMRealEstateModel re : listREForYou) {
				if(re.getStreet().getWard().getDistrict().getDistrictId()==1) {
					amountREHCM++;
				}
				if(re.getStreet().getWard().getDistrict().getDistrictId()==2) {
					amountREHN++;
				}
				if(re.getStreet().getWard().getDistrict().getDistrictId()==3) {
					amountREDaNang++;
				}
				if(re.getStreet().getWard().getDistrict().getDistrictId()==4) {
					amountREBD++;
				}
				if(re.getStreet().getWard().getDistrict().getDistrictId()==5) {
					amountREDongNai++;
				}
			}
			request.setAttribute("amountREHCM", amountREHCM);
			request.setAttribute("amountREHN", amountREHN);
			request.setAttribute("amountREDaNang", amountREDaNang);
			request.setAttribute("amountREBD", amountREBD);
			request.setAttribute("amountREDongNai", amountREDongNai);
			
			String hqlNews = "FROM NewsModel ORDER BY dateUploaded DESC";
			Query queryNews = session.createQuery(hqlNews);
			List<NewsModel> listNews = queryNews.list();
			request.setAttribute("listNews", listNews);
			
			String hqlNewsHN = "FROM NewsModel WHERE title LIKE :input0 OR description LIKE :input1 ORDER BY dateUploaded DESC";
			Query queryNewsHN = session.createQuery(hqlNewsHN);
			queryNewsHN.setParameter("input0", "%Hà Nội%");
			queryNewsHN.setParameter("input1", "%Hà Nội%");
			List<NewsModel> listNewsHN = queryNewsHN.list();
			request.setAttribute("listNewsHN", listNewsHN);
			
			String hqlNewsHCM = "FROM NewsModel WHERE title LIKE :input0 OR description LIKE :input1 ORDER BY dateUploaded DESC";
			Query queryNewsHCM = session.createQuery(hqlNewsHCM);
			queryNewsHCM.setParameter("input0", "%Hồ Chí Minh%");
			queryNewsHCM.setParameter("input1", "%Hồ Chí Minh%");
			List<NewsModel> listNewsHCM = queryNewsHCM.list();
			request.setAttribute("listNewsHCM", listNewsHCM);
			
			request.setAttribute("user", user);

			t.commit();
			return "client/home";
		} catch (Exception e) {
            t.rollback();
            throw e;
        } finally {
			session.close();
		}
	}
}
