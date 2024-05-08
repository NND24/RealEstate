<%@page import="java.time.ZoneId"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="batdongsan.models.RealEstateModel"%>
<%@page import="java.util.List"%>
<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Website số 1 về bất động sản</title>
<link rel="stylesheet" href="../css/client/index.css" type="text/css">
<link rel="stylesheet" href="../css/admin/headerAdmin.css" type="text/css">
<link rel="stylesheet" href="../css/admin/listPost.css" type="text/css">
<%@ include file="../../../links/links.jsp"%>
</head>
<body>
	<%@ include file="../../components/headerAdmin.jsp"%>
	<div class='admin active'>
		<%@ include file="../../components/sidebarAdmin.jsp"%>

		<!-- ListPost -->
		<div class='admin-list-post'>
			<h1>Danh sách bất động sản</h1>
			<div class='content-container'>
				<div class='filter-wrapper'>
					<div class='search-input'>
						<input type='text' placeholder='Tìm theo mã tin, tiêu đề' /> <i
							class='fa-solid fa-magnifying-glass'></i>
					</div>
					<div class='dropdown'>
						<button class='btn dropdown-toggle' type='button'
							data-toggle='dropdown'>
							<i class='fa-regular fa-calendar'></i> <span>Mặc định</span>
							<i class='fa-solid fa-angle-down'></i>
						</button>
					</div>
				</div>
				<%							
					List<RealEstateModel> allRealEstates = (List<RealEstateModel>) request.getAttribute("allRealEstates");
				%>
				<div class='post-container'>
					<div class='tab-content'>
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
						<div class='admin-post-card'>
							<div>
								<img src="${pageContext.servletContext.contextPath}/images/<%= imagePaths[0] %>" alt='' />
								<div class='post-content-container'>
									<div>
										<h4 class='header'><%= r.getTitle() %></h4>
										<div class='location'>
											<span><%= r.getCategory().getName() %></span> <span> · </span> <span><%= r.getAddress() %></span>
										</div>
									</div>
									<div class='detail-container'>
										<div class='detail-item'>
											<span class='primary'>Trạng thái</span>
											<div class='status' style="background-color: <%= (r.getStatus().equals("Chưa được duyệt") || r.getStatus().equals("Ẩn")) ? "#da2c2c" : "#43999f" %>" ><%= r.getStatus() %></div>
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
									<a href="${pageContext.servletContext.contextPath}/admin/browseRealEstate.html?realEstateId=<%= r.getRealEstateId() %>" class='button-item'>
										<i class='fa-regular fa-flag'></i> <span>Duyệt tin</span>
									</a>
									<a href="${pageContext.servletContext.contextPath}/admin/chi-tiet.html?realEstateId=<%= r.getRealEstateId() %>" class='button-item'>
										<i class='fa-solid fa-ranking-star'></i> <span>Chi tiết</span>
									</a>
									<a href=<% if(r.getStatus().equals("Chưa được duyệt")) { %> "" <% } else { %> "${pageContext.servletContext.contextPath}/admin/hideDisplayRealEstate.html?realEstateId=<%= r.getRealEstateId() %>" <% } %> class='button-item'>
										<i class='fa-solid fa-pencil'></i> <span><%= r.getStatus().equals("Ẩn") ? "Hiển thị" : "Ẩn" %> tin</span>
									</a>
									<a href="${pageContext.servletContext.contextPath}/admin/deleteRealEstate.html?realEstateId=<%= r.getRealEstateId() %>" class='button-item'>
										<i class='fa-regular fa-share-from-square'></i> <span>Xóa tin</span>
									</a>
									<div class='dropdown'>
										<div class='button-item dropdown-toggle' type='button'
											data-toggle='dropdown'>
											<i class='fa-solid fa-ellipsis'></i> <span>Thao
												tác</span>
										</div>
									<!--  	<ul class='dropdown-menu'>
											<li><a href='#'> <i class='fa-solid fa-pencil'></i>
													<span>Sửa tin</span>
											</a></li>
											<li><a href='#'>CSS</a></li>
											<li><a href='#'>JavaScript</a></li>
										</ul> -->
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
</body>
</html>