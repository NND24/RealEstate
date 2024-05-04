<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Website số 1 về bất động sản</title>
<link rel="stylesheet" href="../../../css/admin/listNews.css"
	type="text/css">
<link rel="stylesheet" href="../../../css/client/index.css"
	type="text/css">
<link rel="stylesheet" href="../../../css/admin/listCategory.css"
	type="text/css">
<link rel="stylesheet" href="../../../css/admin/headerAdmin.css"
	type="text/css">
<link rel="stylesheet" href="../../../css/admin/listTag.css"
	type="text/css">
<link rel="stylesheet" href="../../../css/admin/detail.css?version=50"
	type="text/css">
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
							<a href='listNews.html'> <i class="fa-solid fa-house"></i> </a> <span> > </span> <a href=''>${news.title}</a> 
						</div>
						<h3 class='detail-content__title'>${news.title}</h3>
						
						<div class='short-info-writter-container'>
							<div class="writter-info">
								<span>Được đăng bởi </span>
								<p class="writter-name">${news.employee.fullname}</p>
								<br> 
								<span>Đăng vào ngày</span>
								<p class="writter-info">${news.dateUploaded}</p>
							</div>
						</div>
						<div class="short-description-container">
							<strong class='detail-content__address'>${news.shortDescription}</strong>
						</div>
						
						<div class='short-info-container'>
							<p class='detail-content__address'>Ảnh bìa sẽ ở đây</p>
							<img src="${pageContext.servletContext.contextPath}/images/News/${news.thumbnail}" alt=""/>
						</div>
						<div class='description-container'>
							<div class='description-body'>${news.description}</div>
							<p class="writter-name">${news.employee.fullname}</p>
						</div>
					</div>

					<!-- Sidebar -->

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

