package batdongsan.controllers.client;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.hibernate.query.Query;
import org.apache.commons.io.FilenameUtils;
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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import batdongsan.models.CategoryModel;
import batdongsan.models.HCMDistrictsModel;
import batdongsan.models.HCMRealEstateModel;
import batdongsan.models.HCMWardsModel;
import batdongsan.models.UsersModel;

import batdongsan.utils.Vadilator;

@Controller
@Transactional
@RequestMapping("/sellernet/")
public class PostController {
	@Autowired
	SessionFactory factory;

	@RequestMapping(value = "dang-tin/ban", method = RequestMethod.GET)
	public String getSellPage(ModelMap model, HttpServletRequest request,
	                          @RequestParam(name = "categoryId", required = false) Integer categoryId) {
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

		String hqlCat = "FROM CategoryModel WHERE type = :type AND status=1";
		Query<CategoryModel> queryCat = session.createQuery(hqlCat);
		queryCat.setParameter("type", "Nhà đất bán");
		List<CategoryModel> categories = queryCat.list();

		String hqlDistrict = "FROM HCMDistrictsModel";
		Query<HCMDistrictsModel> queryDis = session.createQuery(hqlDistrict);
		List<HCMDistrictsModel> districts = queryDis.list();

		request.setAttribute("categories", categories);
		request.setAttribute("category", categoryId);
		request.setAttribute("districts", districts);
		request.setAttribute("user", user);
		model.addAttribute("realEstate", new HCMRealEstateModel());
		return "client/sellernet/postSell";
	}

