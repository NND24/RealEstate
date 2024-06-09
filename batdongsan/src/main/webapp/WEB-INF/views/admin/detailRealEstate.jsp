<%@page import="java.text.SimpleDateFormat"%>
<%@page import="batdongsan.models.RealEstateModel"%>
<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Website số 1 về bất động sản</title>
<link rel="stylesheet" href="../css/client/index.css" type="text/css">
<link rel="stylesheet" href="../css/admin/headerAdmin.css" type="text/css">
<link rel="stylesheet" href="../css/admin/detailRealEstate.css?version=52" type="text/css">
<%@ include file="../../../links/links.jsp"%>
</head>
<body>
	<%@ include file="../../components/headerAdmin.jsp"%>
	<div class="detail admin">
		<%@ include file="../../components/sidebarAdmin.jsp"%>
		
		<div class='container '>
			<%
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
			RealEstateModel realEstate = (RealEstateModel) request.getAttribute("realEstate");
			if (realEstate != null) {
				String imageString = (String) realEstate.getImages();
				if (imageString != null && !imageString.isEmpty()) {
					imageString = imageString.substring(1, imageString.length() - 1);
					String[] imagePaths = imageString.split(",");
					
					 String submittedDate = sdf.format(realEstate.getSubmittedDate());
					 String expirationDate = sdf.format(realEstate.getExpirationDate());
			%>
			<div class='row'>

				<!-- Content -->
				<div class='detail-content col-lg-9'>

					<div class='swiper mySwiper2'>
						<div class='swiper-wrapper'>
							<%
							for (String imagePath : imagePaths) {
							%>
							<div class='swiper-slide'>
								<img src='${pageContext.servletContext.contextPath}/images/<%=imagePath.trim()%>' />
							</div>
							<%
							}
							%>
						</div>
						<div class='swiper-button-next'></div>
						<div class='swiper-button-prev'></div>
						<div class='swiper-pagination'></div>
					</div>
					<div thumbsSlider='' class='swiper mySwiper'>
						<div class='swiper-wrapper'>
							<%
							for (String imagePath : imagePaths) {
							%>
							<div class='swiper-slide'>
								<img src='${pageContext.servletContext.contextPath}/images/<%=imagePath.trim()%>' />
							</div>
							<%
							}
							%>
						</div>
					</div>

					<div class='breadcrumb'>
						<a href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html'><%if ("sell".equals(request.getAttribute("page"))) {%> Bán <%} else {%> Cho thuê <%}%></a> 
						<span> / </span> <a><%=realEstate.getTitle()%></a>
					</div>
					<h3 class='detail-content__title'><%=realEstate.getTitle()%></h3>
					<p class='detail-content__address'><%=realEstate.getAddress()%></p>
					<div class='short-info-container'>
						<div>
							<div class='short-info__item'>
								<span class='title'>Mức giá</span> <span class='value'>
								<%
								if(realEstate.getPrice() < 1000000000) {
								    out.print((int)(realEstate.getPrice() / 1000000) + " triệu");
								} else {
								    out.print(realEstate.getPrice() / 1000000000 + " tỷ");
								}
								%>
								<%
								if(realEstate.getUnit().equals("triệu")) {
								    out.print("");
								} else {
								    out.print(realEstate.getUnit());
								}
								%>
								</span>
							</div>
							<div class='short-info__item'>
								<span class='title'>Diện tích</span> <span class='value'><%=realEstate.getArea()%>
									m²</span>
							</div>
						</div>
						<div>
							<a href='' class='short-info__button'> <i
								class='fa-solid fa-share-nodes'></i>
							</a> <a href='' class='short-info__button'> <i
								class='fa-solid fa-triangle-exclamation'></i>
							</a> 
							<a class='short-info__button card-contact-button__favorite' value="<%=realEstate.getRealEstateId()%>"> 
								<i class='fa-regular fa-heart'
										style="display: <%=realEstate.getFavourite().size() > 0 ? "none" : "block"%>;"></i>
									<i class="fa-solid fa-heart"
										style="color: #e03c31;display: <%=realEstate.getFavourite().size() > 0 ? "block" : "none"%>;"></i>
							</a>
						</div>
					</div>
					<div class='description-container'>
						<div class='section-title'>Thông tin mô tả</div>
						<div class='description-body'>
							<%=realEstate.getDescription()%>
						</div>
					</div>
					<div class='spec-container'>
						<div class='section-title'>Đặc điểm bất động sản</div>
						<div class='row'>
							<div class='spec-content-item col-lg-6'>
								<i class='fa-regular fa-square spec-content-item__icon'></i>
								<div class='spec-content-item__title'>Diện tích</div>
								<div class='spec-content-item__value'><%=realEstate.getArea()%> m²</div>
							</div>
							<div class='spec-content-item col-lg-6'>
								<i class='fa-solid fa-dong-sign spec-content-item__icon'></i>
								<div class='spec-content-item__title'>Mức giá</div>
								<div class='spec-content-item__value'>
								<%
								if(realEstate.getPrice() < 1000000000) {
								    out.print((int)(realEstate.getPrice() / 1000000) + " triệu");
								} else {
								    out.print(realEstate.getPrice() / 1000000000 + " tỷ");
								}
								%>
								<%
								if(realEstate.getUnit().equals("triệu")) {
								    out.print("");
								} else {
								    out.print(realEstate.getUnit());
								}
								%>
								</div>
							</div>
							<%
							if(realEstate.getNumberOfToilets() > 0) {
							%>
							<div class='spec-content-item col-lg-6'>
								<i class='fa-solid fa-bath spec-content-item__icon'></i>
								<div class='spec-content-item__title'>Số toilet</div>
								<div class='spec-content-item__value'><%=realEstate.getNumberOfToilets()%> phòng</div>
							</div>
							<% } %>
							<%
							if(realEstate.getNumberOfBedrooms() > 0) {
							%>
							<div class='spec-content-item col-lg-6'>
								<i class='fa-solid fa-couch spec-content-item__icon'></i>
								<div class='spec-content-item__title'>Số phòng ngủ</div>
								<div class='spec-content-item__value'><%=realEstate.getNumberOfBedrooms()%> phòng</div>
							</div>
							<% } %>
						</div>
					</div>
			<!-- 	<div class='search-tag-container'>
						<div class='section-title'>Tìm kiếm theo từ khóa</div>
						<div class='search-tag-list'>
							<a href='' class='search-tag-item'> Thuê trọ phường 10 Tân
								Bình </a> <a href='' class='search-tag-item'> Thuê trọ Gò Cẩm
								Đệm Tân Bình </a> <a href='' class='search-tag-item'> Thuê trọ
								Tân Bình Hồ Chí Minh </a> <a href='' class='search-tag-item'>
								Thuê trọ Hồ Chí Minh </a> <a href='' class='search-tag-item'>
								Thuê căn hộ mini Hồ Chí Minh </a>
						</div>
					</div>  -->
					<div class='short-info-container'>
						<div>
							<div class='short-info__item'>
								<span class='title'>Ngày đăng</span> <span class='value'><%=submittedDate%></span>
							</div>
							<div class='short-info__item'>
								<span class='title'>Ngày hết hạn</span> <span class='value'><%=expirationDate%></span>
							</div>
							<div class='short-info__item'>
								<span class='title'>Loại tin</span> <span class='value'><%= realEstate.getTypePost() %></span>
							</div>
							<div class='short-info__item'>
								<span class='title'>Mã tin</span> <span class='value'><%=realEstate.getRealEstateId()%></span>
							</div>
						</div>
					</div>
				</div>

				<!-- Sidebar -->
				<div class='detail-sidebar col-lg-3'>
					<div class='sidebar-box-contact'>
						<a href='${pageContext.servletContext.contextPath}/profile.html?userId=<%=realEstate.getUser().getUserId() %>'>
							<img class='contact-avatar' src="${pageContext.servletContext.contextPath}/images/<%=realEstate.getUser().getAvatar() %>" alt='' />
						</a>
						<p>Được đăng bởi</p>
						<a href='${pageContext.servletContext.contextPath}/profile.html?userId=<%=realEstate.getUser().getUserId() %>'>
							<h5 class='contact-name'><%=realEstate.getContactName()%></h5>
						</a>
						<div class='contact-button contact-button__phonenumber'>
							<span>0912 345 679</span> <span
								class='contact-button__phonenumber__dot'>·</span> <span>Hiện
								số</span>
						</div>
						<div class='contact-button'>
							<span>Chat qua zalo</span>
						</div>
						<div class='contact-button'>
							<span>Gửi email</span>
						</div>
						<div class='contact-button'>
							<span>Yêu cầu liên hệ lại</span>
						</div>
					</div>					
				</div>
			</div>
			<%
			}
			}
			%>
		</div>
	</div>

	<script type="text/javascript">
		var swiper = new Swiper(".mySwiper", {
			spaceBetween : 10,
			slidesPerView : 6,
			freeMode : true,
			watchSlidesProgress : true,
		});
		var swiper2 = new Swiper(".mySwiper2", {
			spaceBetween : 10,
			navigation : {
				nextEl : ".swiper-button-next",
				prevEl : ".swiper-button-prev",
			},
			thumbs : {
				swiper : swiper,
			},
			pagination : {
				el : ".swiper-pagination",
				type : "fraction",
			},
		});
		var swiper3 = new Swiper(".mySwiper3", {
			slidesPerView : 3,
			spaceBetween : 15,
			navigation : {
				nextEl : ".swiper-button-next",
				prevEl : ".swiper-button-prev",
			},
		});
		
		$(document).ready(function() {
			
		})
	</script>
</body>
</html>