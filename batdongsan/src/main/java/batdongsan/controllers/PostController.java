package batdongsan.controllers;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.hibernate.query.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
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
import batdongsan.models.WardsModel;

@Controller
@RequestMapping("/sellernet/")
public class PostController {
	@Autowired
	SessionFactory factory;

	@RequestMapping(value = "dang-tin/ban", method = RequestMethod.GET)
	public String indexSell(ModelMap model) {
		model.addAttribute("realEstate", new RealEstateModel());
		return "client/sellernet/postSell";
	}

	@RequestMapping(value = "dang-tin/chothue", method = RequestMethod.GET)
	public String indexRent(ModelMap model) {
		model.addAttribute("realEstate", new RealEstateModel());
		return "client/sellernet/postRent";
	}

	@RequestMapping(value = "insert", method = RequestMethod.POST)
	public String insert(ModelMap model, @ModelAttribute("realEstate") RealEstateModel realEstate,
			@RequestParam("image") MultipartFile[] files) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			List<String> imagePaths = new ArrayList<>();

			for (MultipartFile file : files) {
				try {
					// Lưu file ảnh vào máy chủ
					LocalTime currentTime = LocalTime.now();
					DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH-mm-ss");
					String formattedTime = currentTime.format(formatter);

					String fileName = StringUtils.cleanPath(file.getOriginalFilename());
					String uploadDir = "D:/Workspace Java/DoAnLTW/batdongsan/src/main/webapp/images/";
					String filePath = uploadDir + formattedTime + "-" + fileName;

					// Tạo thư mục nếu thư mục không tồn tại
					File directory = new File(uploadDir);
					if (!directory.exists()) {
						directory.mkdirs();
					}

					// Lưu file
					file.transferTo(new File(filePath));

					// Thêm đường dẫn tương đối của ảnh vào danh sách
					String relativePath = "images/" + formattedTime + "-" + fileName;
					imagePaths.add(relativePath);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}

			// Chuyển đổi danh sách các đường dẫn ảnh thành chuỗi
			String images = Arrays.toString(imagePaths.toArray());

			LocalDateTime currentDateTime = LocalDateTime.now();

			// Chuyển đổi LocalDateTime thành java.sql.Timestamp
			java.sql.Timestamp currentTimestamp = java.sql.Timestamp.valueOf(currentDateTime);

			// Chuyển đổi java.sql.Timestamp thành java.sql.Date
			java.sql.Date currentDate = new java.sql.Date(currentTimestamp.getTime());

			CategoryModel category = session.find(CategoryModel.class, realEstate.getCategory());
			ProvincesModel province = session.find(ProvincesModel.class, realEstate.getProvince());
			DistrictsModel district = session.find(DistrictsModel.class, realEstate.getDistrict());
			WardsModel ward = session.find(WardsModel.class, realEstate.getWard());

			// Commit transaction và gán thông báo thành công
			RealEstateModel newRealEstate = new RealEstateModel(realEstate.getRealEstateId(), category, province,
					district, ward, realEstate.getAddress(), realEstate.getTitle(), realEstate.getDescription(),
					realEstate.getArea(), realEstate.getPrice(), realEstate.getUnit(), realEstate.getInterior(),
					realEstate.getNumberOfBedrooms(), realEstate.getNumberOfToilets(), images,
					realEstate.getContactName(), realEstate.getPhoneNumber(), realEstate.getEmail(), currentDate,
					currentDate);

			session.save(newRealEstate);
			t.commit();
			model.addAttribute("message", "Thêm mới thành công!");
		} catch (Exception e) {
			t.rollback();
			model.addAttribute("message", "Thêm mới thất bại! ");
			System.out.println(e);
		} finally {
			session.close();
			return "redirect:/sellernet/dang-tin.html";
		}
	}

	@ModelAttribute("categoriesSell")
	public List<CategoryModel> getTypesSell() {
		Session session = factory.openSession();
		try {
			String hql = "FROM CategoryModel WHERE type = :type";
			Query<CategoryModel> query = session.createQuery(hql);
			query.setParameter("type", "Nhà đất bán");
			List<CategoryModel> categories = query.list();

			return categories;
		} catch (Exception e) {
			System.out.println(e);
			return null;
		} finally {
			session.close();
		}
	}

	@ModelAttribute("categoriesRent")
	public List<CategoryModel> getTypesRent() {
		Session session = factory.openSession();
		try {
			String hql = "FROM CategoryModel WHERE type = :type";
			Query<CategoryModel> query = session.createQuery(hql);
			query.setParameter("type", "Nhà đất cho thuê");
			List<CategoryModel> categories = query.list();

			return categories;
		} catch (Exception e) {
			System.out.println(e);
			return null;
		} finally {
			session.close();
		}
	}

	@ModelAttribute("provinces")
	public List<ProvincesModel> getProvinces() {
		Session session = factory.openSession();
		String hql = "FROM ProvincesModel";
		Query<ProvincesModel> query = session.createQuery(hql);
		List<ProvincesModel> list = query.list();
		session.close();
		return list;
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
