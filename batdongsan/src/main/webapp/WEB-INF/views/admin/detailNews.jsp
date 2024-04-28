<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Website số 1 về bất động sản</title>
<link rel="stylesheet" href="../../../css/admin/listNews.css" type="text/css">
<link rel="stylesheet" href="../../../css/client/index.css" type="text/css">
<link rel="stylesheet" href="../../../css/admin/listCategory.css"
	type="text/css">
<link rel="stylesheet" href="../../../css/admin/headerAdmin.css"
	type="text/css">
<link rel="stylesheet" href="../../../css/admin/listTag.css" type="text/css">
<%@ include file="../../../links/links.jsp"%>
</head>
<body>
	<%@ include file="../../components/headerAdmin.jsp"%>
	<div class='admin active'>
		<%@ include file="../../components/sidebarAdmin.jsp"%>
		<!-- Detail -->
		<div class='detail'>
			<div class='container '>
				<div class='row'>
					<!-- Content -->
					<div class='detail-content col-lg-9'>
						

						<div class='breadcrumb'>
							<a href='listNews.html'>Danh sách các tin</a> <span> / </span> <a href=''>${news.newsId}</a> 
						</div>
						<h3 class='detail-content__title'>${news.title}</h3>
						<p class='detail-content__address'>${news.shortDescription}</p>
						<div class='short-info-container'>
							<p class='detail-content__address'>Ảnh bìa sẽ ở đây</p>
						</div>
						<div class='description-container'>
							<div class='section-title'>Thông tin mô tả</div>
							<div class='description-body'>
								${news.description}
							</div>
						</div>			
					</div>

					<!-- Sidebar -->
					<div class='detail-sidebar col-lg-3'>
						<div class='sidebar-box-contact'>
							<img class='contact-avatar' src={avatar} alt='' />
							<p>Được đăng bởi</p>
							<h5 class='contact-name'>Vu Thi Kim Diep</h5>
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
			</div>
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
	</script>
</body>
</html>

