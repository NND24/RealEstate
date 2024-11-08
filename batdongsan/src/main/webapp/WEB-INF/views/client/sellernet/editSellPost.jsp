<%@page import="batdongsan.models.HCMDistrictsModel"%>
<%@page import="batdongsan.models.HCMRealEstateModel"%>
<%@ page import="java.text.DecimalFormat" %>
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
<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/client/index.css" type="text/css">
<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/client/header.css?version=53""
	type="text/css">
<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/client/sellernet.css"
	type="text/css">
<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/client/post.css?version=53"
	type="text/css">
<%@ include file="../../../../links/links.jsp"%>
<base href="${pageContext.servletContext.contextPath}/">
</head>
<body>
	<%@ include file="../../../components/header.jsp"%>
	<div class='sellernet'>
		<%@ include file="../../../components/sellernetSidebar.jsp"%>

		<!-- Post -->
		<div class='post'>
			<form:form action="sellernet/editRealEstate.html" modelAttribute="realEstate"
				method="POST" enctype="multipart/form-data">
				<% 
				HCMRealEstateModel realEstate = (HCMRealEstateModel) request.getAttribute("realEstate");
				%>

				<div class='input-wrapper'>

					<h3>Thông tin cơ bản</h3>

					<ul class='nav nav-tabs'>
						<li class='active'><a
							href='${pageContext.servletContext.contextPath}/sellernet/dang-tin/ban.html'>
								Bán </a></li>
					<!-- 	<li><a
							href='${pageContext.servletContext.contextPath}/sellernet/dang-tin/cho-thue.html'>
								Cho thuê </a></li>  -->
					</ul>

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
								<select name="categoryId" onchange="window.location.href='<%= pageContext.getServletContext().getContextPath() %>/sellernet/chinh-sua/ban.html?realEstateId=<%= realEstate.getRealEstateId() %>&categoryId=' + this.value;">
								    <%
								    for (CategoryModel cat : categories) {
								        String selected = (cat.getCategoryId() == category) ? "selected" : "";
								    %>
								    <option value="<%= cat.getCategoryId() %>" <%= selected %>>
								        <%= cat.getName() %>
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
								<option <%= realEstate.getWard().getDistrict().getName()==district.getName() ? "selected" : "" %> value="<%=district.getDistrictId()%>"><%=district.getName()%></option>
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
							<p class="error" style="<%= (wardError != null && !wardError.isEmpty()) ? "display: block;" : "display: none;" %>">
							    <%= wardError %>
							</p>
						</div>
					</div>

					<div class='form-item'>
						<p>
							Địa chỉ hiển thị trên tin đăng <span>*</span>
						</p>
						<div class='input-container'>
							<form:input path='address'
								placeholder='Bạn có thể bổ sung hẻm, nghách, ngõ...'
								id="detail-address" />
						</div>
						<%
						    String addressError = (String) request.getAttribute("addressError");
						%>
						<p class="error" style="<%= (addressError != null && !addressError.isEmpty()) ? "display: block;" : "display: none;" %>">
						    <%= addressError %>
						</p>
					</div>
				</div>

				<div class='input-wrapper'>
					<h3>Thông tin bài viết</h3>
					<div class='form-item'>
						<p>
							Tiêu đề <span>*</span>
						</p>
						<form:textarea path='title' cols='30' rows='2'></form:textarea>
						<%
						    String titleError = (String) request.getAttribute("titleError");
						%>
						<p class="error" style="<%= (titleError != null && !titleError.isEmpty()) ? "display: block;" : "display: none;" %>">
						    <%= titleError %>
						</p>
					</div>
					<div class='form-item'>
						<p>
							Mô tả <span>*</span>
						</p>
						<form:textarea id="editor" path='description' cols='30' rows='7'></form:textarea>
						<%
						    String descriptionError = (String) request.getAttribute("descriptionError");
						%>
						<p class="error" style="<%= (descriptionError != null && !descriptionError.isEmpty()) ? "display: block;" : "display: none;" %>">
						    <%= descriptionError %>
						</p>
					</div>
				</div>


				<%
				if (category==1) {
				%>
				<div class='input-wrapper'>
					<h3>Thông tin bất động sản</h3>

					<div class='form-item'>
						<p>
							Diện tích <span>*</span>
						</p>
						<div class='input-container'>
							<form:input path="size" id="size" placeholder="Nhập diện tích, VD: 80" type="number" min="0" oninput="this.value = Math.abs(this.value)" />
							<span>m²</span>
						</div>
						<%
						    String sizeError = (String) request.getAttribute("sizeError");
						%>
						<p class="error" style="<%= (sizeError != null && !sizeError.isEmpty()) ? "display: block;" : "display: none;" %>">
						    <%= sizeError %>
						</p>
					</div>

					<div class='contact-wrapper'>
						<div class='form-item'>
							<p>Số phòng ngủ</p>
							<div class='input-container'>
								<form:input path="rooms" id="rooms"
									placeholder="Nhập số phòng, VD: 2" type="number" min="0" oninput="this.value = Math.abs(this.value)" />
								<span>phòng</span>
							</div>
						</div>
						<div class='form-item'>
							<p>Số phòng tắm, vệ sinh</p>
							<div class='input-container'>
								<form:input path="toilets" id="toilets"
									placeholder="Nhập số phòng, VD: 2" type="number" min="0" oninput="this.value = Math.abs(this.value)" />
								<span>phòng</span>
							</div>
						</div>
					</div>
					
					<div class='contact-wrapper'>
						<div class='form-item'>
							<p>Số tầng</p>
							<div class='input-container'>
								<form:input path="floors" id="floors"
									placeholder="Nhập số tầng, VD: 2" type="number" min="0" oninput="this.value = Math.abs(this.value)" />
								<span>tầng</span>
							</div>
						</div>
						<div class='form-item'>
							<p>Loại hình nhà ở</p>
							<select name='type' id="type">
								<option <%= (realEstate.getType() != null && realEstate.getType().equals("Nhà ngõ, hẻm")) ? "selected" : "" %> value='Nhà ngõ, hẻm'>Nhà ngõ, hẻm</option>
								<option <%= realEstate.getType().equals("Nhà mặt phố, mặt tiềnm") ? "selected" : "" %> value='Nhà mặt phố, mặt tiền'>Nhà mặt phố, mặt tiền</option>
								<option <%= realEstate.getType().equals("Nhà phố liền kề") ? "selected" : "" %> value='Nhà phố liền kề'>Nhà phố liền kề</option>
								<option <%= realEstate.getType().equals("Nhà biệt thự") ? "selected" : "" %> value='Nhà biệt thự'>Nhà biệt thự</option>
							</select>
						</div>
					</div>
					
					<div class='form-item'>
						<p>Đặc điểm nhà/đất</p>
						<select name='characteristics' id="characteristics">
							<option <%= (realEstate.getCharacteristics() != null && realEstate.getCharacteristics().equals("")) ? "selected" : "" %> value=''>---Đặc điểm nhà/đất---</option>
							<option <%= realEstate.getCharacteristics().equals("Hẻm xe hơi") ? "selected" : "" %> value='Hẻm xe hơi'>Hẻm xe hơi</option>
							<option <%= realEstate.getCharacteristics().equals("Nhà nở hậu") ? "selected" : "" %> value='Nhà nở hậu'>Nhà nở hậu</option>
							<option <%= realEstate.getCharacteristics().equals("Nhà tóp hậu") ? "selected" : "" %> value='Nhà tóp hậu'>Nhà tóp hậu</option>
							<option <%= realEstate.getCharacteristics().equals("Nhà dính quy hoạch / lộ giới'>Nhà dính quy hoạch / lộ giới") ? "selected" : "" %> value='Nhà dính quy hoạch / lộ giới'>Nhà dính quy hoạch / lộ giới</option>
							<option <%= realEstate.getCharacteristics().equals("Nhà chưa hoàn công") ? "selected" : "" %> value='Nhà chưa hoàn công'>Nhà chưa hoàn công</option>
							<option <%= realEstate.getCharacteristics().equals("Nhà nát") ? "selected" : "" %> value='Nhà nát'>Nhà nát</option>
							<option <%= realEstate.getCharacteristics().equals("Đất chưa chuyển thổ") ? "selected" : "" %> value='Đất chưa chuyển thổ'>Đất chưa chuyển thổ</option>
						</select>
					</div>
					
					<div class='form-item'>
						<p>Giấy tờ pháp lý</p>
						<select name='propertyLegalDocument' id="property_legal_document">
							<option <%= realEstate.getPropertyLegalDocument().equals("") ? "selected" : "" %> value=''>---Giấy tờ pháp lý---</option>
							<option <%= realEstate.getPropertyLegalDocument().equals("Đã có sổ") ? "selected" : "" %>  value='Đã có sổ'>Đã có sổ</option>
							<option <%= realEstate.getPropertyLegalDocument().equals("Đang chờ sổ") ? "selected" : "" %>  value='Đang chờ sổ'>Đang chờ sổ</option>
							<option <%= realEstate.getPropertyLegalDocument().equals("Không có sổ") ? "selected" : "" %>  value='Không có sổ'>Không có sổ</option>
							<option <%= realEstate.getPropertyLegalDocument().equals("Sổ chung / công chứng vi bằng'>Sổ chung / công chứng vi bằng") ? "selected" : "" %>  value='Sổ chung / công chứng vi bằng'>Sổ chung / công chứng vi bằng</option>
							<option <%= realEstate.getPropertyLegalDocument().equals("Giấy tờ viết tay") ? "selected" : "" %>  value='Giấy tờ viết tay'>Giấy tờ viết tay</option>
						</select>
					</div>
					
					<div class='contact-wrapper'>
						<div class='form-item'>
							<p>Nội thất</p>
							<select name='furnishingSell' id="furnishing_sell">
								<option <%= (realEstate.getFurnishingSell() != null && realEstate.getFurnishingSell().equals("")) ? "selected" : "" %> value=''>---Nội thất---</option>
								<option <%= realEstate.getFurnishingSell().equals("Hoàn thiện cơ bản") ? "selected" : "" %> value='Hoàn thiện cơ bản'>Hoàn thiện cơ bản</option>
								<option <%= realEstate.getFurnishingSell().equals("Nội thất đầy đủ") ? "selected" : "" %> value='Nội thất đầy đủ'>Nội thất đầy đủ</option>
								<option <%= realEstate.getFurnishingSell().equals("Nội thất cao cấp") ? "selected" : "" %> value='Nội thất cao cấp'>Nội thất cao cấp</option>
								<option <%= realEstate.getFurnishingSell().equals("Bàn giao thô") ? "selected" : "" %> value='Bàn giao thô'>Bàn giao thô</option>
							</select>
						</div>
						<div class='form-item'>
							<p>Hướng nhà</p>
							<select name='direction' id='direction'>
								<option <%= realEstate.getDirection().equals("") ? "selected" : "" %> value=''>---Hướng nhà---</option>
								<option <%= realEstate.getDirection().equals("Bắc") ? "selected" : "" %> value='Bắc'>Bắc</option>
								<option <%= realEstate.getDirection().equals("Đông Bắc") ? "selected" : "" %> value='Đông Bắc'>Đông Bắc</option>
								<option <%= realEstate.getDirection().equals("Đông") ? "selected" : "" %> value='Đông'>Đông</option>
								<option <%= realEstate.getDirection().equals("Đông Nam") ? "selected" : "" %> value='Đông Nam'>Đông Nam</option>
								<option <%= realEstate.getDirection().equals("Nam") ? "selected" : "" %> value='Nam'>Nam</option>
								<option <%= realEstate.getDirection().equals("Tây Nam") ? "selected" : "" %> value='Tây Nam'>Tây Nam</option>
								<option <%= realEstate.getDirection().equals("Tây") ? "selected" : "" %> value='Tây'>Tây</option>
								<option <%= realEstate.getDirection().equals("Tây Bắc") ? "selected" : "" %> value='Tây Bắc'>Tây Bắc</option>
							</select>
						</div>
					</div>
					
					<div class='form-item'>
						<p>Cần bán gấp không?</p>
						<select name='urgent' id="urgent">
							<option <%= realEstate.isUrgent() == false ? "selected" : "" %> value='0'>Không</option>
							<option <%= realEstate.isUrgent() == true ? "selected" : "" %> value='1'>Có</option>
						</select>
					</div>
					
					<p id="result"  class="error"></p>
					<div class='money-wrapper'>
						<div class='form-item'>
						    <p>Mức giá <span>*</span></p>
						    <div class='input-container'>
						        <%
						        Object priceValue = request.getAttribute("price");
						
						        // Ensure priceValue is converted to a number before formatting
						        DecimalFormat df = new DecimalFormat("#");
						        df.setMaximumFractionDigits(0);  // No decimal places
						        df.setGroupingUsed(false);  // Disable comma separators
						        String formattedPrice = priceValue != null ? df.format(priceValue) : "";
						        %>
						        <form:input path="price" placeholder="Nhập giá, VD 12000000" type="number" min="0" value="<%= formattedPrice %>"  oninput="this.value = Math.abs(this.value)"/>
						    </div>
						    <%
						    String priceError = (String) request.getAttribute("priceError");
						    %>
						    <p class="error" style="<%= (priceError != null && !priceError.isEmpty()) ? "display: block;" : "display: none;" %>">
						        <%= priceError %>
						    </p>
						</div>


						<div class='form-item'>
							<p>Đơn vị</p>
							<select name='unit'>
						        <option <%= realEstate.getUnit().equals("VND") ? "selected" : "" %> value='VND'>VND</option>
						        <option <%= realEstate.getUnit().equals("Giá / m²") ? "selected" : "" %> value='Giá / m²'>Giá / m²</option>
						        <option <%= realEstate.getUnit().equals("Thỏa thuận") ? "selected" : "" %> value='Thỏa thuận'>Thỏa thuận</option>
						    </select>
						</div>
					</div>
				</div>
				<% } else if (category==2) { %>
				<div class='input-wrapper'>
					<h3>Thông tin bất động sản</h3>

					<div class='form-item'>
						<p>
							Diện tích <span>*</span>
						</p>
						<div class='input-container'>
							<form:input path="size" id="size" placeholder="Nhập diện tích, VD: 80" type="number" min="0" oninput="this.value = Math.abs(this.value)" />
							<span>m²</span>
						</div>
						<%
						    String sizeError = (String) request.getAttribute("sizeError");
						%>
						<p class="error" style="<%= (sizeError != null && !sizeError.isEmpty()) ? "display: block;" : "display: none;" %>">
						    <%= sizeError %>
						</p>
					</div>

					<div class='contact-wrapper'>
						<div class='form-item'>
							<p>Số phòng ngủ</p>
							<div class='input-container'>
								<form:input path="rooms" id="rooms"
									placeholder="Nhập số phòng, VD: 2" type="number" min="0" oninput="this.value = Math.abs(this.value)" />
								<span>phòng</span>
							</div>
						</div>
						<div class='form-item'>
							<p>Số phòng tắm, vệ sinh</p>
							<div class='input-container'>
								<form:input path="toilets" id="toilets"
									placeholder="Nhập số phòng, VD: 2" type="number" min="0" oninput="this.value = Math.abs(this.value)" />
								<span>phòng</span>
							</div>
						</div>
					</div>
					
					<div class='form-item'>
						<p>Tình trạng bất động sản</p>
						<select name='propertyStatus' id="property_status">
							<option <%= (realEstate.getPropertyStatus() != null && realEstate.getPropertyStatus().equals("")) ? "selected" : "" %> value=''>---Tình trạng---</option>
							<option <%= realEstate.getPropertyStatus().equals("Đã bàn giao") ? "selected" : "" %> value='Đã bàn giao'>Đã bàn giao</option>
							<option <%= realEstate.getPropertyStatus().equals("Chưa bàn giao") ? "selected" : "" %> value='Chưa bàn giao'>Chưa bàn giao</option>
						</select>
					</div>
					
					
					<div class='form-item'>
						<p>Giấy tờ pháp lý</p>
						<select name='propertyLegalDocument' id="property_legal_document">
							<option <%= (realEstate.getPropertyLegalDocument() != null && realEstate.getPropertyLegalDocument().equals("")) ? "selected" : "" %> value=''>---Giấy tờ pháp lý---</option>
							<option <%= realEstate.getPropertyLegalDocument().equals("Hợp đồng đặt cọc") ? "selected" : "" %> value='Hợp đồng đặt cọc'>Hợp đồng đặt cọc</option>
							<option <%= realEstate.getPropertyLegalDocument().equals("Hợp đồng mua bán") ? "selected" : "" %> value='Hợp đồng mua bán'>Hợp đồng mua bán</option>
							<option <%= realEstate.getPropertyLegalDocument().equals("Sổ hồng riêng") ? "selected" : "" %> value='Sổ hồng riêng'>Sổ hồng riêng</option>
							<option <%= realEstate.getPropertyLegalDocument().equals("Đang chờ sổ") ? "selected" : "" %> value='Đang chờ sổ'>Đang chờ sổ</option>
						</select>
					</div>
										
					<div class='contact-wrapper'>
						<div class='form-item'>
							<p>Loại hình căn hộ</p>
							<select name='type' id="type">
								<option <%= (realEstate.getType() != null && realEstate.getType().equals("Chung cư")) ? "selected" : "" %> value='Chung cư'>Chung cư</option>
								<option <%= realEstate.getType().equals("Duplex") ? "selected" : "" %> value='Duplex'>Duplex</option>
								<option <%= realEstate.getType().equals("Penthouse") ? "selected" : "" %> value='Penthouse'>Penthouse</option>
								<option <%= realEstate.getType().equals("Căn hộ dịch vụ, mini") ? "selected" : "" %> value='Căn hộ dịch vụ, mini'>Căn hộ dịch vụ, mini</option>
								<option <%= realEstate.getType().equals("Tập thể, cư xá") ? "selected" : "" %> value='Tập thể, cư xá'>Tập thể, cư xá</option>
								<option <%= realEstate.getType().equals("Officetel") ? "selected" : "" %> value='Officetel'>Officetel</option>
							</select>
						</div>
					
						<div class='form-item'>
							<p>Nội thất</p>
							<select name='furnishingSell' id="furnishing_sell">
								<option <%= realEstate.getFurnishingSell().equals("") ? "selected" : "" %> value=''>---Nội thất---</option>
								<option <%= realEstate.getFurnishingSell().equals("Hoàn thiện cơ bản") ? "selected" : "" %> value='Hoàn thiện cơ bản'>Hoàn thiện cơ bản</option>
								<option <%= realEstate.getFurnishingSell().equals("Nội thất đầy đủ") ? "selected" : "" %> value='Nội thất đầy đủ'>Nội thất đầy đủ</option>
								<option <%= realEstate.getFurnishingSell().equals("Nội thất cao cấp") ? "selected" : "" %> value='Nội thất cao cấp'>Nội thất cao cấp</option>
								<option <%= realEstate.getFurnishingSell().equals("Bàn giao thô") ? "selected" : "" %> value='Bàn giao thô'>Bàn giao thô</option>
							</select>
						</div>
					</div>
					
					<div class='contact-wrapper'>
						<div class='form-item'>
							<p>Hướng cửa chính</p>
							<select name='direction' id='direction'>
								<option <%= realEstate.getDirection().equals("") ? "selected" : "" %> value=''>---Hướng nhà---</option>
								<option <%= realEstate.getDirection().equals("Bắc") ? "selected" : "" %> value='Bắc'>Bắc</option>
								<option <%= realEstate.getDirection().equals("Đông Bắc") ? "selected" : "" %> value='Đông Bắc'>Đông Bắc</option>
								<option <%= realEstate.getDirection().equals("Đông") ? "selected" : "" %> value='Đông'>Đông</option>
								<option <%= realEstate.getDirection().equals("Đông Nam") ? "selected" : "" %> value='Đông Nam'>Đông Nam</option>
								<option <%= realEstate.getDirection().equals("Nam") ? "selected" : "" %> value='Nam'>Nam</option>
								<option <%= realEstate.getDirection().equals("Tây Nam") ? "selected" : "" %> value='Tây Nam'>Tây Nam</option>
								<option <%= realEstate.getDirection().equals("Tây") ? "selected" : "" %> value='Tây'>Tây</option>
								<option <%= realEstate.getDirection().equals("Tây Bắc") ? "selected" : "" %> value='Tây Bắc'>Tây Bắc</option>
							</select>
						</div>
						<div class='form-item'>
							<p>Hướng ban công</p>
							<select name='balconyDirection' id='balconyDirection'>
								<option <%= realEstate.getDirection().equals("") ? "selected" : "" %> value=''>---Hướng nhà---</option>
								<option <%= realEstate.getDirection().equals("Bắc") ? "selected" : "" %> value='Bắc'>Bắc</option>
								<option <%= realEstate.getDirection().equals("Đông Bắc") ? "selected" : "" %> value='Đông Bắc'>Đông Bắc</option>
								<option <%= realEstate.getDirection().equals("Đông") ? "selected" : "" %> value='Đông'>Đông</option>
								<option <%= realEstate.getDirection().equals("Đông Nam") ? "selected" : "" %> value='Đông Nam'>Đông Nam</option>
								<option <%= realEstate.getDirection().equals("Nam") ? "selected" : "" %> value='Nam'>Nam</option>
								<option <%= realEstate.getDirection().equals("Tây Nam") ? "selected" : "" %> value='Tây Nam'>Tây Nam</option>
								<option <%= realEstate.getDirection().equals("Tây") ? "selected" : "" %> value='Tây'>Tây</option>
								<option <%= realEstate.getDirection().equals("Tây Bắc") ? "selected" : "" %> value='Tây Bắc'>Tây Bắc</option>
							</select>
						</div>
					</div>
					
					<div class='form-item'>
						<p>Cần bán gấp không?</p>
						<select name='urgent' id="urgent">
							<option <%= realEstate.isUrgent() == false ? "selected" : "" %> value='0'>Không</option>
							<option <%= realEstate.isUrgent() == true ? "selected" : "" %> value='1'>Có</option>
						</select>
					</div>
					
					<p id="result"  class="error"></p>
					<div class='money-wrapper'>
						<div class='form-item'>
						    <p>Mức giá <span>*</span></p>
						    <div class='input-container'>
						        <%
						        Object priceValue = request.getAttribute("price");
						
						        // Ensure priceValue is converted to a number before formatting
						        DecimalFormat df = new DecimalFormat("#");
						        df.setMaximumFractionDigits(0);  // No decimal places
						        df.setGroupingUsed(false);  // Disable comma separators
						        String formattedPrice = priceValue != null ? df.format(priceValue) : "";
						        %>
						        <form:input path="price" placeholder="Nhập giá, VD 12000000" type="number" min="0" value="<%= formattedPrice %>" oninput="this.value = Math.abs(this.value)" />
						    </div>
						    <%
						    String priceError = (String) request.getAttribute("priceError");
						    %>
						    <p class="error" style="<%= (priceError != null && !priceError.isEmpty()) ? "display: block;" : "display: none;" %>">
						        <%= priceError %>
						    </p>
						</div>

						<div class='form-item'>
							<p>Đơn vị</p>
							<select name='unit'>
						        <option <%= realEstate.getUnit().equals("VND") ? "selected" : "" %> value='VND'>VND</option>
						        <option <%= realEstate.getUnit().equals("Giá / m²") ? "selected" : "" %> value='Giá / m²'>Giá / m²</option>
						        <option <%= realEstate.getUnit().equals("Thỏa thuận") ? "selected" : "" %> value='Thỏa thuận'>Thỏa thuận</option>
						    </select>
						</div>
					</div>
				</div>
				<% } else if (category==3) { %>
				<div class='input-wrapper'>
					<h3>Thông tin bất động sản</h3>

					<div class='form-item'>
						<p>
							Diện tích <span>*</span>
						</p>
						<div class='input-container'>
							<form:input path="size" id="size" placeholder="Nhập diện tích, VD: 80" type="number" min="0" oninput="this.value = Math.abs(this.value)" />
							<span>m²</span>
						</div>
						<%
						    String sizeError = (String) request.getAttribute("sizeError");
						%>
						<p class="error" style="<%= (sizeError != null && !sizeError.isEmpty()) ? "display: block;" : "display: none;" %>">
						    <%= sizeError %>
						</p>
					</div>
					
					<div class='contact-wrapper'>
						<div class='form-item'>
							<p>Loại hình văn phòng</p>
							<select name='type' id="type">
								<option <%= realEstate.getType().equals("Văn phòng") ? "selected" : "" %> value='Văn phòng'>Văn phòng</option>
								<option <%= realEstate.getType().equals("Shophouse") ? "selected" : "" %> value='Shophouse'>Shophouse</option>
								<option <%= realEstate.getType().equals("Officetel") ? "selected" : "" %> value='Officetel'>Officetel</option>
							</select>
						</div>
					
						<div class='form-item'>
							<p>Nội thất</p>
							<select name='furnishingSell' id="furnishing_sell">
								<option <%= (realEstate.getFurnishingSell() != null && realEstate.getFurnishingSell().equals("")) ? "selected" : "" %> value=''>---Nội thất---</option>
								<option <%= realEstate.getFurnishingSell().equals("Hoàn thiện cơ bản") ? "selected" : "" %> value='Hoàn thiện cơ bản'>Hoàn thiện cơ bản</option>
								<option <%= realEstate.getFurnishingSell().equals("Nội thất đầy đủ") ? "selected" : "" %> value='Nội thất đầy đủ'>Nội thất đầy đủ</option>
								<option <%= realEstate.getFurnishingSell().equals("Nội thất cao cấp") ? "selected" : "" %> value='Nội thất cao cấp'>Nội thất cao cấp</option>
								<option <%= realEstate.getFurnishingSell().equals("Bàn giao thô") ? "selected" : "" %> value='Bàn giao thô'>Bàn giao thô</option>
							</select>
						</div>
					</div>
															
					<div class='contact-wrapper'>
					
						<div class='form-item'>
							<p>Giấy tờ pháp lý</p>
							<select name='propertyLegalDocument' id="property_legal_document">
								<option <%= realEstate.getPropertyLegalDocument().equals("") ? "selected" : "" %> value=''>---Giấy tờ pháp lý---</option>
								<option <%= realEstate.getPropertyLegalDocument().equals("Đã có sổ") ? "selected" : "" %> value='Đã có sổ'>Đã có sổ</option>
								<option <%= realEstate.getPropertyLegalDocument().equals("Đang chờ sổ") ? "selected" : "" %> value='Đang chờ sổ'>Đang chờ sổ</option>
								<option <%= realEstate.getPropertyLegalDocument().equals("Giấy tờ khác") ? "selected" : "" %> value='Giấy tờ khác'>Giấy tờ khác</option>
							</select>
						</div>
						
						<div class='form-item'>
							<p>Hướng nhà</p>
							<select name='direction' id='direction'>
								<option <%= realEstate.getDirection().equals("") ? "selected" : "" %> value=''>---Hướng nhà---</option>
								<option <%= realEstate.getDirection().equals("Bắc") ? "selected" : "" %> value='Bắc'>Bắc</option>
								<option <%= realEstate.getDirection().equals("Đông Bắc") ? "selected" : "" %> value='Đông Bắc'>Đông Bắc</option>
								<option <%= realEstate.getDirection().equals("Đông") ? "selected" : "" %> value='Đông'>Đông</option>
								<option <%= realEstate.getDirection().equals("Đông Nam") ? "selected" : "" %> value='Đông Nam'>Đông Nam</option>
								<option <%= realEstate.getDirection().equals("Nam") ? "selected" : "" %> value='Nam'>Nam</option>
								<option <%= realEstate.getDirection().equals("Tây Nam") ? "selected" : "" %> value='Tây Nam'>Tây Nam</option>
								<option <%= realEstate.getDirection().equals("Tây") ? "selected" : "" %> value='Tây'>Tây</option>
								<option <%= realEstate.getDirection().equals("Tây Bắc") ? "selected" : "" %> value='Tây Bắc'>Tây Bắc</option>
							</select>
						</div>
					</div>
					
					<div class='form-item'>
						<p>Cần bán gấp không?</p>
						<select name='urgent' id="urgent">
							<option <%= realEstate.isUrgent() == false ? "selected" : "" %> value='0'>Không</option>
							<option <%= realEstate.isUrgent() == true ? "selected" : "" %> value='1'>Có</option>
						</select>
					</div>
					
					<p id="result"  class="error"></p>
					<div class='money-wrapper'>
						<div class='form-item'>
						    <p>Mức giá <span>*</span></p>
						    <div class='input-container'>
						        <%
						        Object priceValue = request.getAttribute("price");
						
						        // Ensure priceValue is converted to a number before formatting
						        DecimalFormat df = new DecimalFormat("#");
						        df.setMaximumFractionDigits(0);  // No decimal places
						        df.setGroupingUsed(false);  // Disable comma separators
						        String formattedPrice = priceValue != null ? df.format(priceValue) : "";
						        %>
						        <form:input path="price" placeholder="Nhập giá, VD 12000000" type="number" min="0" value="<%= formattedPrice %>" oninput="this.value = Math.abs(this.value)" />
						    </div>
						    <%
						    String priceError = (String) request.getAttribute("priceError");
						    %>
						    <p class="error" style="<%= (priceError != null && !priceError.isEmpty()) ? "display: block;" : "display: none;" %>">
						        <%= priceError %>
						    </p>
						</div>

						<div class='form-item'>
							<p>Đơn vị</p>
							<select name='unit'>
						        <option <%= realEstate.getUnit().equals("VND") ? "selected" : "" %> value='VND'>VND</option>
						        <option <%= realEstate.getUnit().equals("Giá / m²") ? "selected" : "" %> value='Giá / m²'>Giá / m²</option>
						        <option <%= realEstate.getUnit().equals("Thỏa thuận") ? "selected" : "" %> value='Thỏa thuận'>Thỏa thuận</option>
						    </select>
						</div>
					</div>
				</div>
				<% } else if (category==4) { %>
				<div class='input-wrapper'>
					<h3>Thông tin bất động sản</h3>

					<div class='form-item'>
						<p>
							Diện tích <span>*</span>
						</p>
						<div class='input-container'>
							<form:input path="size" id="size" placeholder="Nhập diện tích, VD: 80" type="number" min="0" oninput="this.value = Math.abs(this.value)" />
							<span>m²</span>
						</div>
						<%
						    String sizeError = (String) request.getAttribute("sizeError");
						%>
						<p class="error" style="<%= (sizeError != null && !sizeError.isEmpty()) ? "display: block;" : "display: none;" %>">
						    <%= sizeError %>
						</p>
					</div>
					
					<div class='contact-wrapper'>
						<div class='form-item'>
							<p>Loại hình đất</p>
							<select name='type' id="type">
								<option <%= realEstate.getType().equals("Đất công nghiệp") ? "selected" : "" %> value='Đất công nghiệp'>Đất công nghiệp</option>
								<option <%= realEstate.getType().equals("Đất nông nghiệp") ? "selected" : "" %> value='Đất nông nghiệp'>Đất nông nghiệp</option>
								<option <%= realEstate.getType().equals("Đất nền dự án") ? "selected" : "" %> value='Đất nền dự án'>Đất nền dự án</option>
								<option <%= realEstate.getType().equals("Đất thổ cư") ? "selected" : "" %> value='Đất thổ cư'>Đất thổ cư</option>
							</select>
						</div>
						
						<div class='form-item'>
							<p>Đặc điểm nhà/đất</p>
							<select name='characteristics' id="characteristics">
								<option <%= (realEstate.getCharacteristics() != null && realEstate.getCharacteristics().equals("")) ? "selected" : "" %> value=''>---Đặc điểm nhà/đất---</option>
								<option <%= realEstate.getCharacteristics().equals("Mặt tiền") ? "selected" : "" %> value='Mặt tiền'>Mặt tiền</option>
								<option <%= realEstate.getCharacteristics().equals("Hẻm xe hơi") ? "selected" : "" %> value='Hẻm xe hơi'>Hẻm xe hơi</option>
								<option <%= realEstate.getCharacteristics().equals("Nở hậu") ? "selected" : "" %> value='Nở hậu'>Nở hậu</option>
								<option <%= realEstate.getCharacteristics().equals("Chưa có thổ cư") ? "selected" : "" %> value='Chưa có thổ cư'>Chưa có thổ cư</option>
								<option <%= realEstate.getCharacteristics().equals("Thổ cư 1 phần") ? "selected" : "" %> value='Thổ cư 1 phần'>Thổ cư 1 phần</option>
								<option <%= realEstate.getCharacteristics().equals("Thổ cư toàn bộ") ? "selected" : "" %> value='Thổ cư toàn bộ'>Thổ cư toàn bộ</option>
								<option <%= realEstate.getCharacteristics().equals("Không có thổ cư") ? "selected" : "" %> value='Không có thổ cư'>Không có thổ cư</option>
							</select>
						</div>
					</div>
															
					<div class='contact-wrapper'>
					
						<div class='form-item'>
							<p>Giấy tờ pháp lý</p>
							<select name='propertyLegalDocument' id="property_legal_document">
								<option <%= realEstate.getPropertyLegalDocument().equals("") ? "selected" : "" %> value=''>---Giấy tờ pháp lý---</option>
								<option <%= realEstate.getPropertyLegalDocument().equals("Đã có sổ") ? "selected" : "" %> value='Đã có sổ'>Đã có sổ</option>
								<option <%= realEstate.getPropertyLegalDocument().equals("Đang chờ sổ") ? "selected" : "" %> value='Đang chờ sổ'>Đang chờ sổ</option>
								<option <%= realEstate.getPropertyLegalDocument().equals("Giấy tờ khác") ? "selected" : "" %> value='Giấy tờ khác'>Không có sổ</option>
								<option <%= realEstate.getPropertyLegalDocument().equals("Sổ chung / công chứng vi bằng'>Sổ chung / công chứng vi bằng") ? "selected" : "" %> value='Sổ chung / công chứng vi bằng'>Sổ chung / công chứng vi bằng</option>
								<option <%= realEstate.getPropertyLegalDocument().equals("Giấy tờ viết tay") ? "selected" : "" %> value='Giấy tờ viết tay'>Giấy tờ viết tay</option>
							</select>
						</div>
						
						<div class='form-item'>
							<p>Hướng đất</p>
							<select name='direction' id='direction'>
								<option <%= realEstate.getDirection().equals("") ? "selected" : "" %> value=''>---Hướng nhà---</option>
								<option <%= realEstate.getDirection().equals("Bắc") ? "selected" : "" %> value='Bắc'>Bắc</option>
								<option <%= realEstate.getDirection().equals("Đông Bắc") ? "selected" : "" %> value='Đông Bắc'>Đông Bắc</option>
								<option <%= realEstate.getDirection().equals("Đông") ? "selected" : "" %> value='Đông'>Đông</option>
								<option <%= realEstate.getDirection().equals("Đông Nam") ? "selected" : "" %> value='Đông Nam'>Đông Nam</option>
								<option <%= realEstate.getDirection().equals("Nam") ? "selected" : "" %> value='Nam'>Nam</option>
								<option <%= realEstate.getDirection().equals("Tây Nam") ? "selected" : "" %> value='Tây Nam'>Tây Nam</option>
								<option <%= realEstate.getDirection().equals("Tây") ? "selected" : "" %> value='Tây'>Tây</option>
								<option <%= realEstate.getDirection().equals("Tây Bắc") ? "selected" : "" %> value='Tây Bắc'>Tây Bắc</option>
							</select>
						</div>
					</div>
					
					
					
					<p id="result"  class="error"></p>
					<div class='money-wrapper'>
						<div class='form-item'>
						    <p>Mức giá <span>*</span></p>
						    <div class='input-container'>
						        <%
						        Object priceValue = request.getAttribute("price");
						
						        // Ensure priceValue is converted to a number before formatting
						        DecimalFormat df = new DecimalFormat("#");
						        df.setMaximumFractionDigits(0);  // No decimal places
						        df.setGroupingUsed(false);  // Disable comma separators
						        String formattedPrice = priceValue != null ? df.format(priceValue) : "";
						        %>
						        <form:input path="price" placeholder="Nhập giá, VD 12000000" type="number" min="0" value="<%= formattedPrice %>" oninput="this.value = Math.abs(this.value)" />
						    </div>
						    <%
						    String priceError = (String) request.getAttribute("priceError");
						    %>
						    <p class="error" style="<%= (priceError != null && !priceError.isEmpty()) ? "display: block;" : "display: none;" %>">
						        <%= priceError %>
						    </p>
						</div>

						<div class='form-item'>
							<p>Đơn vị</p>
							<select name='unit'>
						        <option <%= realEstate.getUnit().equals("VND") ? "selected" : "" %> value='VND'>VND</option>
						        <option <%= realEstate.getUnit().equals("Giá / m²") ? "selected" : "" %> value='Giá / m²'>Giá / m²</option>
						        <option <%= realEstate.getUnit().equals("Thỏa thuận") ? "selected" : "" %> value='Thỏa thuận'>Thỏa thuận</option>
						    </select>
						</div>
					</div>
				</div>
				<% } %>
	
				<div class='input-wrapper'>
					<h3>Hình ảnh & Video</h3>
					<ul>
						<li>Đăng tối thiểu 4 ảnh</li>
						<li>Đăng tối đa 24 ảnh với tất cả các loại tin</li>
						<li>Hãy dùng ảnh thật, không trùng, không chèn SĐT</li>
						<li>Mỗi ảnh kích thước tối thiểu 100x100 px, tối đa 15 MB</li>
					</ul>
					<div class='input-image-wrapper'>
						<label htmlFor='file-input'
							onclick="document.getElementById('image').click()"> <svg
								width='80' height='80' viewBox='0 0 130 130' fill='none'
								xmlns='http://www.w3.org/2000/svg'>
                  <path
									d='M118.42 75.84C118.43 83.2392 116.894 90.5589 113.91 97.33H16.09C12.8944 90.0546 11.3622 82.1579 11.6049 74.2154C11.8477 66.2728 13.8593 58.4844 17.4932 51.4177C21.1271 44.3511 26.2918 38.1841 32.6109 33.3662C38.93 28.5483 46.2443 25.2008 54.0209 23.5676C61.7976 21.9345 69.8406 22.0568 77.564 23.9257C85.2873 25.7946 92.4965 29.363 98.6661 34.3709C104.836 39.3787 109.81 45.6999 113.228 52.8739C116.645 60.0478 118.419 67.8937 118.42 75.84Z'
									fill='#F2F2F2'></path>
                  <path d='M5.54 97.33H126.37' stroke='#63666A'
									strokeWidth='1' strokeMiterlimit='10' strokeLinecap='round'></path>
                  <path
									d='M97 97.33H49.91V34.65C49.91 34.3848 50.0154 34.1305 50.2029 33.9429C50.3904 33.7554 50.6448 33.65 50.91 33.65H84.18C84.6167 33.6541 85.0483 33.7445 85.4499 33.9162C85.8515 34.0878 86.2152 34.3372 86.52 34.65L96.02 44.15C96.3321 44.4533 96.5811 44.8153 96.7527 45.2151C96.9243 45.615 97.0152 46.0449 97.02 46.48L97 97.33Z'
									fill='#D7D7D7' stroke='#63666A' strokeWidth='1'
									strokeLinecap='round' strokeLinejoin='round'></path>
                  <path
									d='M59.09 105.64H42.09C41.8248 105.64 41.5704 105.535 41.3829 105.347C41.1954 105.16 41.09 104.905 41.09 104.64V41.79C41.09 41.5248 41.1954 41.2705 41.3829 41.0829C41.5704 40.8954 41.8248 40.79 42.09 40.79H77.33L89 52.42V104.62C89 104.885 88.8946 105.14 88.7071 105.327C88.5196 105.515 88.2652 105.62 88 105.62H74.86'
									fill='white'></path>
                  <path
									d='M59.09 105.64H42.09C41.8248 105.64 41.5704 105.535 41.3829 105.347C41.1954 105.16 41.09 104.905 41.09 104.64V41.79C41.09 41.5248 41.1954 41.2705 41.3829 41.0829C41.5704 40.8954 41.8248 40.79 42.09 40.79H77.33L89 52.42V104.62C89 104.885 88.8946 105.14 88.7071 105.327C88.5196 105.515 88.2652 105.62 88 105.62H74.86'
									stroke='#63666A' strokeWidth='1' strokeMiterlimit='10'
									strokeLinecap='round'></path>
                  <path d='M88.97 52.42H77.33V40.77L88.97 52.42Z'
									fill='#D7D7D7' stroke='#63666A' strokeWidth='1'
									strokeLinecap='round' strokeLinejoin='round'></path>
                  <path d='M27.32 65.49V70.6' stroke='#D7D7D7'
									strokeWidth='1' strokeLinecap='round' strokeLinejoin='round'></path>
                  <path d='M29.88 68.04H24.76' stroke='#D7D7D7'
									strokeWidth='1' strokeLinecap='round' strokeLinejoin='round'></path>
                  <path d='M110.49 32.5601V39.9901' stroke='#D7D7D7'
									strokeWidth='1' strokeLinecap='round' strokeLinejoin='round'></path>
                  <path d='M114.2 36.27H106.77' stroke='#D7D7D7'
									strokeWidth='1' strokeLinecap='round' strokeLinejoin='round'></path>
                  <path d='M34.07 14.58V25.59' stroke='#D7D7D7'
									strokeWidth='1' strokeLinecap='round' strokeLinejoin='round'></path>
                  <path d='M39.57 20.08H28.57' stroke='#D7D7D7'
									strokeWidth='1.5' strokeLinecap='round' strokeLinejoin='round'></path>
                  <path d='M67 115.86V67.12' stroke='#63666A'
									strokeWidth='1' strokeMiterlimit='10' strokeLinecap='round'></path>
                  <path d='M55.5 78.61L67 67.12L78.5 78.61' fill='white'></path>
                  <path d='M55.5 78.61L67 67.12L78.5 78.61'
									stroke='#63666A' strokeWidth='1' strokeMiterlimit='10'></path>
                </svg>
							<p>Bấm để chọn ảnh cần tải lên</p>
						</label> 
						<input type='file' id='image' name='image' multiple
							onchange="image_select()" class="d-none" style="display: none;" />


						<div class='img-container' id="container">
							<!--		<div class='img-wrapper'>
									<img src="images/FB_IMG_1666110816291.jpg" alt='' /> 
									<i class='fa-solid fa-xmark' onclick="delete_image(`+images.indexOf(i)+`)"></i>
								</div> -->
						</div>

					</div>
					<%
				    String imageError = (String) request.getAttribute("imageError");
					%>
					<p class="error" style="<%= (imageError != null && !imageError.isEmpty()) ? "display: block;" : "display: none;" %>">
					    <%= imageError %>
					</p>
				</div>

				<div class='input-wrapper'>
					<h3>Thông tin liên hệ</h3>
					<div class='contact-wrapper'>
						<div class='form-item'>
							<p>
								Tên liên hệ <span>*</span>
							</p>
							<div class='input-container'>
								<form:input path="contactName" placeholder="Nhập tên" />
							</div>
							<%
						    String contactNameError = (String) request.getAttribute("contactNameError");
							%>
							<p class="error" style="<%= (contactNameError != null && !contactNameError.isEmpty()) ? "display: block;" : "display: none;" %>">
							    <%= contactNameError %>
							</p>
						</div>

						<div class='form-item'>
							<p>
								Số điện thoại <span>*</span>
							</p>
							<div class='input-container'>
								<form:input path="phoneNumber" placeholder="Nhập số điện thoại" />
							</div>
							<%
					    	String phoneNumberError = (String) request.getAttribute("phoneNumberError");
							%>
							<p class="error" style="<%= (phoneNumberError != null && !phoneNumberError.isEmpty()) ? "display: block;" : "display: none;" %>">
							    <%= phoneNumberError %>
							</p>
						</div>
					</div>

					<div class='form-item'>
						<p>Email</p>
						<div class='input-container'>
							<form:input type="email" path="email" placeholder="Nhập email" />
						</div>
						<%
					    	String emailError = (String) request.getAttribute("emailError");
						%>
						<p class="error" style="<%= (emailError != null && !emailError.isEmpty()) ? "display: block;" : "display: none;" %>">
						    <%= emailError %>
						</p>
					</div>
				</div>

				<div class='button-wrapper'>
					<div></div>
					<button class='continue-button'>
						<span>Tiếp tục</span> <i class='fa-solid fa-angle-right'></i>
					</button>
				</div>
			</form:form>
		</div>
	</div>

	<script type="text/javascript">
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
	    console.log(wardId)
	    console.log(size)
		if(wardId!=="" && size!=="0.0") {
		    console.log(2)
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
		             document.getElementById('result').style.display = "block";
		             document.getElementById('result').innerText = `Giá khuyến nghị cho bất động sản của bạn là: ` + result.predicted_price + " VND";
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
		             document.getElementById('result').style.display = "block";
		             document.getElementById('result').innerText = `Giá khuyến nghị cho bất động sản của bạn là: ` + result.predicted_price + " VND";
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
		             document.getElementById('result').style.display = "block";
		             document.getElementById('result').innerText = `Giá khuyến nghị cho bất động sản của bạn là: ` + result.predicted_price + " VND";
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
   		             document.getElementById('result').style.display = "block";
   		             document.getElementById('result').innerText = `Giá khuyến nghị cho bất động sản của bạn là: ` + result.predicted_price + " VND";
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
	
	var images = [];
	var edit_images = [];

	function image_select() {
	    var image = document.getElementById("image").files;
	    for (var i = 0; i < image.length; i++) {
	        if (check_duplicate(image[i].name)) {
	            images.push({
	                "name": image[i].name,
	                "url": URL.createObjectURL(image[i]), // Tạo URL tạm thời từ tệp
	                "file": image[i], // Lưu trữ tệp để sử dụng sau
	            });
	        }
	    }
	    document.getElementById("container").innerHTML = image_show(); // Cập nhật giao diện
	}

	function image_show() {
	    var image = "";
	    images.forEach((i) => {
	        image += `
	            <div class='img-wrapper'>
	                <img src="` + i.url + `" alt='Image Preview' />
	                <i class='fa-solid fa-xmark' onclick="delete_image(` + images.indexOf(i) + `)"></i>
	            </div>
	        `;
	    });
	    return image; // Trả về chuỗi HTML để hiển thị
	}

	function delete_image(index) {
	    images.splice(index, 1); // Xóa ảnh khỏi mảng `images[]`
	    
	    // Reset lại input file
	    document.getElementById("image").value = "";

	    // Tạo lại một input file mới với các ảnh còn lại
	    let dataTransfer = new DataTransfer(); // Sử dụng DataTransfer API

	    images.forEach(image => {
	        dataTransfer.items.add(image.file); // Thêm lại ảnh còn lại
	    });

	    document.getElementById("image").files = dataTransfer.files; // Cập nhật lại input file với các ảnh còn lại

	    document.getElementById("container").innerHTML = image_show(); // Cập nhật lại giao diện
	}


	function check_duplicate(name) {
	    var isDuplicate = true;
	    if (images.length > 0) {
	        for (var i = 0; i < images.length; i++) {
	            if (images[i].name == name) {
	                isDuplicate = false;
	                break;
	            }
	        }
	    }
	    return isDuplicate; // Trả về giá trị true nếu không trùng lặp
	}

	$(document).ready(function() {
		ClassicEditor
        .create( document.querySelector( '#editor' ) )
        .catch( error => {
            console.error( error );
        } );
		
		$(document).ready(function() {
			var imageString = "<c:out value='${realEstate.images}' />"

			// Loại bỏ ký tự "[" ở đầu và "]" ở cuối chuỗi
			imageString = imageString.substring(1, imageString.length - 1);

			// Tách chuỗi thành các phần tử của mảng bằng dấu phẩy và khoảng trắng
			var imageArray = imageString.split(", ");

			// Nếu bạn muốn loại bỏ dấu ngoặc kép từ mỗi phần tử, bạn có thể sử dụng map()
			edit_images = imageArray.map(function(image) {
			    return "images/" + image.replace(/\"/g, ''); // Loại bỏ dấu ngoặc kép từ mỗi phần tử
			});
			
			// Hàm để chuyển đổi URL thành đối tượng File
			async function fetchImageAsFile(url, name) {
			    const response = await fetch(url);
			    const blob = await response.blob();
			    return new File([blob], name, { type: blob.type });
			}

			// Hàm để thêm ảnh vào input file
			async function addImagesToInputFile() {
			    const inputFile = document.getElementById('image'); // Giả sử bạn có một input file với id là "image"
			    const files = [];
			
			    // Lặp qua mảng `edit_images` và tải từng file
			    for (let i = 0; i < edit_images.length; i++) {
			        const file = await fetchImageAsFile(edit_images[i], `image${i + 1}.jpg`); // Đặt tên cho file
			        files.push(file);
			
			        // Cập nhật mảng `images[]` với các thông tin cần thiết
			        images.push({
			            "name": `image${i + 1}.jpg`,
			            "url": URL.createObjectURL(file),
			            "file": file,
			        });
			    }
			
			    // Tạo một DataTransfer để thêm file vào input
			    const dataTransfer = new DataTransfer();
			
			    // Thêm các file vào DataTransfer
			    files.forEach(file => {
			        dataTransfer.items.add(file);
			    });
			
			    // Gán các file vào input
			    inputFile.files = dataTransfer.files;
			
			    // Gọi hàm để hiển thị ảnh
			    document.getElementById("container").innerHTML = image_show();
			}
			
			// Gọi hàm để thêm ảnh vào input
			addImagesToInputFile();

			 
			
			// document.getElementById("container").innerHTML = image_show_edit();
			
			function image_show_edit() {
				var image = "";
				edit_images.forEach((i) => {
					image += `
						<div class='img-wrapper'>
							<img src="images/`+i+`" alt='' /> 
							<i class='fa-solid fa-xmark' onclick=""></i>
						</div>
					`
				})
				return image;
			}
			
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


	</script>
</body>
</html>