<%@page import="batdongsan.models.HCMDistrictsModel"%>
<%@page import="batdongsan.models.ProvincesModel"%>
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
			<form:form action="sellernet/addNewRealEstate.html" modelAttribute="realEstate"
				method="POST" enctype="multipart/form-data">


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
								<select name="categoryId" onchange="window.location.href='<%= pageContext.getServletContext().getContextPath() %>/sellernet/dang-tin/ban.html?categoryId=' + this.value;">
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
							<form:input path="size" id="size" placeholder="Nhập diện tích, VD: 80" />
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
									placeholder="Nhập số phòng, VD: 2" />
								<span>phòng</span>
							</div>
						</div>
						<div class='form-item'>
							<p>Số phòng tắm, vệ sinh</p>
							<div class='input-container'>
								<form:input path="toilets" id="toilets"
									placeholder="Nhập số phòng, VD: 2" />
								<span>phòng</span>
							</div>
						</div>
					</div>
					
					<div class='contact-wrapper'>
						<div class='form-item'>
							<p>Số tầng</p>
							<div class='input-container'>
								<form:input path="floors" id="floors"
									placeholder="Nhập số tầng, VD: 2" />
								<span>tầng</span>
							</div>
						</div>
						<div class='form-item'>
							<p>Loại hình nhà ở</p>
							<select name='type' id="type">
								<option value='Nhà ngõ, hẻm'>Nhà ngõ, hẻm</option>
								<option value='Nhà mặt phố, mặt tiền'>Nhà mặt phố, mặt tiền</option>
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
							<option value='Nhà dính quy hoạch / lộ giới'>Nhà dính quy hoạch / lộ giới</option>
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
							<option value='Sổ chung / công chứng vi bằng'>Sổ chung / công chứng vi bằng</option>
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
					
					<p id="result"  class="error"></p>
					<div class='money-wrapper'>
						<div class='form-item'>
							<p>
								Mức giá <span>*</span>
							</p>
							<div class='input-container'>
								<form:input path="price" placeholder="Nhập giá, VD 12000000" />
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
						        <option value='VND'>VND</option>
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
							<form:input path="size" id="size" placeholder="Nhập diện tích, VD: 80" />
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
									placeholder="Nhập số phòng, VD: 2" />
								<span>phòng</span>
							</div>
						</div>
						<div class='form-item'>
							<p>Số phòng tắm, vệ sinh</p>
							<div class='input-container'>
								<form:input path="toilets" id="toilets"
									placeholder="Nhập số phòng, VD: 2" />
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
								<option value='Căn hộ dịch vụ, mini'>Căn hộ dịch vụ, mini</option>
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
					
					<p id="result"  class="error"></p>
					<div class='money-wrapper'>
						<div class='form-item'>
							<p>
								Mức giá <span>*</span>
							</p>
							<div class='input-container'>
								<form:input path="price" placeholder="Nhập giá, VD 12000000" />
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
						        <option value='VND'>VND</option>
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
							<form:input path="size" id="size" placeholder="Nhập diện tích, VD: 80" />
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
					
					<p id="result"  class="error"></p>
					<div class='money-wrapper'>
						<div class='form-item'>
							<p>
								Mức giá <span>*</span>
							</p>
							<div class='input-container'>
								<form:input path="price" placeholder="Nhập giá, VD 12000000" />
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
						        <option value='VND'>VND</option>
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
							<form:input path="size" id="size" placeholder="Nhập diện tích, VD: 80" />
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
								<option value='Sổ chung / công chứng vi bằng'>Sổ chung / công chứng vi bằng</option>
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
					
					<p id="result"  class="error"></p>
					<div class='money-wrapper'>
						<div class='form-item'>
							<p>
								Mức giá <span>*</span>
							</p>
							<div class='input-container'>
								<form:input path="price" placeholder="Nhập giá, VD 12000000" />
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
						        <option value='VND'>VND</option>
						    </select>
						</div>
					</div>
				</div>
				<% } %>
				

				<div class='input-wrapper'>
					<h3>Hình ảnh</h3>
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
						</label> <input type='file' id='image' name='image' multiple
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

				<div class='input-wrapper'>
					<h3>Cấu hình tin đăng</h3>

					<div class="setting-wrapper">
						<p>Chọn loại tin đăng</p>
						<div class="types-wrapper">
							<div class="type-container normal active">
								<h6>Tin thường</h6>
								<p>
									Từ <span>2.240</span> đ/ngày
								</p>
								<div>
									<i class="fa-regular fa-eye"></i> <span> x1</span>
								</div>
								<p>
									<span>lượt xem tin</span>
								</p>
								<div class="choose-btn">Đã chọn</div>
							</div>

							<div class="type-container silver">
								<h6>VIP Bạc</h6>
								<p>
									Từ <span>49.140</span> đ/ngày
								</p>
								<div>
									<i class="fa-regular fa-eye"></i> <span> x11</span>
								</div>
								<p>
									<span>lượt xem tin</span>
								</p>
								<div class="choose-btn">Chọn</div>
							</div>

							<div class="type-container gold">
								<h6>VIP Vàng</h6>
								<p>
									Từ <span>106.380</span> đ/ngày
								</p>
								<div>
									<i class="fa-regular fa-eye"></i> <span> x18</span>
								</div>
								<p>
									<span>lượt xem tin</span>
								</p>
								<div class="choose-btn">Chọn</div>
							</div>

							<div class="type-container diamond">
								<h6>VIP Kim Cương</h6>
								<p>
									Từ <span>270.000</span> đ/ngày
								</p>
								<div>
									<i class="fa-regular fa-eye"></i> <span> x90</span>
								</div>
								<p>
									<span>lượt xem tin</span>
								</p>
								<div class="choose-btn">Chọn</div>
							</div>
						</div>
					</div>
					
					<hr />

					<div class="setting-wrapper">
						<p>Chọn thời gian đăng tin</p>
						
						<div class='form-item'>
							<p>Số ngày đăng</p>
							<div class="dates-wrapper">
								<div class="date-container active">
									<h6>10 ngày</h6>
									<p>2800 đ/ngày</p>
								</div>
								<div class="date-container">
									<h6>15 ngày</h6>
									<p>2520 đ/ngày</p>
								</div>
								<div class="date-container">
									<h6>30 ngày</h6>
									<p>2240 đ/ngày</p>
								</div>
							</div>
						</div>
						
						<div class='contact-wrapper'>
							<div class='form-item'>
								<p>Ngày bắt đầu</p>
								<div class='input-container'>
									<input type="date" id="submittedDate" />
								</div>
							</div>

							<div class='form-item'>
								<p>Ngày kết thúc</p>
								<div class='input-container'>
									<input type="date" id="expirationDate" readonly />
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<div class='input-wrapper'>
					<h3>THANH TOÁN</h3>

					<div class="section-wrapper">
						<span>Loại tin</span>
						<input name="typePost" value="Tin thường" readonly />
					</div>
					<div class="section-wrapper">
						<span>Đơn giá / ngày</span>
						<div>
							<input type="text" name="pricePerDay" readonly pattern="^\$\d{1,3}(,\d{3})*(\.\d+)?$" value="2800"> đ								
						</div>	
					</div>
					<div class="section-wrapper">
						<span>Thời gian đăng tin</span>
						<input name="amountDate" value="10 ngày" readonly />
					</div>
					<div class="section-wrapper">
						<span>Ngày bắt đầu</span>
						<input name="submittedDate" type="date" readonly style="transform: translateX(20px);" />
					</div>
					<div class="section-wrapper">
						<span>Ngày kết thúc</span>
						<input name="expirationDate" type="date" readonly style="transform: translateX(20px);" />
					</div>
					<hr />
					<div class="section-wrapper">
						<span>Phí đăng tin</span>
						<div>						
							<input type="text" name="fee" readonly pattern="^\$\d{1,3}(,\d{3})*(\.\d+)?$" value="2800"> đ
						</div>
					</div>
					<hr />
					<div class="section-wrapper">
						<span>Tổng tiền</span>
						<div>
							<input type="text" name="totalMoney" readonly pattern="^\$\d{1,3}(,\d{3})*(\.\d+)?$" value="2800"> đ			
						</div>
					</div>
					<%
				    String moneyError = (String) request.getAttribute("moneyError");
					%>
					<p class="error" style="<%= (moneyError != null && !moneyError.isEmpty()) ? "display: block;" : "display: none;" %>">
					    <%= moneyError %>
					</p>
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
	
	document.getElementById('price').addEventListener('input', async function() {
	    const districtElement = document.getElementById('districtId');
	    const wardElement = document.getElementById('wardId');
	    const sizeElement = document.getElementById('size');
	    const roomsElement = document.getElementById('rooms');
	    const toiletsElement = document.getElementById('toilets');
	    const floorsElement = document.getElementById('floors');
	    const houseTypeElement = document.getElementById('type');
	    const furnishingSellElement = document.getElementById('furnishing_sell');
	    
	    let ward = "";
	    let district;
	    let size = 0;
	    let rooms = 0;
	    let toilets = 0;
	    let floors = 0;
	    let house_type = "";
	    let furnishing_sell = "";

	    if (wardElement && wardElement.selectedIndex !== -1) {
	    	if(wardElement.options[wardElement.selectedIndex].textContent === "---Phường, xã---") {
	    		ward =  "";
	    	} else {
		        ward = wardElement.options[wardElement.selectedIndex].textContent;
	    	}
	    } else {
	    	ward =  "";
	    }
	    
	    if (districtElement && districtElement.selectedIndex !== -1) {
	        district = districtElement.options[districtElement.selectedIndex].textContent;
	    } 

	    if (sizeElement && sizeElement.value) {
	    	size = sizeElement.value;
	    } 
	    
	    if (roomsElement && roomsElement.value) {
	        rooms = roomsElement.value;
	    } 
	    
	    if (toiletsElement && toiletsElement.value) {
	       toilets = toiletsElement.value;
	    } 
	    
	    if (floorsElement && floorsElement.value) {
	        floors = floorsElement.value;
	    } 
	    
	    if (houseTypeElement && houseTypeElement.selectedIndex !== -1) {
	    	if(houseTypeElement.options[houseTypeElement.selectedIndex].textContent === "---Loại nhà---") {
	    		house_type =  "Nhà ngõ, hẻm";
	    	} else {
		        house_type = houseTypeElement.options[houseTypeElement.selectedIndex].textContent;
	    	}
	    } else {
	    	house_type =  "Nhà ngõ, hẻm";
	    }
	    
	    if (furnishingSellElement && furnishingSellElement.selectedIndex !== -1) {
	    	if(furnishingSellElement.options[furnishingSellElement.selectedIndex].textContent === "---Nội thất---") {
	    		furnishing_sell =  "Hoàn thiện cơ bản";
	    	} else {
		       furnishing_sell = furnishingSellElement.options[furnishingSellElement.selectedIndex].textContent;
	    	}
	    } else {
	    	furnishing_sell =  "Hoàn thiện cơ bản";
	    }
	    
	    if(ward!=="" && size!==0) {
	    	 const data = {
	          		ward: ward,
	         		district: district,
	         		size: parseFloat(size),
	         		rooms: parseInt(rooms),
	         		toilets: parseInt(toilets),
	         		floors: parseInt(floors),
	         		house_type: house_type,
	         		furnishing_sell: furnishing_sell
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
	             document.getElementById('result').innerText = `Giá khuyến nghị cho bất động sản của bạn là: ` + result.predicted_price;
	         } catch (error) {
	        	 document.getElementById('result').style.display = "none";
	             console.error('Error predicting price:', error);
	             document.getElementById('result').innerText = 'Error predicting price.';
	         }
	    } else {
	    	document.getElementById('result').style.display = "none";
	    }
       
	});
	
	var images = [];
	function image_select() {
		var image = document.getElementById("image").files;
		 for (var i = 0; i < image.length; i++) {
			 if(check_duplicate(image[i].name)) {
				images.push({
					"name": image[i].name,
					"url": URL.createObjectURL(image[i]),
					"file": image[i],
				})
		 	}
		}
		document.getElementById("container").innerHTML = image_show();
	}
	function image_show() {
		var image = "";
		images.forEach((i) => {
			image += `
				<div class='img-wrapper'>
					<img src="`+i.url+`" alt='' /> 
					<i class='fa-solid fa-xmark' onclick="delete_image(`+images.indexOf(i)+`)"></i>
				</div>
			`
		})
		return image;
	}
	function delete_image(e) {
		images.splice(e, 1);
		document.getElementById("container").innerHTML = image_show();
	}
	function check_duplicate(name) {
		var image = true;
		if(images.length > 0) {
			for(e = 0; e < images.length; e++) {
				if(images[e].name == name) {
					image = false;
					break;
				}
			}
		}
		return image
	}
	//
	$(document).ready(function() {
		ClassicEditor
        .create( document.querySelector( '#editor' ) )
        .catch( error => {
            console.error( error );
        } );
		
		$("input, select, textarea").on("change", () => {
		    $(".error").hide(); 
		});
		
		var currentDate = new Date();

		var submittedDate = currentDate.toISOString().split('T')[0];
		$('#submittedDate').val(submittedDate);
		$('input[name="submittedDate"]').val(submittedDate);

		// Tạo một đối tượng Date mới từ ngày hiện tại cộng thêm 10 ngày
		var next10day = new Date(currentDate);
		next10day.setDate(next10day.getDate() + 10);

		// Định dạng thành chuỗi YYYY-MM-DD
		var expirationDate = next10day.toISOString().split('T')[0];
		$('#expirationDate').val(expirationDate);
		$('input[name="expirationDate"]').val(expirationDate);
			
		$(".type-container").on("click", function() {
		    $(".type-container").removeClass("active");
		    $(".type-container .choose-btn").text("Chọn"); 
		    
		    $(this).addClass("active");
		    $(this).find(".choose-btn").text("Đã chọn"); 
		    
		    var getDate = $('#submittedDate').val()
			
			var next7day = new Date(getDate);
			next7day.setDate(next7day.getDate() + 7);
			
			var next10day = new Date(getDate);
			next10day.setDate(next10day.getDate() + 10);
			
			var next15day = new Date(getDate);
			next15day.setDate(next15day.getDate() + 15);
			
			var next30day = new Date(getDate);
			next30day.setDate(next30day.getDate() + 30);

	    	if ($(this).hasClass("normal")) {
		    	$(".dates-wrapper").html(
					`
					<div class="date-container active">
						<h6>10 ngày</h6>
						<p>2800 đ/ngày</p>
					</div>
					<div class="date-container">
						<h6>15 ngày</h6>
						<p>2520 đ/ngày</p>
					</div>
					<div class="date-container">
						<h6>30 ngày</h6>
						<p>2240 đ/ngày</p>
					</div>
					`
		    	)
		    	
		    	var expirationDate = next10day.toISOString().split('T')[0];
				$('#expirationDate').val(expirationDate);
				$('input[name="expirationDate"]').val(expirationDate);

				var selectedDate = $(".date-container.active").find("h6").text();
			    var selectedMoney = $(".date-container.active").find("p").text();

			    var date = parseInt(selectedDate.replace(/[^\d.]/g, ''));
			    var moneyPerDay = parseInt(selectedMoney.replace(/[^\d.]/g, ''));
				
			    $("input[name='typePost']").val("Tin thường");
			    $("input[name='amountDate']").val(selectedDate);
			    $("input[name='pricePerDay']").val(moneyPerDay); 
			    $("input[name='fee']").val(date * moneyPerDay); 
			    $("input[name='totalMoney']").val(date * moneyPerDay); 
		    }
	    	if ($(this).hasClass("silver")) {
	    		$(".dates-wrapper").html(
						`
						<div class="date-container active">
							<h6>7 ngày</h6>
							<p>54600 đ/ngày</p>
						</div>
						<div class="date-container">
							<h6>10 ngày</h6>
							<p>51870 đ/ngày</p>
						</div>
						<div class="date-container">
							<h6>15 ngày</h6>
							<p>49140 đ/ngày</p>
						</div>
						`
			    	)
			    	
			    var expirationDate = next7day.toISOString().split('T')[0];
				$('#expirationDate').val(expirationDate);
				$('input[name="expirationDate"]').val(expirationDate);

				var selectedDate = $(".date-container.active").find("h6").text();
			    var selectedMoney = $(".date-container.active").find("p").text();

			    var date = parseInt(selectedDate.replace(/[^\d.]/g, ''));
			    var moneyPerDay = parseInt(selectedMoney.replace(/[^\d.]/g, ''));

			    $("input[name='typePost']").val("VIP Bạc");
			    $("input[name='amountDate']").val(selectedDate);
			    $("input[name='pricePerDay']").val(moneyPerDay); 
			    $("input[name='fee']").val(date * moneyPerDay); 
			    $("input[name='totalMoney']").val(date * moneyPerDay); 
		    }
	    	if ($(this).hasClass("gold")) {
	    		$(".dates-wrapper").html(
						`
						<div class="date-container active">
							<h6>7 ngày</h6>
							<p>118200 đ/ngày</p>
						</div>
						<div class="date-container">
							<h6>10 ngày</h6>
							<p>122290 đ/ngày</p>
						</div>
						<div class="date-container">
							<h6>15 ngày</h6>
							<p>106380 đ/ngày</p>
						</div>
						`
			    	)
			    	
				    var expirationDate = next7day.toISOString().split('T')[0];
					$('#expirationDate').val(expirationDate);
					$('input[name="expirationDate"]').val(expirationDate);

					var selectedDate = $(".date-container.active").find("h6").text();
				    var selectedMoney = $(".date-container.active").find("p").text();

				    var date = parseInt(selectedDate.replace(/[^\d.]/g, ''));
				    var moneyPerDay = parseInt(selectedMoney.replace(/[^\d.]/g, ''));

				    $("input[name='typePost']").val("VIP Vàng");
				    $("input[name='amountDate']").val(selectedDate);
				    $("input[name='pricePerDay']").val(moneyPerDay); 
				    $("input[name='fee']").val(date * moneyPerDay); 
				    $("input[name='totalMoney']").val(date * moneyPerDay); 
		    }
	    	if ($(this).hasClass("diamond")) {
	    		$(".dates-wrapper").html(
						`
						<div class="date-container active">
							<h6>7 ngày</h6>
							<p>300000 đ/ngày</p>
						</div>
						<div class="date-container">
							<h6>10 ngày</h6>
							<p>285000 đ/ngày</p>
						</div>
						<div class="date-container">
							<h6>15 ngày</h6>
							<p>270000 đ/ngày</p>
						</div>
						`
			    	)
			    	
				    var expirationDate = next7day.toISOString().split('T')[0];
					$('#expirationDate').val(expirationDate);
					$('input[name="expirationDate"]').val(expirationDate);

					var selectedDate = $(".date-container.active").find("h6").text();
				    var selectedMoney = $(".date-container.active").find("p").text();

				    var date = parseInt(selectedDate.replace(/[^\d.]/g, ''));
				    var moneyPerDay = parseInt(selectedMoney.replace(/[^\d.]/g, ''));

				    $("input[name='typePost']").val("VIP Kim Cương");
				    $("input[name='amountDate']").val(selectedDate);
				    $("input[name='pricePerDay']").val(moneyPerDay); 
				    $("input[name='fee']").val(date * moneyPerDay); 
				    $("input[name='totalMoney']").val(date * moneyPerDay); 
		    }
		});
		
		$(".dates-wrapper").on("click", ".date-container", function() {
		    // Remove 'active' class from all date containers
		    $(".date-container").removeClass("active");

		    // Add 'active' class to the clicked date container
		    $(this).addClass("active");

			 // Get the selected date text
		    var selectedDate = $(this).find("h6").text();
		    var selectedMoney = $(".date-container.active").find("p").text();

		    var date = parseInt(selectedDate.replace(/[^\d.]/g, ''));
		    var moneyPerDay = parseInt(selectedMoney.replace(/[^\d.]/g, ''));

		    $("input[name='amountDate']").val(selectedDate); // Use .val() to set input value
		    $("input[name='pricePerDay']").val(moneyPerDay); // Use .val() to set input value
		    $("input[name='fee']").val(date * moneyPerDay); // Use .val() to set input value
		    $("input[name='totalMoney']").val(date * moneyPerDay); // Use .val() to set input value


		    // Calculate expiration date based on selected date
		    var getDate = $('#submittedDate').val();
		    var expirationDate;
		    var next7day = new Date(getDate);
		    next7day.setDate(next7day.getDate() + 7);
		    var next10day = new Date(getDate);
		    next10day.setDate(next10day.getDate() + 10);
		    var next15day = new Date(getDate);
		    next15day.setDate(next15day.getDate() + 15);
		    var next30day = new Date(getDate);
		    next30day.setDate(next30day.getDate() + 30);

		    switch(selectedDate) {
		        case "7 ngày":
		            expirationDate = next7day.toISOString().split('T')[0];
		            break;
		        case "10 ngày":
		            expirationDate = next10day.toISOString().split('T')[0];
		            break;
		        case "15 ngày":
		            expirationDate = next15day.toISOString().split('T')[0];
		            break;
		        case "30 ngày":
		            expirationDate = next30day.toISOString().split('T')[0];
		            break;
		    }

		    // Set expiration date value
		    $('#expirationDate').val(expirationDate);
		    $('input[name="expirationDate"]').val(expirationDate);
		});

		$('#submittedDate').on("change", () => {
			var selectedDate = $(".date-container.active").find("h6").text();
			
			var getDate = $('#submittedDate').val();
		    var expirationDate;
		    var next7day = new Date(getDate);
		    next7day.setDate(next7day.getDate() + 7);
		    var next10day = new Date(getDate);
		    next10day.setDate(next10day.getDate() + 10);
		    var next15day = new Date(getDate);
		    next15day.setDate(next15day.getDate() + 15);
		    var next30day = new Date(getDate);
		    next30day.setDate(next30day.getDate() + 30);

		    switch(selectedDate) {
		        case "7 ngày":
		            expirationDate = next7day.toISOString().split('T')[0];
		            break;
		        case "10 ngày":
		            expirationDate = next10day.toISOString().split('T')[0];
		            break;
		        case "15 ngày":
		            expirationDate = next15day.toISOString().split('T')[0];
		            break;
		        case "30 ngày":
		            expirationDate = next30day.toISOString().split('T')[0];
		            break;
		    }
			
			$('#expirationDate').val(expirationDate);
			$('input[name="expirationDate"]').val(expirationDate);
			 
			var newDate = new Date(getDate);
			var submittedDate = newDate.toISOString().split('T')[0];
			$('#submittedDate').val(submittedDate);
			$('input[name="submittedDate"]').val(submittedDate);
			
			
		})
				
		$('#provinceId').change(function() {
		    var provinceId = $(this).val();
		    $.ajax({
		        type: 'GET',
		        url: '${pageContext.servletContext.contextPath}/sellernet/getDistrictsByProvince.html',
		        data: { provinceId: provinceId },
		        dataType: 'text',
		        success: function(data) {
		            $('#districtId').empty();
		            $('#wardId').empty(); // Empty the wardId select element
		            $('#wardId').append('<option value="">---Phường, xã---</option>'); // Append the default option
		            $("#detail-address").val("");
		            var lines = data.split('\n');
		            $.each(lines, function(index, line) {
		                if (index < lines.length - 1) {
		                    var parts = line.split(':');
		                    $('#districtId').append('<option value="' + parts[0] + '">' + parts[1] + '</option>');
		                }
		            });
		        },
		        error: function(data) {
		            $('#districtId').empty();
		            $('#districtId').append('<option value="">Error occurred while fetching districts</option>');
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
                
        // Format currency
        $(".post").on("mouseover", () => {
      //  	formatCurrency($("input[name='pricePerDay']"));
      //  	formatCurrency($("input[name='fee']"));
      //  	formatCurrency($("input[name='totalMoney']"));
        })
        
		function formatNumber(n) {
		  // format number 1000000 to 1,234,567
		  return n.replace(/\D/g, "").replace(/\B(?=(\d{3})+(?!\d))/g, ",")
		}
		
		
		function formatCurrency(input, blur) {
		  // appends $ to value, validates decimal side
		  // and puts cursor back in right position.
		  
		  // get input value
		  var input_val = input.val();
		  
		  // don't validate empty input
		  if (input_val === "") { return; }
		  
		  // original length
		  var original_len = input_val.length;
		
		  // initial caret position 
		  var caret_pos = input.prop("selectionStart");
		    
		  // check for decimal
		  if (input_val.indexOf(".") >= 0) {
		
		    // get position of first decimal
		    // this prevents multiple decimals from
		    // being entered
		    var decimal_pos = input_val.indexOf(".");
		
		    // split number by decimal point
		    var left_side = input_val.substring(0, decimal_pos);
		    var right_side = input_val.substring(decimal_pos);
		
		    // add commas to left side of number
		    left_side = formatNumber(left_side);
		
		    // validate right side
		    right_side = formatNumber(right_side);
		    
		    // On blur make sure 2 numbers after decimal
		    if (blur === "blur") {
		      right_side += "00";
		    }
		    
		    // Limit decimal to only 2 digits
		    right_side = right_side.substring(0, 2);
		
		    // join number by .
		    input_val = left_side + "." + right_side;
		
		  } else {
		    // no decimal entered
		    // add commas to number
		    // remove all non-digits
		    input_val = formatNumber(input_val);
		    input_val = input_val;
		    
		  }
		  
		  // send updated string to input
		  input.val(input_val);
		
		  // put caret back in the right position
		  var updated_len = input_val.length;
		  caret_pos = updated_len - original_len + caret_pos;
		  input[0].setSelectionRange(caret_pos, caret_pos);
		}
	});
	</script>
</body>
</html>