<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.Date"%>
<%@page import="java.time.ZoneId"%>
<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="batdongsan.models.RealEstateModel"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Website số 1 về bất động sản</title>
<link rel="stylesheet" href="../css/client/index.css" type="text/css">
<link rel="stylesheet" href="../css/client/header.css" type="text/css">
<link rel="stylesheet" href="../css/client/sellernet.css" type="text/css">
<link rel="stylesheet" href="../css/client/listPost.css?version=50" type="text/css">
<%@ include file="../../../../links/links.jsp"%>
<base href="${pageContext.servletContext.contextPath}/">
</head>
<body>
	<%@ include file="../../../components/header.jsp"%>
	<div class='sellernet'>
		<%@ include file="../../../components/sellernetSidebar.jsp"%>

		<!-- ListPost -->
		<div class='list-post'>
			<h1>Danh sách tin</h1>
			<div class='content-container'>
				<div class='filter-wrapper'>
					<div class='search-input'>
						<input type='text' placeholder='Tìm theo tiêu đề, nội dung' /> <i
							class='fa-solid fa-magnifying-glass'></i>
					</div>
				</div>

				<div class='post-container'>
					<ul class='nav nav-tabs'>
						<%							
							List<RealEstateModel> allRealEstates = (List<RealEstateModel>) request.getAttribute("allRealEstates");
							List<RealEstateModel> expiredRealEstates = (List<RealEstateModel>) request.getAttribute("expiredRealEstates");
							List<RealEstateModel> nearExpiredRealEstates = (List<RealEstateModel>) request.getAttribute("nearExpiredRealEstates");
							List<RealEstateModel> displayRealEstates = (List<RealEstateModel>) request.getAttribute("displayRealEstates");
						%>
						<li class='active'><a data-toggle='tab' href='#home'>
								Tất cả (<%= allRealEstates.size() %>) </a></li>
						<li><a data-toggle='tab' href='#menu1'> Hết hạn (<%= expiredRealEstates.size() %>) </a></li>
						<li><a data-toggle='tab' href='#menu2'> Sắp hết hạn (<%= nearExpiredRealEstates.size() %>) </a></li>
						<li><a data-toggle='tab' href='#menu3'> Đang hiển thị (<%= displayRealEstates.size() %>) </a></li>
					</ul>

					<div class='tab-content'>
						<div id='home' class='tab-pane fade in active'>
							<%									
							if (allRealEstates != null) {
								for (RealEstateModel r : allRealEstates) {
									String imageString = (String) r.getImages();
		
									if (imageString != null && !imageString.isEmpty()) {
										imageString = imageString.substring(1, imageString.length() - 1);
										String[] imagePaths = imageString.split(",");
										
										 LocalDate ngayHienTai = LocalDate.now();
										 java.util.Date submittedDate = r.getSubmittedDate();
										 java.util.Date expirationDate = r.getExpirationDate();
										 LocalDate ngay2 = null;
										 if (expirationDate != null) {
										     // Convert java.sql.Date to java.util.Date
										     java.util.Date utilExpirationDate = new java.util.Date(expirationDate.getTime());
										     ngay2 = utilExpirationDate.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
										 }

										// Calculate the difference in days
										long khoangCach = ChronoUnit.DAYS.between(ngayHienTai, ngay2);
										
										SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
									    String submittedDateString = dateFormat.format(submittedDate);
									    String expirationDateString = dateFormat.format(expirationDate);
							%>
							<div class='post-card'>
								<div>
									<img src="images/<%= imagePaths[0] %>" alt='' />
									<div class='post-content-container'>
										<div>
											<h4 class='header'><%= r.getTitle() %></h4>
											<div class='location'>
												<span><%= r.getCategory().getName() %></span> <span> · </span> 
												<span><%= r.getAddress() %></span>
											</div>
										</div>
										<div class='detail-container'>
											<div class='detail-item'>
												<span class='primary'>Trạng thái</span>
												<div class='status'><%= r.getStatus() %></div>
											</div>
											<div class='detail-item'>
												<span class='primary'>Mã tin</span>
												<div class='secondary'><%= r.getRealEstateId() %></div>
											</div>
											<div class='detail-item'>
												<span class='primary'>Ngày đăng</span>
												<div class='secondary'><%= submittedDateString %></div>
											</div>
											<div class='detail-item'>
												<span class='primary'>Ngày hết hạn</span>
												<div class='secondary'><%= expirationDateString %></div>
											</div>
											<div class='detail-item'>
											    <span class='primary'>Thời gian</span>
											    <div class='secondary'><%= khoangCach > 0 ? "Còn " + khoangCach + " ngày" : "Hết hạn" %></div>
											</div>
										</div>
									</div>
								</div>
								<div>
									<div class='blank-container'></div>
									<div class='button-container'>
										<a href="${pageContext.servletContext.contextPath}/chi-tiet.html?realEstateId=<%= r.getRealEstateId() %>" class='button-item'>
											<i class='fa-solid fa-ranking-star'></i> <span>Chi tiết</span>
										</a>
										<a href="${pageContext.servletContext.contextPath}/sellernet/<%if ("Nhà đất bán".equals(r.getCategory().getType())) {%>chinh-sua/ban<%} else {%>chinh-sua/cho-thue<%}%>.html?realEstateId=<%= r.getRealEstateId() %>" class='button-item'>
											<i class='fa-solid fa-pencil'></i> <span>Sửa tin</span>
										</a>
										<a href="${pageContext.servletContext.contextPath}/sellernet/deleteRealEstate.html?realEstateId=<%= r.getRealEstateId() %>" class='button-item'>
											<i class="fa-solid fa-trash-can"></i> <span>Xóa tin</span>
										</a>
										<a href="${pageContext.servletContext.contextPath}/chi-tiet.html?realEstateId=<%= r.getRealEstateId() %>" class='button-item'>
											<i class='fa-regular fa-share-from-square'></i> <span>Chia
												sẻ</span>
										</a>
										<div class='dropdown'>
											<div class='button-item dropdown-toggle' type='button' data-toggle='dropdown'>
												<i class='fa-solid fa-ellipsis'></i> <span>Thao tác</span>
											</div>
											<ul class='dropdown-menu'>
												<li><a href='${pageContext.servletContext.contextPath}/chi-tiet.html?realEstateId=<%= r.getRealEstateId() %>'> <i class='fa-solid fa-ranking-star'></i>
														<span>Chi tiết</span>
												</a>
												</li>
												<li><a href="${pageContext.servletContext.contextPath}/sellernet/<%if ("Nhà đất bán".equals(r.getCategory().getType())) {%>chinh-sua/ban<%} else {%>chinh-sua/cho-thue<%}%>.html?realEstateId=<%= r.getRealEstateId() %>"> <i class='fa-solid fa-pencil'></i>
														<span>Sửa tin</span>
												</a>
												</li>
												<li><a href='${pageContext.servletContext.contextPath}/sellernet/deleteRealEstate.html?realEstateId=<%= r.getRealEstateId() %>'> <i class='fa-solid fa-trash-can'></i>
														<span>Xóa tin</span>
												</a>
												</li>
											</ul>
										</div>
									</div>
								</div>
							</div>
							<%
							}
							}
							}
							%>
						</div>
						<div id='menu1' class='tab-pane fade'>
							<%							
							if (allRealEstates != null) {
								for (RealEstateModel r : expiredRealEstates) {
									String imageString = (String) r.getImages();
		
									if (imageString != null && !imageString.isEmpty()) {
										imageString = imageString.substring(1, imageString.length() - 1);
										String[] imagePaths = imageString.split(",");
										
										 LocalDate ngayHienTai = LocalDate.now();
										 java.util.Date submittedDate = r.getSubmittedDate();
										 java.util.Date expirationDate = r.getExpirationDate();
										 LocalDate ngay2 = null;
										 if (expirationDate != null) {
										     // Convert java.sql.Date to java.util.Date
										     java.util.Date utilExpirationDate = new java.util.Date(expirationDate.getTime());
										     ngay2 = utilExpirationDate.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
										 }

										// Calculate the difference in days
										long khoangCach = ChronoUnit.DAYS.between(ngayHienTai, ngay2);

										SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
									    String submittedDateString = dateFormat.format(submittedDate);
									    String expirationDateString = dateFormat.format(expirationDate);
							%>
							<div class='post-card'>
								<div>
									<img src="images/<%= imagePaths[0] %>" alt='' />
									<div class='post-content-container'>
										<div>
											<h4 class='header'><%= r.getTitle() %></h4>
											<div class='location'>
												<span><%= r.getCategory().getName() %></span> <span> · </span> 
												<span><%= r.getAddress() %></span>
											</div>
										</div>
										<div class='detail-container'>
											<div class='detail-item'>
												<span class='primary'>Trạng thái</span>
												<div class='status'><%= r.getStatus() %></div>
											</div>
											<div class='detail-item'>
												<span class='primary'>Mã tin</span>
												<div class='secondary'><%= r.getRealEstateId() %></div>
											</div>
											<div class='detail-item'>
												<span class='primary'>Ngày đăng</span>
												<div class='secondary'><%= r.getSubmittedDate() %></div>
											</div>
											<div class='detail-item'>
												<span class='primary'>Ngày hết hạn</span>
												<div class='secondary'><%= r.getExpirationDate() %></div>
											</div>
											<div class='detail-item'>
											    <span class='primary'>Thời gian</span>
											    <div class='secondary'> <%= khoangCach > 0 ? "Còn " + khoangCach + " ngày" : "Hết hạn" %> </div>

											</div>
										</div>
									</div>
								</div>
								<div>
									<div class='blank-container'></div>
									<div class='button-container'>
										<a href="${pageContext.servletContext.contextPath}/chi-tiet.html?realEstateId=<%= r.getRealEstateId() %>" class='button-item'>
											<i class='fa-solid fa-ranking-star'></i> <span>Chi tiết</span>
										</a>
										<a href="${pageContext.servletContext.contextPath}/sellernet/<%if ("Nhà đất bán".equals(r.getCategory().getType())) {%>chinh-sua/ban<%} else {%>chinh-sua/cho-thue<%}%>.html?realEstateId=<%= r.getRealEstateId() %>" class='button-item'>
											<i class='fa-solid fa-pencil'></i> <span>Sửa tin</span>
										</a>
										<a href="${pageContext.servletContext.contextPath}/sellernet/deleteRealEstate.html?realEstateId=<%= r.getRealEstateId() %>" class='button-item'>
											<i class='fa-solid fa-trash-can'></i> <span>Xóa tin</span>
										</a>
										<a href="${pageContext.servletContext.contextPath}/chi-tiet.html?realEstateId=<%= r.getRealEstateId() %>" class='button-item'>
											<i class='fa-regular fa-share-from-square'></i> <span>Chia
												sẻ</span>
										</a>
										<div class='dropdown'>
											<div class='button-item dropdown-toggle' type='button' data-toggle='dropdown'>
												<i class='fa-solid fa-ellipsis'></i> <span>Thao tác</span>
											</div>
											<ul class='dropdown-menu'>
												<li><a href='${pageContext.servletContext.contextPath}/chi-tiet.html?realEstateId=<%= r.getRealEstateId() %>'> <i class='fa-solid fa-ranking-star'></i>
														<span>Chi tiết</span>
												</a>
												</li>
												<li><a href="${pageContext.servletContext.contextPath}/sellernet/<%if ("Nhà đất bán".equals(r.getCategory().getType())) {%>chinh-sua/ban<%} else {%>chinh-sua/cho-thue<%}%>.html?realEstateId=<%= r.getRealEstateId() %>"> <i class='fa-solid fa-pencil'></i>
														<span>Sửa tin</span>
												</a>
												</li>
												<li><a href='${pageContext.servletContext.contextPath}/sellernet/deleteRealEstate.html?realEstateId=<%= r.getRealEstateId() %>'> <i class='fa-solid fa-trash-can'></i>
														<span>Xóa tin</span>
												</a>
												</li>
											</ul>
										</div>
									</div>
								</div>
							</div>
							<%
							}
							}
							}
							%>
						</div>
						<div id='menu2' class='tab-pane fade'>
							<%									
							if (allRealEstates != null) {
								for (RealEstateModel r : nearExpiredRealEstates) {
									String imageString = (String) r.getImages();
		
									if (imageString != null && !imageString.isEmpty()) {
										imageString = imageString.substring(1, imageString.length() - 1);
										String[] imagePaths = imageString.split(",");
										
										 LocalDate ngayHienTai = LocalDate.now();
										 java.util.Date submittedDate = r.getSubmittedDate();
										 java.util.Date expirationDate = r.getExpirationDate();
										 LocalDate ngay2 = null;
										 if (expirationDate != null) {
										     // Convert java.sql.Date to java.util.Date
										     java.util.Date utilExpirationDate = new java.util.Date(expirationDate.getTime());
										     ngay2 = utilExpirationDate.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
										 }

										// Calculate the difference in days
										long khoangCach = ChronoUnit.DAYS.between(ngayHienTai, ngay2);

										SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
									    String submittedDateString = dateFormat.format(submittedDate);
									    String expirationDateString = dateFormat.format(expirationDate);
							%>
							<div class='post-card'>
								<div>
									<img src="images/<%= imagePaths[0] %>" alt='' />
									<div class='post-content-container'>
										<div>
											<h4 class='header'><%= r.getTitle() %></h4>
											<div class='location'>
												<span><%= r.getCategory().getName() %></span> <span> · </span> 
												<span><%= r.getAddress() %></span>
											</div>
										</div>
										<div class='detail-container'>
											<div class='detail-item'>
												<span class='primary'>Trạng thái</span>
												<div class='status'><%= r.getStatus() %></div>
											</div>
											<div class='detail-item'>
												<span class='primary'>Mã tin</span>
												<div class='secondary'><%= r.getRealEstateId() %></div>
											</div>
											<div class='detail-item'>
												<span class='primary'>Ngày đăng</span>
												<div class='secondary'><%= r.getSubmittedDate() %></div>
											</div>
											<div class='detail-item'>
												<span class='primary'>Ngày hết hạn</span>
												<div class='secondary'><%= r.getExpirationDate() %></div>
											</div>
											<div class='detail-item'>
											    <span class='primary'>Thời gian</span>
											    <div class='secondary'> <%= khoangCach > 0 ? "Còn " + khoangCach + " ngày" : "Hết hạn" %> </div>

											</div>
										</div>
									</div>
								</div>
								<div>
									<div class='blank-container'></div>
									<div class='button-container'>
										<a href="${pageContext.servletContext.contextPath}/chi-tiet.html?realEstateId=<%= r.getRealEstateId() %>" class='button-item'>
											<i class='fa-solid fa-ranking-star'></i> <span>Chi tiết</span>
										</a>
										<a href="${pageContext.servletContext.contextPath}/sellernet/<%if ("Nhà đất bán".equals(r.getCategory().getType())) {%>chinh-sua/ban<%} else {%>chinh-sua/cho-thue<%}%>.html?realEstateId=<%= r.getRealEstateId() %>" class='button-item'>
											<i class='fa-solid fa-pencil'></i> <span>Sửa tin</span>
										</a>
										<a href="${pageContext.servletContext.contextPath}/sellernet/deleteRealEstate.html?realEstateId=<%= r.getRealEstateId() %>" class='button-item'>
											<i class='fa-solid fa-trash-can'></i> <span>Xóa tin</span>
										</a>
										<a href="${pageContext.servletContext.contextPath}/chi-tiet.html?realEstateId=<%= r.getRealEstateId() %>" class='button-item'>
											<i class='fa-regular fa-share-from-square'></i> <span>Chia
												sẻ</span>
										</a>
										<div class='dropdown'>
											<div class='button-item dropdown-toggle' type='button' data-toggle='dropdown'>
												<i class='fa-solid fa-ellipsis'></i> <span>Thao tác</span>
											</div>
											<ul class='dropdown-menu'>
												<li><a href='${pageContext.servletContext.contextPath}/chi-tiet.html?realEstateId=<%= r.getRealEstateId() %>'> <i class='fa-solid fa-ranking-star'></i>
														<span>Chi tiết</span>
												</a>
												</li>
												<li><a href="${pageContext.servletContext.contextPath}/sellernet/<%if ("Nhà đất bán".equals(r.getCategory().getType())) {%>chinh-sua/ban<%} else {%>chinh-sua/cho-thue<%}%>.html?realEstateId=<%= r.getRealEstateId() %>"> <i class='fa-solid fa-pencil'></i>
														<span>Sửa tin</span>
												</a>
												</li>
												<li><a href='${pageContext.servletContext.contextPath}/sellernet/deleteRealEstate.html?realEstateId=<%= r.getRealEstateId() %>'> <i class='fa-solid fa-trash-can'></i>
														<span>Xóa tin</span>
												</a>
												</li>
											</ul>
										</div>
									</div>
								</div>
							</div>
							<%
							}
							}
							}
							%>
						</div>
						<div id='menu3' class='tab-pane fade'>
							<%									
							if (allRealEstates != null) {
								for (RealEstateModel r : displayRealEstates) {
									String imageString = (String) r.getImages();
		
									if (imageString != null && !imageString.isEmpty()) {
										imageString = imageString.substring(1, imageString.length() - 1);
										String[] imagePaths = imageString.split(",");
										
										 LocalDate ngayHienTai = LocalDate.now();
										 java.util.Date submittedDate = r.getSubmittedDate();
										 java.util.Date expirationDate = r.getExpirationDate();
										 LocalDate ngay2 = null;
										 if (expirationDate != null) {
										     // Convert java.sql.Date to java.util.Date
										     java.util.Date utilExpirationDate = new java.util.Date(expirationDate.getTime());
										     ngay2 = utilExpirationDate.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
										 }

										// Calculate the difference in days
										long khoangCach = ChronoUnit.DAYS.between(ngayHienTai, ngay2);

										SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
									    String submittedDateString = dateFormat.format(submittedDate);
									    String expirationDateString = dateFormat.format(expirationDate);
							%>
							<div class='post-card'>
								<div>
									<img src="images/<%= imagePaths[0] %>" alt='' />
									<div class='post-content-container'>
										<div>
											<h4 class='header'><%= r.getTitle() %></h4>
											<div class='location'>
												<span><%= r.getCategory().getName() %></span> <span> · </span> 
												<span><%= r.getAddress() %></span>
											</div>
										</div>
										<div class='detail-container'>
											<div class='detail-item'>
												<span class='primary'>Trạng thái</span>
												<div class='status'><%= r.getStatus() %></div>
											</div>
											<div class='detail-item'>
												<span class='primary'>Mã tin</span>
												<div class='secondary'><%= r.getRealEstateId() %></div>
											</div>
											<div class='detail-item'>
												<span class='primary'>Ngày đăng</span>
												<div class='secondary'><%= r.getSubmittedDate() %></div>
											</div>
											<div class='detail-item'>
												<span class='primary'>Ngày hết hạn</span>
												<div class='secondary'><%= r.getExpirationDate() %></div>
											</div>
											<div class='detail-item'>
											    <span class='primary'>Thời gian</span>
											    <div class='secondary'> <%= khoangCach > 0 ? "Còn " + khoangCach + " ngày" : "Hết hạn" %> </div>

											</div>
										</div>
									</div>
								</div>
								<div>
									<div class='blank-container'></div>
									<div class='button-container'>
										<a href="${pageContext.servletContext.contextPath}/chi-tiet.html?realEstateId=<%= r.getRealEstateId() %>" class='button-item'>
											<i class='fa-solid fa-ranking-star'></i> <span>Chi tiết</span>
										</a>
										<a href="${pageContext.servletContext.contextPath}/sellernet/<%if ("Nhà đất bán".equals(r.getCategory().getType())) {%>chinh-sua/ban<%} else {%>chinh-sua/cho-thue<%}%>.html?realEstateId=<%= r.getRealEstateId() %>" class='button-item'>
											<i class='fa-solid fa-pencil'></i> <span>Sửa tin</span>
										</a>
										<a href="${pageContext.servletContext.contextPath}/sellernet/deleteRealEstate.html?realEstateId=<%= r.getRealEstateId() %>" class='button-item'>
											<i class='fa-solid fa-trash-can'></i> <span>Xóa tin</span>
										</a>
										<a href="${pageContext.servletContext.contextPath}/chi-tiet.html?realEstateId=<%= r.getRealEstateId() %>" class='button-item'>
											<i class='fa-regular fa-share-from-square'></i> <span>Chia
												sẻ</span>
										</a>
										<div class='dropdown'>
											<div class='button-item dropdown-toggle' type='button' data-toggle='dropdown'>
												<i class='fa-solid fa-ellipsis'></i> <span>Thao tác</span>
											</div>
											<ul class='dropdown-menu'>
												<li><a href='${pageContext.servletContext.contextPath}/chi-tiet.html?realEstateId=<%= r.getRealEstateId() %>'> <i class='fa-solid fa-ranking-star'></i>
														<span>Chi tiết</span>
												</a>
												</li>
												<li><a href="${pageContext.servletContext.contextPath}/sellernet/<%if ("Nhà đất bán".equals(r.getCategory().getType())) {%>chinh-sua/ban<%} else {%>chinh-sua/cho-thue<%}%>.html?realEstateId=<%= r.getRealEstateId() %>"> <i class='fa-solid fa-pencil'></i>
														<span>Sửa tin</span>
												</a>
												</li>
												<li><a href='${pageContext.servletContext.contextPath}/sellernet/deleteRealEstate.html?realEstateId=<%= r.getRealEstateId() %>'> <i class='fa-solid fa-trash-can'></i>
														<span>Xóa tin</span>
												</a>
												</li>
											</ul>
										</div>
									</div>
								</div>
							</div>
							<%
							}
							}
							}
							%>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
	$(document).ready(function() {
		let searchInput = $(".search-input input");
		let searchInputButton = $(".search-input .fa-magnifying-glass");
		
		searchInputButton.on("click", () => {
			let url = "${pageContext.servletContext.contextPath}/sellernet/quan-ly-tin-rao-ban-cho-thue.html";
			url += "?searchInput=" + searchInput.val();
			window.location.href = url;
		})
	})
	</script>
</body>
</html>