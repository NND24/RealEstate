package batdongsan.controllers.client;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.hibernate.query.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import batdongsan.models.CategoryModel;
import batdongsan.models.DistrictsModel;
import batdongsan.models.ProvincesModel;
import batdongsan.models.RealEstateModel;
import batdongsan.models.UsersModel;
import batdongsan.models.WardsModel;

@Controller
@Transactional
@RequestMapping("/sellernet/")
public class PostController {
	@Autowired
	SessionFactory factory;

	@RequestMapping(value = "dang-tin/ban", method = RequestMethod.GET)
	public String indexSell(ModelMap model, HttpServletRequest request) {
		Session session = factory.openSession();
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

		String hqlCat = "FROM CategoryModel WHERE type = :type";
		Query<CategoryModel> queryCat = session.createQuery(hqlCat);
		queryCat.setParameter("type", "Nhà đất bán");
		List<CategoryModel> categories = queryCat.list();

		String hqlPro = "FROM ProvincesModel";
		Query<ProvincesModel> queryPro = session.createQuery(hqlPro);
		List<ProvincesModel> provinces = queryPro.list();

		request.setAttribute("categories", categories);
		request.setAttribute("provinces", provinces);
		request.setAttribute("user", user);
		model.addAttribute("realEstate", new RealEstateModel());
		return "client/sellernet/postSell";
	}

	@RequestMapping(value = "dang-tin/cho-thue", method = RequestMethod.GET)
	public String indexRent(ModelMap model, HttpServletRequest request) {
		Session session = factory.openSession();
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

		String hqlCat = "FROM CategoryModel WHERE type = :type";
		Query<CategoryModel> queryCat = session.createQuery(hqlCat);
		queryCat.setParameter("type", "Nhà đất cho thuê");
		List<CategoryModel> categories = queryCat.list();

		String hqlPro = "FROM ProvincesModel";
		Query<ProvincesModel> queryPro = session.createQuery(hqlPro);
		List<ProvincesModel> provinces = queryPro.list();

		request.setAttribute("categories", categories);
		request.setAttribute("provinces", provinces);
		request.setAttribute("user", user);
		model.addAttribute("realEstate", new RealEstateModel());
		return "client/sellernet/postRent";
	}

	@RequestMapping(value = "addNewRealEstate", method = RequestMethod.POST)
	public String addNewRealEstate(ModelMap model, HttpServletRequest request,
			@RequestParam("image") MultipartFile[] files,
			@RequestParam(name = "categoryId") Integer categoryId,
			@RequestParam(name = "provinceId") Integer provinceId,
			@RequestParam(name = "districtId") Integer districtId, @RequestParam(name = "wardId") Integer wardId,
			@RequestParam(name = "address") String address, @RequestParam(name = "title") String title,
			@RequestParam(name = "description") String description, @RequestParam(name = "typePost") String typePost,
			@RequestParam(name = "area") Float area, @RequestParam(name = "price") Float price,
			@RequestParam(name = "unit") String unit, @RequestParam(name = "interior") String interior,
			@RequestParam(name = "numberOfBedrooms") int numberOfBedrooms,
			@RequestParam(name = "numberOfToilets") int numberOfToilets,
			@RequestParam(name = "direction") String direction, @RequestParam(name = "contactName") String contactName,
			@RequestParam(name = "phoneNumber") String phoneNumber, @RequestParam(name = "email") String email,
			@RequestParam(name = "submittedDate") String submittedDateString,
			@RequestParam(name = "expirationDate") String expirationDateString,
			@RequestParam(name = "totalMoney") int totalMoney) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			List<String> imagePaths = new ArrayList<>();

