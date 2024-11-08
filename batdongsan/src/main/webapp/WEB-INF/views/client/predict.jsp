<%@page import="batdongsan.models.HCMRealEstateModel"%>
<%@page import="java.util.Collection"%>
<%@page import="batdongsan.models.FavouriteModel"%>
<%@page import="batdongsan.models.HCMDistrictsModel"%>
<%@page import="java.util.List"%>
<%@page import="batdongsan.models.CategoryModel"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Website số 1 về bất động sản</title>
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath}/css/client/index.css"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath}/css/client/header.css?version=53"
	"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath}/css/client/sellernet.css"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath}/css/client/pricePredict.css?version=54"
	type="text/css">
<%@ include file="../../../../links/links.jsp"%>
<base href="${pageContext.servletContext.contextPath}/">
</head>
<body>
	<%@ include file="../../components/headerPredict.jsp"%>
	<div class='sellernet'>
		<!-- Post -->
		<div class='post'>
			<form:form action="sellernet/addNewRealEstate.html"
				modelAttribute="realEstate" method="POST"
				enctype="multipart/form-data">


				<div class='input-wrapper'>
					<h3>Thông tin cơ bản</h3>

					<div class='tab-content'>
						<div id='menu1' class='tab-pane fade in active'>
							<div class='form-item'>
								<p>
									Loại bất động sản <span>*</span>
								</p>
								<%
								Integer category = (Integer) request.getAttribute("category");
								List<CategoryModel> categories = (List<CategoryModel>) request.getAttribute("categories");
								%>
								<select name="categoryId"
									onchange="window.location.href='<%=pageContext.getServletContext().getContextPath()%>/du-doan-gia-nha.html?categoryId=' + this.value;">
									<%
									for (CategoryModel cat : categories) {
										String selected = (cat.getCategoryId() == category) ? "selected" : "";
									%>
									<option value="<%=cat.getCategoryId()%>" <%=selected%>>
										<%=cat.getName()%>
									</option>
									<%
									}
									%>
								</select>
							</div>
						</div>
					</div>

					<div class='address-container'>
						<div class='form-item'>
							<p>
								Quận, huyện <span>*</span>
							</p>
							<%
							List<HCMDistrictsModel> districts = (List<HCMDistrictsModel>) request.getAttribute("districts");
							%>
							<select name='districtId' id="districtId">
								<%
								for (HCMDistrictsModel district : districts) {
								%>
								<option value="<%=district.getDistrictId()%>"><%=district.getName()%></option>
								<%
								}
								%>
							</select>
						</div>
					</div>

					<div class='address-container'>
						<div class='form-item'>
							<p>
								Phường, xã <span>*</span>
							</p>
							<select name='wardId' id="wardId">
								<option value="0">---Phường, xã---</option>
							</select>
							<%
							String wardError = (String) request.getAttribute("wardError");
							%>
						</div>
					</div>
				</div>

				<%
				if (category == 1) {
				%>
				<div class='input-wrapper'>
					<h3>Thông tin bất động sản</h3>

					<div class='form-item'>
						<p>
							Diện tích <span>*</span>
						</p>
						<div class='input-container'>
							<form:input path="size" id="size"
								placeholder="Nhập diện tích, VD: 80" type="number" min="0"
								step="0.01" />
							<span>m²</span>
						</div>
					</div>

					<div class='contact-wrapper'>
						<div class='form-item'>
							<p>Số phòng ngủ</p>
							<div class='input-container'>
								<form:input path="rooms" id="rooms"
									placeholder="Nhập số phòng, VD: 2" type="number" min="0" />
								<span>phòng</span>
							</div>
						</div>
						<div class='form-item'>
							<p>Số phòng tắm, vệ sinh</p>
							<div class='input-container'>
								<form:input path="toilets" id="toilets"
									placeholder="Nhập số phòng, VD: 2" type="number" min="0" />
								<span>phòng</span>
							</div>
						</div>
					</div>

					<div class='contact-wrapper'>
						<div class='form-item'>
							<p>Số tầng</p>
							<div class='input-container'>
								<form:input path="floors" id="floors"
									placeholder="Nhập số tầng, VD: 2" type="number" min="0" />
								<span>tầng</span>
							</div>
						</div>
						<div class='form-item'>
							<p>Loại hình nhà ở</p>
							<select name='type' id="type">
								<option value='Nhà ngõ, hẻm'>Nhà ngõ, hẻm</option>
								<option value='Nhà mặt phố, mặt tiền'>Nhà mặt phố, mặt
									tiền</option>
								<option value='Nhà phố liền kề'>Nhà phố liền kề</option>
								<option value='Nhà biệt thự'>Nhà biệt thự</option>
							</select>
						</div>
					</div>

					<div class='form-item'>
						<p>Đặc điểm nhà/đất</p>
						<select name='characteristics' id="characteristics">
							<option value=''>---Đặc điểm nhà/đất---</option>
							<option value='Hẻm xe hơi'>Hẻm xe hơi</option>
							<option value='Nhà nở hậu'>Nhà nở hậu</option>
							<option value='Nhà tóp hậu'>Nhà tóp hậu</option>
							<option value='Nhà dính quy hoạch / lộ giới'>Nhà dính
								quy hoạch / lộ giới</option>
							<option value='Nhà chưa hoàn công'>Nhà chưa hoàn công</option>
							<option value='Nhà nát'>Nhà nát</option>
							<option value='Đất chưa chuyển thổ'>Đất chưa chuyển thổ</option>
						</select>
					</div>

					<div class='form-item'>
						<p>Giấy tờ pháp lý</p>
						<select name='propertyLegalDocument' id="property_legal_document">
							<option value=''>---Giấy tờ pháp lý---</option>
							<option value='Đã có sổ'>Đã có sổ</option>
							<option value='Đang chờ sổ'>Đang chờ sổ</option>
							<option value='Không có sổ'>Không có sổ</option>
							<option value='Sổ chung / công chứng vi bằng'>Sổ chung /
								công chứng vi bằng</option>
							<option value='Giấy tờ viết tay'>Giấy tờ viết tay</option>
						</select>
					</div>

					<div class='contact-wrapper'>
						<div class='form-item'>
							<p>Nội thất</p>
							<select name='furnishingSell' id="furnishing_sell">
								<option value=''>---Nội thất---</option>
								<option value='Hoàn thiện cơ bản'>Hoàn thiện cơ bản</option>
								<option value='Nội thất đầy đủ'>Nội thất đầy đủ</option>
								<option value='Nội thất cao cấp'>Nội thất cao cấp</option>
								<option value='Bàn giao thô'>Bàn giao thô</option>
							</select>
						</div>
						<div class='form-item'>
							<p>Hướng nhà</p>
							<select name='direction'>
								<option value=''>---Hướng nhà---</option>
								<option value='Bắc'>Bắc</option>
								<option value='Đông Bắc'>Đông Bắc</option>
								<option value='Đông'>Đông</option>
								<option value='Đông Nam'>Đông Nam</option>
								<option value='Nam'>Nam</option>
								<option value='Tây Nam'>Tây Nam</option>
								<option value='Tây'>Tây</option>
								<option value='Tây Bắc'>Tây Bắc</option>
							</select>
						</div>
					</div>

					<div class='form-item'>
						<p>Bất động sản bán gấp</p>
						<select name='urgent' id="urgent">
							<option value='0'>Không</option>
							<option value='1'>Có</option>
						</select>
					</div>

					<p id="result" class="error"></p>
					<div class='money-wrapper'>
						<div class='form-item'>
							<p>
								Mức giá khuyến nghị <span>*</span>
							</p>
							<div class='input-container'>
								<input id="textPrice" type="text" readonly="true" />
								<form:input path="price" id="price" type="number" readonly="true" min="0" style="display: none;" />
							</div>
						</div>

						<div class='form-item'>
							<p>Đơn vị</p>
							<select name='unit'>
								<option value='VND'>VND</option>
							</select>
						</div>
					</div>
				</div>
				<%
				} else if (category == 2) {
				%>
				<div class='input-wrapper'>
					<h3>Thông tin bất động sản</h3>

					<div class='form-item'>
						<p>
							Diện tích <span>*</span>
						</p>
						<div class='input-container'>
							<form:input path="size" id="size"
								placeholder="Nhập diện tích, VD: 80" type="number" min="0"
								step="0.01" />
							<span>m²</span>
						</div>
					</div>

					<div class='contact-wrapper'>
						<div class='form-item'>
							<p>Số phòng ngủ</p>
							<div class='input-container'>
								<form:input path="rooms" id="rooms"
									placeholder="Nhập số phòng, VD: 2" type="number" min="0" />
								<span>phòng</span>
							</div>
						</div>
						<div class='form-item'>
							<p>Số phòng tắm, vệ sinh</p>
							<div class='input-container'>
								<form:input path="toilets" id="toilets"
									placeholder="Nhập số phòng, VD: 2" type="number" min="0" />
								<span>phòng</span>
							</div>
						</div>
					</div>

					<div class='form-item'>
						<p>Tình trạng bất động sản</p>
						<select name='propertyStatus' id="property_status">
							<option value=''>---Tình trạng---</option>
							<option value='Đã bàn giao'>Đã bàn giao</option>
							<option value='Chưa bàn giao'>Chưa bàn giao</option>
						</select>
					</div>


					<div class='form-item'>
						<p>Giấy tờ pháp lý</p>
						<select name='propertyLegalDocument' id="property_legal_document">
							<option value=''>---Giấy tờ pháp lý---</option>
							<option value='Hợp đồng đặt cọc'>Hợp đồng đặt cọc</option>
							<option value='Hợp đồng mua bán'>Hợp đồng mua bán</option>
							<option value='Sổ hồng riêng'>Sổ hồng riêng</option>
							<option value='Đang chờ sổ'>Đang chờ sổ</option>
						</select>
					</div>

					<div class='contact-wrapper'>
						<div class='form-item'>
							<p>Loại hình căn hộ</p>
							<select name='type' id="type">
								<option value='Chung cư'>Chung cư</option>
								<option value='Duplex'>Duplex</option>
								<option value='Penthouse'>Penthouse</option>
								<option value='Căn hộ dịch vụ, mini'>Căn hộ dịch vụ,
									mini</option>
								<option value='Tập thể, cư xá'>Tập thể, cư xá</option>
								<option value='Officetel'>Officetel</option>
							</select>
						</div>

						<div class='form-item'>
							<p>Nội thất</p>
							<select name='furnishingSell' id="furnishing_sell">
								<option value=''>---Nội thất---</option>
								<option value='Hoàn thiện cơ bản'>Hoàn thiện cơ bản</option>
								<option value='Nội thất đầy đủ'>Nội thất đầy đủ</option>
								<option value='Nội thất cao cấp'>Nội thất cao cấp</option>
								<option value='Bàn giao thô'>Bàn giao thô</option>
							</select>
						</div>
					</div>

					<div class='contact-wrapper'>
						<div class='form-item'>
							<p>Hướng cửa chính</p>
							<select name='direction' id='direction'>
								<option value=''>---Hướng ban công---</option>
								<option value='Bắc'>Bắc</option>
								<option value='Đông Bắc'>Đông Bắc</option>
								<option value='Đông'>Đông</option>
								<option value='Đông Nam'>Đông Nam</option>
								<option value='Nam'>Nam</option>
								<option value='Tây Nam'>Tây Nam</option>
								<option value='Tây'>Tây</option>
								<option value='Tây Bắc'>Tây Bắc</option>
							</select>
						</div>
						<div class='form-item'>
							<p>Hướng ban công</p>
							<select name='balconyDirection' id='balconyDirection'>
								<option value=''>---Hướng ban công---</option>
								<option value='Bắc'>Bắc</option>
								<option value='Đông Bắc'>Đông Bắc</option>
								<option value='Đông'>Đông</option>
								<option value='Đông Nam'>Đông Nam</option>
								<option value='Nam'>Nam</option>
								<option value='Tây Nam'>Tây Nam</option>
								<option value='Tây'>Tây</option>
								<option value='Tây Bắc'>Tây Bắc</option>
							</select>
						</div>
					</div>

					<div class='form-item'>
						<p>Bất động sản bán gấp</p>
						<select name='urgent' id="urgent">
							<option value='0'>Không</option>
							<option value='1'>Có</option>
						</select>
					</div>

					<p id="result" class="error"></p>
					<div class='money-wrapper'>
						<div class='form-item'>
							<p>
								Mức giá khuyến nghị <span>*</span>
							</p>
							<div class='input-container'>
								<input id="textPrice" type="text" readonly="true" />
								<form:input path="price" id="price" type="number" readonly="true" min="0" style="display: none;" />
							</div>
						</div>

						<div class='form-item'>
							<p>Đơn vị</p>
							<select name='unit'>
								<option value='VND'>VND</option>
							</select>
						</div>
					</div>
				</div>
				<%
				} else if (category == 3) {
				%>
				<div class='input-wrapper'>
					<h3>Thông tin bất động sản</h3>

					<div class='form-item'>
						<p>
							Diện tích <span>*</span>
						</p>
						<div class='input-container'>
							<form:input path="size" id="size"
								placeholder="Nhập diện tích, VD: 80" type="number" min="0"
								step="0.01" />
							<span>m²</span>
						</div>
					</div>

					<div class='contact-wrapper'>
						<div class='form-item'>
							<p>Loại hình văn phòng</p>
							<select name='type' id="type">
								<option value='Văn phòng'>Văn phòng</option>
								<option value='Shophouse'>Shophouse</option>
								<option value='Officetel'>Officetel</option>
							</select>
						</div>

						<div class='form-item'>
							<p>Nội thất</p>
							<select name='furnishingSell' id="furnishing_sell">
								<option value=''>---Nội thất---</option>
								<option value='Hoàn thiện cơ bản'>Hoàn thiện cơ bản</option>
								<option value='Nội thất đầy đủ'>Nội thất đầy đủ</option>
								<option value='Nội thất cao cấp'>Nội thất cao cấp</option>
								<option value='Bàn giao thô'>Bàn giao thô</option>
							</select>
						</div>
					</div>

					<div class='contact-wrapper'>

						<div class='form-item'>
							<p>Giấy tờ pháp lý</p>
							<select name='propertyLegalDocument' id="property_legal_document">
								<option value=''>---Giấy tờ pháp lý---</option>
								<option value='Đã có sổ'>Đã có sổ</option>
								<option value='Đang chờ sổ'>Đang chờ sổ</option>
								<option value='Giấy tờ khác'>Giấy tờ khác</option>
							</select>
						</div>

						<div class='form-item'>
							<p>Hướng nhà</p>
							<select name='direction' id='direction'>
								<option value=''>---Hướng nhà---</option>
								<option value='Bắc'>Bắc</option>
								<option value='Đông Bắc'>Đông Bắc</option>
								<option value='Đông'>Đông</option>
								<option value='Đông Nam'>Đông Nam</option>
								<option value='Nam'>Nam</option>
								<option value='Tây Nam'>Tây Nam</option>
								<option value='Tây'>Tây</option>
								<option value='Tây Bắc'>Tây Bắc</option>
							</select>
						</div>
					</div>

					<div class='form-item'>
						<p>Bất động sản bán gấp</p>
						<select name='urgent' id="urgent">
							<option value='0'>Không</option>
							<option value='1'>Có</option>
						</select>
					</div>

					<p id="result" class="error"></p>
					<div class='money-wrapper'>
						<div class='form-item'>
							<p>
								Mức giá khuyến nghị <span>*</span>
							</p>
							<div class='input-container'>
								<input id="textPrice" type="text" readonly="true" />
								<form:input path="price" id="price" type="number" readonly="true" min="0" style="display: none;" />
							</div>
						</div>

						<div class='form-item'>
							<p>Đơn vị</p>
							<select name='unit'>
								<option value='VND'>VND</option>
							</select>
						</div>
					</div>
				</div>
				<%
				} else if (category == 4) {
				%>
				<div class='input-wrapper'>
					<h3>Thông tin bất động sản</h3>

					<div class='form-item'>
						<p>
							Diện tích <span>*</span>
						</p>
						<div class='input-container'>
							<form:input path="size" id="size"
								placeholder="Nhập diện tích, VD: 80" type="number" min="0"
								step="0.01" />
							<span>m²</span>
						</div>
					</div>

					<div class='contact-wrapper'>
						<div class='form-item'>
							<p>Loại hình đất</p>
							<select name='type' id="type">
								<option value='Đất công nghiệp'>Đất công nghiệp</option>
								<option value='Đất nông nghiệp'>Đất nông nghiệp</option>
								<option value='Đất nền dự án'>Đất nền dự án</option>
								<option value='Đất thổ cư'>Đất thổ cư</option>
							</select>
						</div>

						<div class='form-item'>
							<p>Đặc điểm nhà/đất</p>
							<select name='characteristics' id="characteristics">
								<option value=''>---Đặc điểm nhà/đất---</option>
								<option value='Mặt tiền'>Mặt tiền</option>
								<option value='Hẻm xe hơi'>Hẻm xe hơi</option>
								<option value='Nở hậu'>Nở hậu</option>
								<option value='Chưa có thổ cư'>Chưa có thổ cư</option>
								<option value='Thổ cư 1 phần'>Thổ cư 1 phần</option>
								<option value='Thổ cư toàn bộ'>Thổ cư toàn bộ</option>
								<option value='Không có thổ cư'>Không có thổ cư</option>
							</select>
						</div>
					</div>

					<div class='contact-wrapper'>

						<div class='form-item'>
							<p>Giấy tờ pháp lý</p>
							<select name='propertyLegalDocument' id="property_legal_document">
								<option value=''>---Giấy tờ pháp lý---</option>
								<option value='Đã có sổ'>Đã có sổ</option>
								<option value='Đang chờ sổ'>Đang chờ sổ</option>
								<option value='Giấy tờ khác'>Không có sổ</option>
								<option value='Sổ chung / công chứng vi bằng'>Sổ chung
									/ công chứng vi bằng</option>
								<option value='Giấy tờ viết tay'>Giấy tờ viết tay</option>
							</select>
						</div>

						<div class='form-item'>
							<p>Hướng đất</p>
							<select name='direction' id='direction'>
								<option value=''>---Hướng nhà---</option>
								<option value='Bắc'>Bắc</option>
								<option value='Đông Bắc'>Đông Bắc</option>
								<option value='Đông'>Đông</option>
								<option value='Đông Nam'>Đông Nam</option>
								<option value='Nam'>Nam</option>
								<option value='Tây Nam'>Tây Nam</option>
								<option value='Tây'>Tây</option>
								<option value='Tây Bắc'>Tây Bắc</option>
							</select>
						</div>
					</div>

					<div class='form-item'>
						<p>Bất động sản bán gấp</p>
						<select name='urgent' id="urgent">
							<option value='0'>Không</option>
							<option value='1'>Có</option>
						</select>
					</div>

					<p id="result" class="error"></p>
					<div class='money-wrapper'>
						<div class='form-item'>
							<p>
								Mức giá khuyến nghị <span>*</span>
							</p>
							<div class='input-container'>
								<input id="textPrice" type="text" readonly="true" />
								<form:input path="price" id="price" type="number" readonly="true" min="0" style="display: none;" />
							</div>
						</div>

						<div class='form-item'>
							<p>Đơn vị</p>
							<select name='unit'>
								<option value='VND'>VND</option>
							</select>
						</div>
					</div>
				</div>
				<%
				}
				%>


			</form:form>
		</div>


	</div>

	<script type="text/javascript">
	document.addEventListener('DOMContentLoaded', () => {
	const urlParams = new URLSearchParams(window.location.search);
	const categoryId = urlParams.get('categoryId');
	
	function debounce(func, delay) {
	    let debounceTimer;
	    return function(...args) {
	        clearTimeout(debounceTimer);
	        debounceTimer = setTimeout(() => func.apply(this, args), delay);
	    };
	}
	
	
	
	$('.input-wrapper').on('mouseover', debounce(async function() {
		const districtElement = document.getElementById('districtId');
		const wardElement = document.getElementById('wardId');
		const sizeElement = document.getElementById('size');

		let rooms = 0;
		let toilets = 0;
		let floors = 0;
		let furnishingSell = "";
		let characteristics = ""; 
		let wardId = "";
		let districtId;
		let size = 0;
		let type = "";
		let urgent = "";

		let roomsElement, toiletsElement, floorsElement, furnishingSellElement, characteristicsElement;

		if (categoryId === "1" || categoryId === "2") {
			roomsElement = document.getElementById('rooms');
			toiletsElement = document.getElementById('toilets');
		}

		if (categoryId === "1") {
			floorsElement = document.getElementById('floors');
		}

		const typeElement = document.getElementById('type');

		if (categoryId === "1" || categoryId === "2" || categoryId === "3") {
			furnishingSellElement = document.getElementById('furnishingSell');
		}

		if (categoryId === "1" || categoryId === "4") {
			characteristicsElement = document.getElementById('characteristics');
		}

		const urgentElement = document.getElementById('urgent');

		if (wardElement && wardElement.selectedIndex !== -1) {
			wardId = wardElement.options[wardElement.selectedIndex].textContent !== "---Phường, xã---" ? wardElement.options[wardElement.selectedIndex].value : "";
		}

		if (districtElement && districtElement.selectedIndex !== -1) {
			districtId = districtElement.options[districtElement.selectedIndex].value;
		}

		if (sizeElement && sizeElement.value) {
			size = sizeElement.value;
		}

		if (categoryId === "1" || categoryId === "2") {
			if (roomsElement && roomsElement.value) {
				rooms = roomsElement.value;
			}

			if (toiletsElement && toiletsElement.value) {
				toilets = toiletsElement.value;
			}
		}

		if (categoryId === "1") {
			if (floorsElement && floorsElement.value) {
				floors = floorsElement.value;
			}
		}

		if (typeElement && typeElement.selectedIndex !== -1) {
			type = typeElement.options[typeElement.selectedIndex].textContent;
		}

		if (categoryId === "1" || categoryId === "2" || categoryId === "3") {
			if (furnishingSellElement && furnishingSellElement.selectedIndex !== -1) {
				furnishingSell = furnishingSellElement.options[furnishingSellElement.selectedIndex].textContent !== "---Nội thất---" ? furnishingSellElement.options[furnishingSellElement.selectedIndex].textContent : "";
			}
		}

		if (categoryId === "1" || categoryId === "4") {
			if (characteristicsElement && characteristicsElement.selectedIndex !== -1) {
				characteristics = characteristicsElement.options[characteristicsElement.selectedIndex].textContent !== "---Đặc điểm nhà/đất---" ? characteristicsElement.options[characteristicsElement.selectedIndex].textContent : "";
			}
		}

		if (urgentElement && urgentElement.value) {
			urgent = urgentElement.value;
		}
	    
	    if(wardId!=="" && size!=="0.0") {
	    	if(categoryId === "1") {
		    	 const data = {
	    			 wardId: wardId,
	    			 districtId: districtId,
	    			 size: parseFloat(size),
	    			 rooms: parseInt(rooms),
	    			 toilets: parseInt(toilets),
	    			 floors: parseInt(floors),
	    			 type: type,
	    			 furnishingSell: furnishingSell,
	    			 urgent: urgent,
	    			 characteristics: characteristics,
		         };
	
		         try {
		             const response = await fetch('http://localhost:5000/housePredict', {
		                 method: 'POST',
		                 headers: {
		                     'Content-Type': 'application/json'
		                 },
		                 body: JSON.stringify(data)
		             });
	
		             const result = await response.json();
		             document.getElementById('textPrice').value =  result.predicted_price;
		             const cleanPrice = result.predicted_price.replace(/[^\d]/g, '');
		          	 document.getElementById('price').value = cleanPrice;
		          	 
		          	const fetchRealEstates = await fetch('http://localhost:5000/getRealEstates', {
		                method: 'POST',
		                headers: {
		                    'Content-Type': 'application/json'
		                },
		                body: JSON.stringify({
		                	categoryId: categoryId,
		                    price: cleanPrice, 
		                    districtId: districtId,
		                    wardId: wardId,
		                    size: parseFloat(size),
		                    rooms: parseInt(rooms),
		                    toilets: parseInt(toilets),
			    			floors: parseInt(floors),
			    			type: type,
			    			furnishingSell: furnishingSell,
			    			urgent: urgent,
			    			characteristics: characteristics,
		                })
		            });
		            
		            const estates = await fetchRealEstates.json();		            
		   
		         // Check if there are any estates data
		            if (estates && estates.length > 0) {
		                const postElement = document.querySelector('.post');

		                // Check if recommendListContainer already exists
		                let recommendListContainer = document.querySelector('.recommend-list-container');

		                // If it doesn't exist, create it
		                if (!recommendListContainer) {
		                    recommendListContainer = document.createElement('div');
		                    recommendListContainer.classList.add('recommend-list-container');

		                    recommendListContainer.innerHTML = `
		                        <div class='swiper mySwiper3'>
		                            <div class='recommend-list-header'>
		                                <h5 class='recommend-title'>Bất động sản dành cho bạn</h5>
		                            </div>
		                            <div class='swiper-wrapper'>
		                            </div>
		                            <div class='swiper-button-next'></div>
		                            <div class='swiper-button-prev'></div>
		                        </div>
		                    `;

		                    // Append recommendListContainer after the .post element
		                    postElement.appendChild(recommendListContainer);
		                }

		                // Get swiperWrapper inside the recommendListContainer
		                const swiperWrapper = recommendListContainer.querySelector('.swiper-wrapper');

		                // Clear previous slides before adding new ones
		                swiperWrapper.innerHTML = '';

		                // Loop through the fetched estates data and generate the slides
		                estates.forEach(estate => {
		                	  console.log(estate);
		                	  const imageStr = estate.Images;
		                	  const imgPaths = imageStr ? imageStr.substring(1, imageStr.length - 1).split(',') : [];

		                	  // Tạo phần tử slide
		                	  let slide = document.createElement('div');
		                	  slide.classList.add('swiper-slide');
		                			  
		                	let priceText = ""
		                	if(estate.Price < 1000000000) {
		                		priceText = (estate.Price / 1000000) + " triệu"
		                	} else {
		                		priceText = (estate.Price / 1000000000) + " tỷ"
		                	}

		                	  slide.innerHTML = 
		                	    "<div class='recommend-card'>" +
		                	      "<div class='card-image'>" +
		                	        "<a href='/batdongsan/chi-tiet.html?realEstateId=" + estate.RealEstateId + "'>" +
		                	          "<img src='images/" + imgPaths[0].trim() + "' alt='' />" +
		                	        "</a>" +
		                	        "<div class='card-image-feature'>" +
		                	          "<i class='fa-regular fa-image'></i> <span>" + imgPaths.length + "</span>" +
		                	        "</div>" +
		                	      "</div>" +
		                	      "<div class='card-info-container'>" +
		                	        "<a href='/batdongsan/chi-tiet.html?realEstateId=" + estate.RealEstateId + "'>" +
		                	          "<div class='card-info__title'>" + estate.Title + "</div>" +
		                	        "</a>" +
		                	        "<div class='card-info__config'>" +
		                	          "<span class='card-config__item card-config__price'>" + priceText + "</span>" +
		                	          "<span class='card-config__item card-config__dot'>·</span>" +
		                	          "<span class='card-config__item card-config__area'>" + estate.Size + " m²</span>" +
		                	        "</div>" +
		                	        "<div class='card-info__location'>" +
		                	          "<i class='fa-solid fa-location-dot'></i> <span>" + estate.Address + "</span>" +
		                	        "</div>" +
		                	        "<div class='card-info__contact'>" +
		                	          "<div class='card-published-info' value='" + estate.SubmittedDate + "'></div>" +
		                	        "</div>" +
		                	      "</div>" +
		                	    "</div>";

		                	  // Thêm slide vào swiper-wrapper
		                	  swiperWrapper.appendChild(slide);
		                	});

		                	// Khởi tạo Swiper sau khi tất cả các slide đã được thêm
		                	const swiper = new Swiper('.mySwiper3', {
		                	  slidesPerView: 3,
		                	  spaceBetween: 15,
		                	  navigation: {
		                	    nextEl: ".swiper-button-next",
		                	    prevEl: ".swiper-button-prev",
		                	  },
		                	});

		                	// Cập nhật Swiper nếu cần
		                	swiper.update();
		            }
		         } catch (error) {
		        	 document.getElementById('result').style.display = "none";
		             console.error('Error predicting price:', error);
		             document.getElementById('result').innerText = 'Error predicting price.';
		         }
	         } else if(categoryId === "2") {
	        	 const data = {
	      			wardId: wardId,
	      			districtId: districtId,
	         		size: parseFloat(size),
	         		rooms: parseInt(rooms),
	         		toilets: parseInt(toilets),
	         		type: type,
	         		furnishingSell: furnishingSell,
	         		urgent: urgent,
		         };
	
		         try {
		             const response = await fetch('http://localhost:5000/apartmentPredict', {
		                 method: 'POST',
		                 headers: {
		                     'Content-Type': 'application/json'
		                 },
		                 body: JSON.stringify(data)
		             });
	
		             const result = await response.json();
		             document.getElementById('textPrice').value =  result.predicted_price;
		             const cleanPrice = result.predicted_price.replace(/[^\d]/g, '');
			         document.getElementById('price').value = cleanPrice;
			          	
			          	const fetchRealEstates = await fetch('http://localhost:5000/getRealEstates', {
			                method: 'POST',
			                headers: {
			                    'Content-Type': 'application/json'
			                },
			                body: JSON.stringify({
			                	categoryId: categoryId,
			                    price: cleanPrice, 
			                    districtId: districtId,
			                    wardId: wardId,
			                    size: parseFloat(size),
			                    rooms: parseInt(rooms),
			                    toilets: parseInt(toilets),
				    			floors: parseInt(floors),
				    			type: type,
				    			furnishingSell: furnishingSell,
				    			urgent: urgent,
				    			characteristics: characteristics,
			                })
			            });
			            
			            const estates = await fetchRealEstates.json();		            
			   
			         // Check if there are any estates data
			            if (estates && estates.length > 0) {
			                const postElement = document.querySelector('.post');

			                // Check if recommendListContainer already exists
			                let recommendListContainer = document.querySelector('.recommend-list-container');

			                // If it doesn't exist, create it
			                if (!recommendListContainer) {
			                    recommendListContainer = document.createElement('div');
			                    recommendListContainer.classList.add('recommend-list-container');

			                    recommendListContainer.innerHTML = `
			                        <div class='swiper mySwiper3'>
			                            <div class='recommend-list-header'>
			                                <h5 class='recommend-title'>Bất động sản dành cho bạn</h5>
			                            </div>
			                            <div class='swiper-wrapper'>
			                            </div>
			                            <div class='swiper-button-next'></div>
			                            <div class='swiper-button-prev'></div>
			                        </div>
			                    `;

			                    // Append recommendListContainer after the .post element
			                    postElement.appendChild(recommendListContainer);
			                }

			                // Get swiperWrapper inside the recommendListContainer
			                const swiperWrapper = recommendListContainer.querySelector('.swiper-wrapper');

			                // Clear previous slides before adding new ones
			                swiperWrapper.innerHTML = '';

			                // Loop through the fetched estates data and generate the slides
			                estates.forEach(estate => {
			                	  console.log(estate);
			                	  const imageStr = estate.Images;
			                	  const imgPaths = imageStr ? imageStr.substring(1, imageStr.length - 1).split(',') : [];

			                	  // Tạo phần tử slide
			                	  let slide = document.createElement('div');
			                	  slide.classList.add('swiper-slide');
			                			  
			                	let priceText = ""
			                	if(estate.Price < 1000000000) {
			                		priceText = (estate.Price / 1000000) + " triệu"
			                	} else {
			                		priceText = (estate.Price / 1000000000) + " tỷ"
			                	}

			                	  slide.innerHTML = 
			                	    "<div class='recommend-card'>" +
			                	      "<div class='card-image'>" +
			                	        "<a href='/batdongsan/chi-tiet.html?realEstateId=" + estate.RealEstateId + "'>" +
			                	          "<img src='images/" + imgPaths[0].trim() + "' alt='' />" +
			                	        "</a>" +
			                	        "<div class='card-image-feature'>" +
			                	          "<i class='fa-regular fa-image'></i> <span>" + imgPaths.length + "</span>" +
			                	        "</div>" +
			                	      "</div>" +
			                	      "<div class='card-info-container'>" +
			                	        "<a href='/batdongsan/chi-tiet.html?realEstateId=" + estate.RealEstateId + "'>" +
			                	          "<div class='card-info__title'>" + estate.Title + "</div>" +
			                	        "</a>" +
			                	        "<div class='card-info__config'>" +
			                	          "<span class='card-config__item card-config__price'>" + priceText + "</span>" +
			                	          "<span class='card-config__item card-config__dot'>·</span>" +
			                	          "<span class='card-config__item card-config__area'>" + estate.Size + " m²</span>" +
			                	        "</div>" +
			                	        "<div class='card-info__location'>" +
			                	          "<i class='fa-solid fa-location-dot'></i> <span>" + estate.Address + "</span>" +
			                	        "</div>" +
			                	        "<div class='card-info__contact'>" +
			                	          "<div class='card-published-info' value='" + estate.SubmittedDate + "'></div>" +
			                	        "</div>" +
			                	      "</div>" +
			                	    "</div>";

			                	  // Thêm slide vào swiper-wrapper
			                	  swiperWrapper.appendChild(slide);
			                	});

			                	// Khởi tạo Swiper sau khi tất cả các slide đã được thêm
			                	const swiper = new Swiper('.mySwiper3', {
			                	  slidesPerView: 3,
			                	  spaceBetween: 15,
			                	  navigation: {
			                	    nextEl: ".swiper-button-next",
			                	    prevEl: ".swiper-button-prev",
			                	  },
			                	});

			                	// Cập nhật Swiper nếu cần
			                	swiper.update();
			            }
		         } catch (error) {
		        	 document.getElementById('result').style.display = "none";
		             console.error('Error predicting price:', error);
		             document.getElementById('result').innerText = 'Error predicting price.';
		         }
             } else if(categoryId === "3") {
            	 const data = {
          			wardId: wardId,
          			districtId: districtId,
	         		size: parseFloat(size),
	         		type: type,
	         		furnishingSell: furnishingSell,
	         		urgent: urgent,
		         };
	
		         try {
		             const response = await fetch('http://localhost:5000/commercialPredict', {
		                 method: 'POST',
		                 headers: {
		                     'Content-Type': 'application/json'
		                 },
		                 body: JSON.stringify(data)
		             });
	
		             const result = await response.json();
		             document.getElementById('textPrice').value = result.predicted_price;
		             const cleanPrice = result.predicted_price.replace(/[^\d]/g, '');
		          	 document.getElementById('price').value = cleanPrice;
		          	 
		          	const fetchRealEstates = await fetch('http://localhost:5000/getRealEstates', {
		                method: 'POST',
		                headers: {
		                    'Content-Type': 'application/json'
		                },
		                body: JSON.stringify({
		                	categoryId: categoryId,
		                    price: cleanPrice, 
		                    districtId: districtId,
		                    wardId: wardId,
		                    size: parseFloat(size),
		                    rooms: parseInt(rooms),
		                    toilets: parseInt(toilets),
			    			floors: parseInt(floors),
			    			type: type,
			    			furnishingSell: furnishingSell,
			    			urgent: urgent,
			    			characteristics: characteristics,
		                })
		            });
		            
		            const estates = await fetchRealEstates.json();		            
		   
		         // Check if there are any estates data
		            if (estates && estates.length > 0) {
		                const postElement = document.querySelector('.post');

		                // Check if recommendListContainer already exists
		                let recommendListContainer = document.querySelector('.recommend-list-container');

		                // If it doesn't exist, create it
		                if (!recommendListContainer) {
		                    recommendListContainer = document.createElement('div');
		                    recommendListContainer.classList.add('recommend-list-container');

		                    recommendListContainer.innerHTML = `
		                        <div class='swiper mySwiper3'>
		                            <div class='recommend-list-header'>
		                                <h5 class='recommend-title'>Bất động sản dành cho bạn</h5>
		                            </div>
		                            <div class='swiper-wrapper'>
		                            </div>
		                            <div class='swiper-button-next'></div>
		                            <div class='swiper-button-prev'></div>
		                        </div>
		                    `;

		                    // Append recommendListContainer after the .post element
		                    postElement.appendChild(recommendListContainer);
		                }

		                // Get swiperWrapper inside the recommendListContainer
		                const swiperWrapper = recommendListContainer.querySelector('.swiper-wrapper');

		                // Clear previous slides before adding new ones
		                swiperWrapper.innerHTML = '';

		                // Loop through the fetched estates data and generate the slides
		                estates.forEach(estate => {
		                	  console.log(estate);
		                	  const imageStr = estate.Images;
		                	  const imgPaths = imageStr ? imageStr.substring(1, imageStr.length - 1).split(',') : [];

		                	  // Tạo phần tử slide
		                	  let slide = document.createElement('div');
		                	  slide.classList.add('swiper-slide');
		                			  
		                	let priceText = ""
		                	if(estate.Price < 1000000000) {
		                		priceText = (estate.Price / 1000000) + " triệu"
		                	} else {
		                		priceText = (estate.Price / 1000000000) + " tỷ"
		                	}

		                	  slide.innerHTML = 
		                	    "<div class='recommend-card'>" +
		                	      "<div class='card-image'>" +
		                	        "<a href='/batdongsan/chi-tiet.html?realEstateId=" + estate.RealEstateId + "'>" +
		                	          "<img src='images/" + imgPaths[0].trim() + "' alt='' />" +
		                	        "</a>" +
		                	        "<div class='card-image-feature'>" +
		                	          "<i class='fa-regular fa-image'></i> <span>" + imgPaths.length + "</span>" +
		                	        "</div>" +
		                	      "</div>" +
		                	      "<div class='card-info-container'>" +
		                	        "<a href='/batdongsan/chi-tiet.html?realEstateId=" + estate.RealEstateId + "'>" +
		                	          "<div class='card-info__title'>" + estate.Title + "</div>" +
		                	        "</a>" +
		                	        "<div class='card-info__config'>" +
		                	          "<span class='card-config__item card-config__price'>" + priceText + "</span>" +
		                	          "<span class='card-config__item card-config__dot'>·</span>" +
		                	          "<span class='card-config__item card-config__area'>" + estate.Size + " m²</span>" +
		                	        "</div>" +
		                	        "<div class='card-info__location'>" +
		                	          "<i class='fa-solid fa-location-dot'></i> <span>" + estate.Address + "</span>" +
		                	        "</div>" +
		                	        "<div class='card-info__contact'>" +
		                	          "<div class='card-published-info' value='" + estate.SubmittedDate + "'></div>" +
		                	        "</div>" +
		                	      "</div>" +
		                	    "</div>";

		                	  // Thêm slide vào swiper-wrapper
		                	  swiperWrapper.appendChild(slide);
		                	});

		                	// Khởi tạo Swiper sau khi tất cả các slide đã được thêm
		                	const swiper = new Swiper('.mySwiper3', {
		                	  slidesPerView: 3,
		                	  spaceBetween: 15,
		                	  navigation: {
		                	    nextEl: ".swiper-button-next",
		                	    prevEl: ".swiper-button-prev",
		                	  },
		                	});

		                	// Cập nhật Swiper nếu cần
		                	swiper.update();
		            }
		         } catch (error) {
		        	 document.getElementById('result').style.display = "none";
		             console.error('Error predicting price:', error);
		             document.getElementById('result').innerText = 'Error predicting price.';
		         }
             } else if(categoryId === "4") {
            	 const data = {
           			wardId: wardId,
           			districtId: districtId,
   	         		size: parseFloat(size),
   	         		type: type,
   	         		characteristics: characteristics,
   	         		urgent: urgent,
   		         };
   	
   		         try {
   		             const response = await fetch('http://localhost:5000/landPredict', {
   		                 method: 'POST',
   		                 headers: {
   		                     'Content-Type': 'application/json'
   		                 },
   		                 body: JSON.stringify(data)
   		             });
   	
   		             const result = await response.json();
		             document.getElementById('textPrice').value =  result.predicted_price;
		             const cleanPrice = result.predicted_price.replace(/[^\d]/g, '');
			          	document.getElementById('price').value = cleanPrice;
			          	
			          	const fetchRealEstates = await fetch('http://localhost:5000/getRealEstates', {
			                method: 'POST',
			                headers: {
			                    'Content-Type': 'application/json'
			                },
			                body: JSON.stringify({
			                	categoryId: categoryId,
			                    price: cleanPrice, 
			                    districtId: districtId,
			                    wardId: wardId,
			                    size: parseFloat(size),
			                    rooms: parseInt(rooms),
			                    toilets: parseInt(toilets),
				    			floors: parseInt(floors),
				    			type: type,
				    			furnishingSell: furnishingSell,
				    			urgent: urgent,
				    			characteristics: characteristics,
			                })
			            });
			            
			            const estates = await fetchRealEstates.json();		            
			   
			         // Check if there are any estates data
			            if (estates && estates.length > 0) {
			                const postElement = document.querySelector('.post');

			                // Check if recommendListContainer already exists
			                let recommendListContainer = document.querySelector('.recommend-list-container');

			                // If it doesn't exist, create it
			                if (!recommendListContainer) {
			                    recommendListContainer = document.createElement('div');
			                    recommendListContainer.classList.add('recommend-list-container');

			                    recommendListContainer.innerHTML = `
			                        <div class='swiper mySwiper3'>
			                            <div class='recommend-list-header'>
			                                <h5 class='recommend-title'>Bất động sản dành cho bạn</h5>
			                            </div>
			                            <div class='swiper-wrapper'>
			                            </div>
			                            <div class='swiper-button-next'></div>
			                            <div class='swiper-button-prev'></div>
			                        </div>
			                    `;

			                    // Append recommendListContainer after the .post element
			                    postElement.appendChild(recommendListContainer);
			                }

			                // Get swiperWrapper inside the recommendListContainer
			                const swiperWrapper = recommendListContainer.querySelector('.swiper-wrapper');

			                // Clear previous slides before adding new ones
			                swiperWrapper.innerHTML = '';

			                // Loop through the fetched estates data and generate the slides
			                estates.forEach(estate => {
			                	  console.log(estate);
			                	  const imageStr = estate.Images;
			                	  const imgPaths = imageStr ? imageStr.substring(1, imageStr.length - 1).split(',') : [];

			                	  // Tạo phần tử slide
			                	  let slide = document.createElement('div');
			                	  slide.classList.add('swiper-slide');
			                			  
			                	let priceText = ""
			                	if(estate.Price < 1000000000) {
			                		priceText = (estate.Price / 1000000) + " triệu"
			                	} else {
			                		priceText = (estate.Price / 1000000000) + " tỷ"
			                	}

			                	  slide.innerHTML = 
			                	    "<div class='recommend-card'>" +
			                	      "<div class='card-image'>" +
			                	        "<a href='/batdongsan/chi-tiet.html?realEstateId=" + estate.RealEstateId + "'>" +
			                	          "<img src='images/" + imgPaths[0].trim() + "' alt='' />" +
			                	        "</a>" +
			                	        "<div class='card-image-feature'>" +
			                	          "<i class='fa-regular fa-image'></i> <span>" + imgPaths.length + "</span>" +
			                	        "</div>" +
			                	      "</div>" +
			                	      "<div class='card-info-container'>" +
			                	        "<a href='/batdongsan/chi-tiet.html?realEstateId=" + estate.RealEstateId + "'>" +
			                	          "<div class='card-info__title'>" + estate.Title + "</div>" +
			                	        "</a>" +
			                	        "<div class='card-info__config'>" +
			                	          "<span class='card-config__item card-config__price'>" + priceText + "</span>" +
			                	          "<span class='card-config__item card-config__dot'>·</span>" +
			                	          "<span class='card-config__item card-config__area'>" + estate.Size + " m²</span>" +
			                	        "</div>" +
			                	        "<div class='card-info__location'>" +
			                	          "<i class='fa-solid fa-location-dot'></i> <span>" + estate.Address + "</span>" +
			                	        "</div>" +
			                	        "<div class='card-info__contact'>" +
			                	          "<div class='card-published-info' value='" + estate.SubmittedDate + "'></div>" +
			                	        "</div>" +
			                	      "</div>" +
			                	    "</div>";

			                	  // Thêm slide vào swiper-wrapper
			                	  swiperWrapper.appendChild(slide);
			                	});

			                	// Khởi tạo Swiper sau khi tất cả các slide đã được thêm
			                	const swiper = new Swiper('.mySwiper3', {
			                	  slidesPerView: 3,
			                	  spaceBetween: 15,
			                	  navigation: {
			                	    nextEl: ".swiper-button-next",
			                	    prevEl: ".swiper-button-prev",
			                	  },
			                	});

			                	// Cập nhật Swiper nếu cần
			                	swiper.update();
			            }
   		         } catch (error) {
   		        	 document.getElementById('result').style.display = "none";
   		             console.error('Error predicting price:', error);
   		             document.getElementById('result').innerText = 'Error predicting price.';
   		         }
             }
	         
	    } else {
	    	document.getElementById('result').style.display = "none";
	    }
	}, 1000));
	
	$(document).ready(function() {
		var swiper3 = new Swiper(".mySwiper3", {
		    slidesPerView: 3,
		    spaceBetween: 15,
		    navigation: {
		        nextEl: ".swiper-button-next",
		        prevEl: ".swiper-button-prev",
		    },
		});
		
		 
		 
		 $(".card-published-info").each(function() {
		        var submittedTime = $(this).attr("value").trim();
		        var timeAgo = moment(submittedTime).locale('vi').fromNow(); 
		        $(this).text(timeAgo); 
		    });
		 
		
			var districtId = $('#districtId').val();
			$.ajax({
                type: 'GET',
                url: '${pageContext.servletContext.contextPath}/sellernet/getWardsByDistrict.html',
                data: { districtId: districtId },
                dataType: 'text',
                success: function(data) {
                    $('#wardId').empty();
                    $('#wardId').append('<option value="">---Phường, xã---</option>');
                    var lines = data.split('\n');
                    var currentWard = "<c:out value='${realEstate.ward.name}' />";
                    $.each(lines, function(index, line) {
                        if (index < lines.length - 1) {
                            var parts = line.split(':');
                            var isSelected = (currentWard === parts[1]) ? "selected" : "";
                            $('#wardId').append('<option ' + isSelected + ' value="' + parts[0] + '">' + parts[1] + '</option>');
                        }
                    });
                },
                error: function(data) {
                    $('#wardId').empty();
                    $('#wardId').append('<option value="">Error occurred while fetching wards</option>');
                }
            });

				
				$('#districtId').change(function() {
				    var districtId = $(this).val();
				    $.ajax({
				        type: 'GET',
				        url: '${pageContext.servletContext.contextPath}/sellernet/getWardsByDistrict.html',
				        data: { districtId: districtId },
				        dataType: 'text',
				        success: function(data) {
			                $('#wardId').empty();
			                $('#wardId').append('<option value="">---Phường, xã---</option>');
			                $("#detail-address").val("");
			                var lines = data.split('\n');
			                $.each(lines, function(index, line) {
			                    if (index < lines.length - 1) {
			                        var parts = line.split(':');
			                        $('#wardId').append('<option value="' + parts[0] + '">' + parts[1] + '</option>');
			                    }
			                });
			            },
			            error: function(data) {
			                $('#wardId').empty();
			                $('#wardId').append('<option value="">Error occurred while fetching districts</option>');
			            }
				    });
				});
			    
		        $('#wardId').change(function() {
		        	$("#detail-address").val("");
		            var province = $("#provinceId").children("option:selected").text();
		            var district = $("#districtId").children("option:selected").text();
		            var ward = $(this).children("option:selected").text();

		            if(district !== "---Quận, huyện---" && ward !== "---Phường, xã---") {
		            	// Construct the address
			            var address = ward.trim() + ", " + district.trim() + ", Thành phố Hồ Chí Minh";                  
			            
			            // Update the detail-address element
			            $("#detail-address").val($("#detail-address").val() + address);
		            }
		        });
	});
	});
	</script>
</body>
</html>