<%@page import="java.text.SimpleDateFormat"%>
<%@page import="batdongsan.models.RealEstateModel"%>
<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Website số 1 về bất động sản</title>
<link rel="stylesheet" href="css/client/index.css" type="text/css">
<link rel="stylesheet" href="css/client/header.css" type="text/css">
<link rel="stylesheet" href="css/client/detail.css" type="text/css">
<link rel="stylesheet" href="css/client/footer.css" type="text/css">
<%@ include file="../../../links/links.jsp"%>
</head>
<body>
	<%@ include file="../../components/header.jsp"%>
	<div class="detail">
		<div class='container '>
			<%
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
			RealEstateModel realEstate = (RealEstateModel) request.getAttribute("realEstate");
			if (realEstate != null) {
				String imageString = (String) realEstate.getImages();
				if (imageString != null && !imageString.isEmpty()) {
					imageString = imageString.substring(1, imageString.length() - 1);
					String[] imagePaths = imageString.split(", ");
					
					 String formattedDate = sdf.format(realEstate.getUpdatedDate());
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
								<img src='<%=imagePath%>' />
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
								<img src='<%=imagePath%>' />
							</div>
							<%
							}
							%>
						</div>
					</div>

					<div class='breadcrumb'>
						<a href=''>Cho thuê</a> <span> / </span> <a href=''>Hồ Chí
							Minh</a> <span> / </span> <a href=''>Tất cả BĐS trên toàn quốc</a>
					</div>
					<h3 class='detail-content__title'><%=realEstate.getTitle()%></h3>
					<p class='detail-content__address'><%=realEstate.getAddress()%></p>
					<div class='short-info-container'>
						<div>
							<div class='short-info__item'>
								<span class='title'>Mức giá</span> <span class='value'><%=realEstate.getPrice()%> <%=realEstate.getUnit()%></span>
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
							</a> <a href='' class='short-info__button'> <i
								class='fa-regular fa-heart'></i>
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
								<div class='spec-content-item__value'><%=realEstate.getPrice()%> <%=realEstate.getUnit()%></div>
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
					<div class='search-tag-container'>
						<div class='section-title'>Tìm kiếm theo từ khóa</div>
						<div class='search-tag-list'>
							<a href='' class='search-tag-item'> Thuê trọ phường 10 Tân
								Bình </a> <a href='' class='search-tag-item'> Thuê trọ Gò Cẩm
								Đệm Tân Bình </a> <a href='' class='search-tag-item'> Thuê trọ
								Tân Bình Hồ Chí Minh </a> <a href='' class='search-tag-item'>
								Thuê trọ Hồ Chí Minh </a> <a href='' class='search-tag-item'>
								Thuê căn hộ mini Hồ Chí Minh </a>
						</div>
					</div>
					<div class='short-info-container'>
						<div>
							<div class='short-info__item'>
								<span class='title'>Ngày đăng</span> <span class='value'><%=formattedDate%></span>
							</div>
							<div class='short-info__item'>
								<span class='title'>Ngày hết hạn</span> <span class='value'><%=formattedDate%></span>
							</div>
							<div class='short-info__item'>
								<span class='title'>Loại tin</span> <span class='value'>Tin
									VIP Bạc</span>
							</div>
							<div class='short-info__item'>
								<span class='title'>Mã tin</span> <span class='value'><%=realEstate.getRealEstateId()%></span>
							</div>
						</div>
					</div>
					<div class='recommend-list-container'>
						<div class='swiper mySwiper3'>
							<div class='recommend-list-header'>
								<h5 class='recommend-title'>Bất động sản dành cho bạn</h5>
							</div>
							<div class='swiper-wrapper'>
								<div class='swiper-slide'>
									<div class='recommend-card'>
										<div class='card-image'>
											<img src="" alt='' />
											<div class='card-image-feature'>
												<i class='fa-regular fa-image'></i> <span>6</span>
											</div>
										</div>
										<div class='card-info-container'>
											<div class='card-info__title'>Thuê phòng trọ mới xây
												đường Lý Thường Kiệt, gần ĐH Bách Khoa, giờ giấc tự do, giá
												2tr5/th</div>
											<div class='card-info__config'>
												<span class='card-config__item card-config__price'>3,6
													tỷ</span> <span class='card-config__item card-config__dot'>·</span>
												<span class='card-config__item card-config__area'>92
													m²</span>
											</div>
											<div class='card-info__location'>
												<i class='fa-solid fa-location-dot'></i> <span>Quận
													11, Hồ Chí Minh</span>
											</div>
											<div class='card-info__contact'>
												<div class='card-published-info'>Đăng 5 ngày trước</div>
												<div class='card-contact-button'>
													<i class='fa-regular fa-heart'></i>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class='swiper-button-next'></div>
							<div class='swiper-button-prev'></div>
						</div>
					</div>
				</div>

				<!-- Sidebar -->
				<div class='detail-sidebar col-lg-3'>
					<div class='sidebar-box-contact'>
						<img class='contact-avatar' src="" alt='' />
						<p>Được đăng bởi</p>
						<h5 class='contact-name'><%=realEstate.getContactName()%></h5>
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

					<div class='sidebar-box'>
						<h5 class='sidebar-box__title'>Lọc theo diện tích</h5>
						<ul class='sidebar-box__content'>
							<li class='sidebar-box__item'><a href='#'>Thỏa thuận</a></li>
							<li class='sidebar-box__item'><a>Dưới 500 triệu</a></li>
							<li class='sidebar-box__item'><a>500 - 800 triệu</a></li>
							<li class='sidebar-box__item'><a>800 triệu - 1 tỷ</a></li>
							<li class='sidebar-box__item'><a>1 - 2 tỷ</a></li>
						</ul>
					</div>
				</div>
			</div>
			<%
			}
			}
			%>
		</div>
	</div>
	<%@ include file="../../components/footer.jsp"%>

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
	</script>
</body>
</html>