			for (MultipartFile file : files) {
				try {
					// Save image file to the server
					LocalTime currentTime = LocalTime.now();
					DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH-mm-ss");
					String formattedTime = currentTime.format(formatter);

					String fileName = StringUtils.cleanPath(file.getOriginalFilename());
					String uploadDir = "D:/Workspace Java/DoAnLTW/batdongsan/src/main/webapp/images/";
					String filePath = uploadDir + formattedTime + "-" + fileName;

					// Create directory if not exists
					File directory = new File(uploadDir);
					if (!directory.exists()) {
						directory.mkdirs();
					}

					// Save file
					file.transferTo(new File(filePath));

					// Add relative image path to the list
					String relativePath = "images/" + formattedTime + "-" + fileName;
					imagePaths.add(relativePath);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}

			// Convert list of image paths to string
			String images = Arrays.toString(imagePaths.toArray());

			Session currentSession = factory.getCurrentSession();

			CategoryModel category = currentSession.find(CategoryModel.class, categoryId);
			ProvincesModel province = currentSession.find(ProvincesModel.class, provinceId);
			DistrictsModel district = currentSession.find(DistrictsModel.class, districtId);
			WardsModel ward = currentSession.find(WardsModel.class, wardId);
			
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

			// Commit transaction and set success message
			RealEstateModel newRealEstate = new RealEstateModel();

			newRealEstate.setCategory(category);
			newRealEstate.setProvince(province);
			newRealEstate.setDistrict(district);
			newRealEstate.setWard(ward);
			newRealEstate.setUser(user);
			newRealEstate.setAddress(address);
			newRealEstate.setTitle(title);
			newRealEstate.setDescription(description);
			newRealEstate.setTypePost(typePost);
			newRealEstate.setArea(area);
			newRealEstate.setPrice(price);
			newRealEstate.setUnit(unit);
			newRealEstate.setInterior(interior);
			newRealEstate.setDirection(direction);
			newRealEstate.setNumberOfBedrooms(numberOfBedrooms);
			newRealEstate.setNumberOfToilets(numberOfToilets);
			newRealEstate.setImages(images);
			newRealEstate.setContactName(contactName);
			newRealEstate.setPhoneNumber(phoneNumber);
			newRealEstate.setEmail(email);

			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date submittedDate = dateFormat.parse(submittedDateString);
			Date expirationDate = dateFormat.parse(expirationDateString);
			newRealEstate.setSubmittedDate(submittedDate);
			newRealEstate.setExpirationDate(expirationDate);

			newRealEstate.setStatus("Chưa xác thực");
			newRealEstate.setTotalMoney(totalMoney);

			session.save(newRealEstate);
			t.commit();
			return "redirect:/sellernet/dang-tin/ban.html";
		} catch (Exception e) {
			t.rollback();
			e.printStackTrace();
			return "redirect:/sellernet/dang-tin/ban.html";
		} finally {
			session.close();
		}
	}

	@ResponseBody
	@GetMapping("/getDistrictsByProvince")
	public ResponseEntity<byte[]> getDistrictsByProvince(@RequestParam("provinceId") int provinceId) {
		Session session = factory.openSession();
		try {
			String hql = "FROM DistrictsModel WHERE provinceId = :provinceId";
			Query<DistrictsModel> query = session.createQuery(hql);
			query.setParameter("provinceId", provinceId);
			List<DistrictsModel> list = query.list();

			// Tạo một chuỗi text từ danh sách district
			StringBuilder result = new StringBuilder();
			for (DistrictsModel district : list) {
				result.append(district.getDistrictId()).append(":").append(district.getName()).append("\n");
			}

			// Chuyển đổi chuỗi thành mảng byte sử dụng encoding UTF-8
			byte[] data = result.toString().getBytes(StandardCharsets.UTF_8);

			return ResponseEntity.ok().contentType(MediaType.TEXT_PLAIN).body(data);
		} catch (Exception e) {
			System.out.println(e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body("Error occurred while fetching districts".getBytes(StandardCharsets.UTF_8));
		} finally {
			session.close();
		}
	}

	@ResponseBody
	@GetMapping("/getWardsByDistrict")
	public ResponseEntity<byte[]> getWardsByDistrict(@RequestParam("districtId") int districtId) {
		Session session = factory.openSession();
		try {
			String hql = "FROM WardsModel WHERE districtId = :districtId";
			Query<WardsModel> query = session.createQuery(hql);
			query.setParameter("districtId", districtId);
			List<WardsModel> list = query.list();

			// Tạo một chuỗi text từ danh sách district
			StringBuilder result = new StringBuilder();
			for (WardsModel ward : list) {
				result.append(ward.getWardId()).append(":").append(ward.getName()).append("\n");
			}

			// Chuyển đổi chuỗi thành mảng byte sử dụng encoding UTF-8
			byte[] data = result.toString().getBytes(StandardCharsets.UTF_8);

			return ResponseEntity.ok().contentType(MediaType.TEXT_PLAIN).body(data);
		} catch (Exception e) {
			System.out.println(e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body("Error occurred while fetching districts".getBytes(StandardCharsets.UTF_8));
		} finally {
			session.close();
		}
	}
}