	@RequestMapping(value = "addNewRealEstate", method = RequestMethod.POST)
	public String addNewRealEstate(ModelMap model, HttpServletRequest request,
			@RequestParam(name = "image") MultipartFile[] files, @RequestParam(name = "categoryId") Integer categoryId,
			@RequestParam(name = "districtId") Integer districtId, @RequestParam(name = "wardId") Integer wardId,
			@RequestParam(name = "address") String address, @RequestParam(name = "title") String title,
			@RequestParam(name = "description") String description, @RequestParam(name = "typePost") String typePost,
			@RequestParam(name = "size") String size, @RequestParam(name = "price") String price,
			@RequestParam(name = "unit") String unit, 
			@RequestParam(name = "furnishingSell", required = false) String furnishingSell,
			@RequestParam(name = "rooms", required = false) Integer rooms, 
			@RequestParam(name = "toilets", required = false) Integer toilets,
			@RequestParam(name = "floors", required = false) Integer floors,
			@RequestParam(name = "direction", required = false) String direction, 
			@RequestParam(name = "balconyDirection", required = false) String balconyDirection, 
			@RequestParam(name = "type", required = false) String type, 
			@RequestParam(name = "propertyStatus", required = false) String propertyStatus,
			@RequestParam(name = "propertyLegalDocument", required = false) String propertyLegalDocument, 
			@RequestParam(name = "characteristics", required = false) String characteristics,
			@RequestParam(name = "urgent", required = false) String urgent,
			@RequestParam(name = "contactName") String contactName,
			@RequestParam(name = "phoneNumber") String phoneNumber, @RequestParam(name = "email") String email,
			@RequestParam(name = "submittedDate") String submittedDateString,
			@RequestParam(name = "expirationDate") String expirationDateString,
			@RequestParam(name = "totalMoney") int totalMoney) {
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

			boolean isError = false;

			if (districtId == 0) {
				request.setAttribute("districtError", "Quận, huyện không được bỏ trống!");
				isError = true;
			}

			if (wardId == 0) {
				request.setAttribute("wardError", "Phường, xã không được bỏ trống!");
				isError = true;
			}

			if (address.trim().equals("")) {
				request.setAttribute("addressError", "Địa chỉ không được bỏ trống!");
				isError = true;
			}

			if (title.trim().equals("")) {
				request.setAttribute("titleError", "Tiêu đề không được bỏ trống!");
				isError = true;
			}

			if (description.trim().equals("")) {
				request.setAttribute("descriptionError", "Mô tả không được bỏ trống!");
				isError = true;
			}

			if (size.isEmpty()) {
				request.setAttribute("sizeError", "Diện tích không được để trống!");
				isError = true;
			} else if (!size.matches("\\d+(\\.\\d+)?")) {
				request.setAttribute("sizeError", "Diện tích phải là số!");
				isError = true;
			} else if (Float.parseFloat(size) <= 0) {
				request.setAttribute("sizeError", "Diện tích phải lớn hơn 0!");
				isError = true;
			}

			if (price.isEmpty()) {
				request.setAttribute("priceError", "Mức giá không được để trống!");
				isError = true;
			} else if (!price.matches("\\d+(\\.\\d+)?")) {
				request.setAttribute("priceError", "Mức giá phải là số!");
				isError = true;
			} else if (Long.parseLong(price) <= 0) {
				request.setAttribute("priceError", "Mức giá phải lớn hơn 0!");
				isError = true;
			}

			if (contactName.trim().equals("")) {
				request.setAttribute("contactNameError", "Tên liên hệ không được bỏ trống!");
				isError = true;
			}

			if (phoneNumber.trim().isEmpty()) {
				request.setAttribute("phoneNumberError", "Số điện thoại không được bỏ trống!");
				isError = true;
			} else if (!Vadilator.isValidPhoneNumber(phoneNumber)) {
				request.setAttribute("phoneNumberError", "Số điện thoại không đúng định dạng!");
				isError = true;
			}

			if (email.trim().isEmpty()) {
				request.setAttribute("emailError", "Email không được bỏ trống!");
				isError = true;
			} else if (!Vadilator.isValidEmail(email)) {
				request.setAttribute("emailError", "Email không đúng định dạng!");
				isError = true;
			}

			if (files == null || files.length == 0) {
				request.setAttribute("imageError", "Không có ảnh nào được tải lên!");
			} else {
				int amountImages = 0;
				for (MultipartFile file : files) {
					amountImages++;
				}
				if (amountImages < 4 || amountImages > 24) {
					request.setAttribute("imageError", "Đăng tối thiểu 4 ảnh, tối đa 24 ảnh!");
					isError = true;
				}
			}

			if (user.getAccountBalance() - totalMoney < 0) {
				request.setAttribute("moneyError", "Tài khoản chính không đủ để thực hiện giao dịch");
				isError = true;
			}

			if (!isError) {
				List<String> imagePaths = new ArrayList<>();
				for (MultipartFile file : files) {
					try {
						String uploadDir = "D:/Workspace Java/BatDongSan/batdongsan/src/main/webapp/images/";
						String fileExtension = FilenameUtils.getExtension(file.getOriginalFilename());
						String uniqueFileName = UUID.randomUUID().toString() + "." + fileExtension;
						String filePath = uploadDir + uniqueFileName;

						// Create directory if not exists
						File directory = new File(uploadDir);
						if (!directory.exists()) {
							directory.mkdirs();
						}

						// Save file
						file.transferTo(new File(filePath));

						// Add relative image path to the list
						String relativePath = uniqueFileName;
						imagePaths.add(relativePath);
					} catch (IOException e) {
						e.printStackTrace();
					}
				}

				// Convert list of image paths to string
				String images = Arrays.toString(imagePaths.toArray());

				Session currentSession = factory.getCurrentSession();

				CategoryModel category = currentSession.find(CategoryModel.class, categoryId);
				HCMDistrictsModel district = currentSession.find(HCMDistrictsModel.class, districtId);
				HCMWardsModel ward = currentSession.find(HCMWardsModel.class, wardId);

				// Commit transaction and set success message
				HCMRealEstateModel newRealEstate = new HCMRealEstateModel();

				newRealEstate.setCategory(category);
				newRealEstate.setDistrict(district);
				newRealEstate.setWard(ward);
				newRealEstate.setUser(user);
				newRealEstate.setAddress(address);
				newRealEstate.setTitle(title);
				newRealEstate.setDescription(description);
				newRealEstate.setTypePost(typePost);
				newRealEstate.setSize(Float.parseFloat(size));
				newRealEstate.setPrice(Long.parseLong(price));
				newRealEstate.setUnit(unit);
				newRealEstate.setFurnishingSell(furnishingSell != null ? furnishingSell : "");
				newRealEstate.setDirection(direction != null ? direction : "");
				newRealEstate.setBalconyDirection(balconyDirection != null ? balconyDirection : "");
			    newRealEstate.setFloors(floors != null ? floors : 0);
			    newRealEstate.setRooms(rooms != null ? rooms : 0);
			    newRealEstate.setToilets(toilets != null ? toilets : 0);
				newRealEstate.setType(type);
				newRealEstate.setPropertyStatus(propertyStatus != null ? propertyStatus : "");
				newRealEstate.setPropertyLegalDocument(propertyLegalDocument != null ? propertyLegalDocument : "");
				newRealEstate.setCharacteristics(characteristics != null ? characteristics : "");
				if(urgent.equals("1")) {					
					newRealEstate.setUrgent(true);
				} else {
					newRealEstate.setUrgent(false);
				}
				newRealEstate.setImages(images);
				newRealEstate.setContactName(contactName);
				newRealEstate.setPhoneNumber(phoneNumber);
				newRealEstate.setEmail(email);


				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
				Date submittedDate = dateFormat.parse(submittedDateString);
				Date expirationDate = dateFormat.parse(expirationDateString);
				newRealEstate.setSubmittedDate(submittedDate);
				newRealEstate.setExpirationDate(expirationDate);
				newRealEstate.setStatus("Chưa được duyệt");
				newRealEstate.setTotalMoney(totalMoney);
				newRealEstate.setDeleteStatus(false);
				newRealEstate.setInterestedClick(0);
				
				user.setAccountBalance(user.getAccountBalance() - totalMoney);
				session.update(user);

				session.save(newRealEstate);
				t.commit();
				
				return "redirect:/sellernet/dang-tin/ban.html?categoryId="+categoryId;
			} else {
				Session currentSession = factory.getCurrentSession();
				CategoryModel category = currentSession.find(CategoryModel.class, categoryId);

				String hqlCat = "FROM CategoryModel WHERE type = :type";
				Query<CategoryModel> queryCat = session.createQuery(hqlCat);
				queryCat.setParameter("type", "Nhà đất bán");
				List<CategoryModel> categories = queryCat.list();

				String hqlDistrict = "FROM HCMDistrictsModel";
				Query<HCMDistrictsModel> queryDistrict = session.createQuery(hqlDistrict);
				List<HCMDistrictsModel> districts = queryDistrict.list();

				request.setAttribute("categories", categories);
				request.setAttribute("category", categoryId);
				request.setAttribute("districts", districts);
				request.setAttribute("user", user);

				HCMRealEstateModel newRealEstate = new HCMRealEstateModel();

				if (!address.trim().equals("")) {
					newRealEstate.setAddress(address);
				}

				if (!title.trim().equals("")) {
					newRealEstate.setTitle(title);
				}

				if (!description.trim().equals("")) {
					newRealEstate.setDescription(description);
				}

				if (!size.isEmpty() && size.matches("\\d+(\\.\\d+)?") && Float.parseFloat(size) > 0) {
					newRealEstate.setSize(Float.parseFloat(size));
				}

				if (!price.isEmpty() && price.matches("\\d+(\\.\\d+)?") && Long.parseLong(price) > 0) {
					newRealEstate.setPrice(Long.parseLong(price));
				}

				newRealEstate.setUnit(unit);
				newRealEstate.setFurnishingSell(furnishingSell != null ? furnishingSell : "");
				newRealEstate.setDirection(direction != null ? direction : "");
				newRealEstate.setBalconyDirection(balconyDirection != null ? balconyDirection : "");
				newRealEstate.setFloors(floors != null ? floors : 0);
			    newRealEstate.setRooms(rooms != null ? rooms : 0);
			    newRealEstate.setToilets(toilets != null ? toilets : 0);
				newRealEstate.setType(type);
				newRealEstate.setPropertyStatus(propertyStatus != null ? propertyStatus : "");
				newRealEstate.setPropertyLegalDocument(propertyLegalDocument != null ? propertyLegalDocument : "");
				newRealEstate.setCharacteristics(characteristics != null ? characteristics : "");

				if (!contactName.trim().equals("")) {
					newRealEstate.setContactName(contactName);
				}

				if (!phoneNumber.trim().isEmpty() && Vadilator.isValidPhoneNumber(phoneNumber)) {
					newRealEstate.setPhoneNumber(phoneNumber);
				}

				if (!email.trim().isEmpty() && Vadilator.isValidEmail(email)) {
					newRealEstate.setEmail(email);
				}

				model.addAttribute("realEstate", newRealEstate);
				return "client/sellernet/postSell";
			}
		} catch (Exception e) {
			t.rollback();
			e.printStackTrace();
			return "redirect:/sellernet/dang-tin/ban.html?categoryId="+categoryId;
		} finally {
			session.close();
		}
	}

	Integer editedRealEstateId;

	@RequestMapping(value = "chinh-sua/ban", method = RequestMethod.GET)
	public String getEditSellREPage(ModelMap model, HttpServletRequest request,
			@RequestParam(name = "realEstateId") Integer realEstateId,
            @RequestParam(name = "categoryId", required = false) Integer categoryId) {
		Session session = factory.openSession();
		Cookie[] cookies = request.getCookies();
		UsersModel user = null;

		editedRealEstateId = realEstateId;

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

		String hqlCat = "FROM CategoryModel WHERE type = :type AND status=1";
		Query<CategoryModel> queryCat = session.createQuery(hqlCat);
		queryCat.setParameter("type", "Nhà đất bán");
		List<CategoryModel> categories = queryCat.list();

		String hqlDistrict = "FROM HCMDistrictsModel";
		Query<HCMDistrictsModel> queryDistrict = session.createQuery(hqlDistrict);
		List<HCMDistrictsModel> districts = queryDistrict.list();

		request.setAttribute("categories", categories);
		request.setAttribute("districts", districts);
		request.setAttribute("user", user);

		String hql = "FROM HCMRealEstateModel WHERE realEstateId = :realEstateId AND deleteStatus = False";
		Query<HCMRealEstateModel> query = session.createQuery(hql);
		query.setParameter("realEstateId", realEstateId);
		HCMRealEstateModel RealEstate = query.uniqueResult();
		model.addAttribute("realEstate", RealEstate);
		request.setAttribute("realEstate", RealEstate);
		request.setAttribute("price", RealEstate.getPrice());
		request.setAttribute("category", categoryId);
		return "client/sellernet/editSellPost";
	}

	@RequestMapping(value = "editRealEstate", method = RequestMethod.POST)
	public String editRealEstate(ModelMap model, HttpServletRequest request,
			@RequestParam(name = "image") MultipartFile[] files, @RequestParam(name = "categoryId") Integer categoryId,
			@RequestParam(name = "districtId") Integer districtId, @RequestParam(name = "wardId") Integer wardId,
			@RequestParam(name = "address") String address, @RequestParam(name = "title") String title,
			@RequestParam(name = "description") String description,
			@RequestParam(name = "size") String size, @RequestParam(name = "price") String price,
			@RequestParam(name = "unit") String unit, 
			@RequestParam(name = "furnishingSell", required = false) String furnishingSell,
			@RequestParam(name = "rooms", required = false) Integer rooms, 
			@RequestParam(name = "toilets", required = false) Integer toilets,
			@RequestParam(name = "floors", required = false) Integer floors,
			@RequestParam(name = "direction", required = false) String direction, 
			@RequestParam(name = "balconyDirection", required = false) String balconyDirection, 
			@RequestParam(name = "type", required = false) String type, 
			@RequestParam(name = "propertyStatus", required = false) String propertyStatus,
			@RequestParam(name = "propertyLegalDocument", required = false) String propertyLegalDocument, 
			@RequestParam(name = "characteristics", required = false) String characteristics,
			@RequestParam(name = "urgent", required = false) String urgent,
			@RequestParam(name = "contactName") String contactName,
			@RequestParam(name = "phoneNumber") String phoneNumber, @RequestParam(name = "email") String email) {
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

			Session currentSession = factory.getCurrentSession();
			HCMRealEstateModel editedRealEstate = currentSession.find(HCMRealEstateModel.class, editedRealEstateId);

			boolean isError = false;

			if (districtId == 0) {
				request.setAttribute("districtError", "Quận, huyện không được bỏ trống!");
				isError = true;
			}

			if (wardId == 0) {
				request.setAttribute("wardError", "Phường, xã không được bỏ trống!");
				isError = true;
			}

			if (address.trim().equals("")) {
				request.setAttribute("addressError", "Địa chỉ không được bỏ trống!");
				isError = true;
			}

			if (title.trim().equals("")) {
				request.setAttribute("titleError", "Tiêu đề không được bỏ trống!");
				isError = true;
			}

			if (description.trim().equals("")) {
				request.setAttribute("descriptionError", "Mô tả không được bỏ trống!");
				isError = true;
			}

			if (size.isEmpty()) {
				request.setAttribute("sizeError", "Diện tích không được để trống!");
				isError = true;
			} else if (!size.matches("\\d+(\\.\\d+)?")) {
				request.setAttribute("sizeError", "Diện tích phải là số!");
				isError = true;
			} else if (Float.parseFloat(size) <= 0) {
				request.setAttribute("sizeError", "Diện tích phải lớn hơn 0!");
				isError = true;
			}

			if (price.isEmpty()) {
				request.setAttribute("priceError", "Mức giá không được để trống!");
				isError = true;
			} else if (!price.matches("\\d+(\\.\\d+)?")) {
				request.setAttribute("priceError", "Mức giá phải là số!");
				isError = true;
			} else if (Long.parseLong(price) <= 0) {
				request.setAttribute("priceError", "Mức giá phải lớn hơn 0!");
				isError = true;
			}

			if (contactName.trim().equals("")) {
				request.setAttribute("contactNameError", "Tên liên hệ không được bỏ trống!");
				isError = true;
			}

			if (phoneNumber.trim().isEmpty()) {
				request.setAttribute("phoneNumberError", "Số điện thoại không được bỏ trống!");
				isError = true;
			} else if (!Vadilator.isValidPhoneNumber(phoneNumber)) {
				request.setAttribute("phoneNumberError", "Số điện thoại không đúng định dạng!");
				isError = true;
			}

			if (email.trim().isEmpty()) {
				request.setAttribute("emailError", "Email không được bỏ trống!");
				isError = true;
			} else if (!Vadilator.isValidEmail(email)) {
				request.setAttribute("emailError", "Email không đúng định dạng!");
				isError = true;
			}
			
			if (files == null || files.length == 0) {
				request.setAttribute("imageError", "Không có ảnh nào được tải lên!");
			} else {
				int amountImages = 0;
				for (MultipartFile file : files) {
					amountImages++;
				}
				if (amountImages < 4 || amountImages > 24) {
					request.setAttribute("imageError", "Đăng tối thiểu 4 ảnh, tối đa 24 ảnh!");
					isError = true;
				}
			}

			if (!isError) {
				String images = "";
				if (files != null && files.length > 0) {
					List<String> imagePaths = new ArrayList<>();
					for (MultipartFile file : files) {
						String contentType = file.getContentType();
						if (contentType != null && contentType.startsWith("image/")) {
							String uploadDir = "D:/Workspace Java/BatDongSan/batdongsan/src/main/webapp/images/";
							String fileExtension = FilenameUtils.getExtension(file.getOriginalFilename());
							String uniqueFileName = UUID.randomUUID().toString() + "." + fileExtension;
							String filePath = uploadDir + uniqueFileName;
							File directory = new File(uploadDir);
							if (!directory.exists()) {
								directory.mkdirs();
							}
							file.transferTo(new File(filePath));
							String relativePath = uniqueFileName;
							imagePaths.add(relativePath);
						} else {
							// Handle non-image file or just continue with next file
						}
					}
					images = Arrays.toString(imagePaths.toArray());
				}

				CategoryModel category = currentSession.find(CategoryModel.class, categoryId);
				HCMDistrictsModel district = currentSession.find(HCMDistrictsModel.class, districtId);
				HCMWardsModel ward = currentSession.find(HCMWardsModel.class, wardId);

				editedRealEstate.setCategory(category);
				editedRealEstate.setDistrict(district);
				editedRealEstate.setWard(ward);
				editedRealEstate.setUser(user);
				editedRealEstate.setAddress(address);
				editedRealEstate.setTitle(title);
				editedRealEstate.setDescription(description);
				editedRealEstate.setSize(Float.parseFloat(size));
				editedRealEstate.setPrice(Long.parseLong(price));
				editedRealEstate.setUnit(unit);				
				editedRealEstate.setFurnishingSell(furnishingSell != null ? furnishingSell : "");
				editedRealEstate.setDirection(direction != null ? direction : "");
				editedRealEstate.setBalconyDirection(balconyDirection != null ? balconyDirection : "");
				editedRealEstate.setFloors(floors != null ? floors : 0);
				editedRealEstate.setRooms(rooms != null ? rooms : 0);
				editedRealEstate.setToilets(toilets != null ? toilets : 0);
				editedRealEstate.setType(type);
				editedRealEstate.setPropertyStatus(propertyStatus != null ? propertyStatus : "");
				editedRealEstate.setPropertyLegalDocument(propertyLegalDocument != null ? propertyLegalDocument : "");
				editedRealEstate.setCharacteristics(characteristics != null ? characteristics : "");
				if(urgent.equals("1")) {					
					editedRealEstate.setUrgent(true);
				} else {
					editedRealEstate.setUrgent(false);
				}
				if (files != null && files.length > 0 && !images.isEmpty() && !images.equals("[]")) {
					editedRealEstate.setImages(images);
				}
				editedRealEstate.setContactName(contactName);
				editedRealEstate.setPhoneNumber(phoneNumber);
				editedRealEstate.setEmail(email);

				session.merge(editedRealEstate);
				t.commit();
				return "redirect:/sellernet/quan-ly-tin-rao-ban-cho-thue.html";
			} else {
				CategoryModel category = currentSession.find(CategoryModel.class, categoryId);

				String hqlCat = "FROM CategoryModel WHERE type = :type AND status=1";
				Query<CategoryModel> queryCat = session.createQuery(hqlCat);
				queryCat.setParameter("type", "Nhà đất bán");
				List<CategoryModel> categories = queryCat.list();

				String hqlDis = "FROM HCMDistrictsModel";
				Query<HCMDistrictsModel> queryDis = session.createQuery(hqlDis);
				List<HCMDistrictsModel> districts = queryDis.list();

				request.setAttribute("categories", categories);
				request.setAttribute("category", categoryId);
				request.setAttribute("districts", districts);
				request.setAttribute("user", user);

				HCMRealEstateModel newRealEstate = new HCMRealEstateModel();

				if (!address.trim().equals("")) {
					newRealEstate.setAddress(address);
				}

				if (!title.trim().equals("")) {
					newRealEstate.setTitle(title);
				}

				if (!description.trim().equals("")) {
					newRealEstate.setDescription(description);
				}

				if (!size.isEmpty() && size.matches("\\d+(\\.\\d+)?") && Float.parseFloat(size) > 0) {
					newRealEstate.setSize(Float.parseFloat(size));
				}

				if (!price.isEmpty() && price.matches("\\d+(\\.\\d+)?") && Long.parseLong(price) > 0) {
					newRealEstate.setPrice(Long.parseLong(price));
				}

				newRealEstate.setUnit(unit);
				editedRealEstate.setFurnishingSell(furnishingSell != null ? furnishingSell : "");
				editedRealEstate.setDirection(direction != null ? direction : "");
				editedRealEstate.setBalconyDirection(balconyDirection != null ? balconyDirection : "");
				editedRealEstate.setFloors(floors != null ? floors : 0);
				editedRealEstate.setRooms(rooms != null ? rooms : 0);
				editedRealEstate.setToilets(toilets != null ? toilets : 0);
				editedRealEstate.setType(type);
				editedRealEstate.setPropertyStatus(propertyStatus != null ? propertyStatus : "");
				editedRealEstate.setPropertyLegalDocument(propertyLegalDocument != null ? propertyLegalDocument : "");
				editedRealEstate.setCharacteristics(characteristics != null ? characteristics : "");

				if (!contactName.trim().equals("")) {
					newRealEstate.setContactName(contactName);
				}

				if (!phoneNumber.trim().isEmpty() && Vadilator.isValidPhoneNumber(phoneNumber)) {
					newRealEstate.setPhoneNumber(phoneNumber);
				}

				if (!email.trim().isEmpty() && Vadilator.isValidEmail(email)) {
					newRealEstate.setEmail(email);
				}

				model.addAttribute("realEstate", newRealEstate);
				if (category.getType().equals("Nhà đất bán")) {
					String hqlCat1 = "FROM CategoryModel WHERE type = :type AND status=1";
					Query<CategoryModel> queryCat1 = session.createQuery(hqlCat1);
					queryCat1.setParameter("type", "Nhà đất bán");
					List<CategoryModel> categories1 = queryCat1.list();

					String hqlDis1 = "FROM HCMDistrictsModel";
					Query<HCMDistrictsModel> queryDis1 = session.createQuery(hqlDis1);
					List<HCMDistrictsModel> districts1 = queryDis1.list();

					request.setAttribute("categories", categories1);
					request.setAttribute("category", categoryId);
					request.setAttribute("districts", districts1);
					request.setAttribute("user", user);

					model.addAttribute("realEstate", editedRealEstate);
					request.setAttribute("realEstate", editedRealEstate);
					return "client/sellernet/editSellPost";
				} else {
					String hqlCat2 = "FROM CategoryModel WHERE type = :type AND status=1";
					Query<CategoryModel> queryCat2 = session.createQuery(hqlCat2);
					queryCat2.setParameter("type", "Nhà đất cho thuê");
					List<CategoryModel> categories2 = queryCat.list();

					String hqlDis2 = "FROM HCMDistrictsModel";
					Query<HCMDistrictsModel> queryDis2 = session.createQuery(hqlDis2);
					List<HCMDistrictsModel> districts2 = queryDis2.list();

					request.setAttribute("categories", categories2);
					request.setAttribute("category", categoryId);
					request.setAttribute("districts", districts2);
					request.setAttribute("user", user);

					model.addAttribute("realEstate", editedRealEstate);
					request.setAttribute("realEstate", editedRealEstate);

					return "client/sellernet/editRentPost";
				}
			}
		} catch (Exception e) {
			t.rollback();
			e.printStackTrace();
			return "redirect:/sellernet/quan-ly-tin-rao-ban-cho-thue.html";
		} finally {
			session.close();
		}
	}

	@ResponseBody
	@GetMapping("/getWardsByDistrict")
	public ResponseEntity<byte[]> getWardsByDistrict(@RequestParam("districtId") int districtId) {
		Session session = factory.openSession();
		try {
			String hql = "FROM HCMWardsModel WHERE districtId = :districtId";
			Query<HCMWardsModel> query = session.createQuery(hql);
			query.setParameter("districtId", districtId);
			List<HCMWardsModel> list = query.list();

			// Tạo một chuỗi text từ danh sách district
			StringBuilder result = new StringBuilder();
			for (HCMWardsModel ward : list) {
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
