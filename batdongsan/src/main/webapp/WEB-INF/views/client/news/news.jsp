<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Website số 1 về bất động sản</title>
<link rel="stylesheet" href="css/client/index.css" type="text/css">
<link rel="stylesheet" href="css/client/header.css?version=52"
	type="text/css">
<link rel="stylesheet" href="css/client/news.css?version=51"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath}/css/client/footer.css"
	type="text/css">
<%@ include file="../../../../links/links.jsp"%>
</head>
<body>
	<%@ include file="../../../components/headerNews.jsp"%>
	<div class='news'>
		<div class='searchBar-container'>
			<div class='container'>
				<div class='row'>
					<div class='col-lg-10 col-md-10 col-sm-10 col-10'>
						<div class='searchBar-breadcrumb-wrapper'>
							<a href='${pageContext.servletContext.contextPath}/trang-chu.html'> <i class='fa-solid fa-house-chimney'></i>
							</a> <i class='fa-solid fa-angle-right'></i> <a href=''>Tin tức</a>
						</div>
					</div>
					<div class='col-lg-2 col-md-2 col-sm-2 col-2'>
						<div class='searchBar-wrapper'>
							<i class='fa-solid fa-magnifying-glass'></i> <input type='text'
								placeholder='Tìm kiếm...' />
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class='container '>
			<div class='justify-content-md-center row'>
				<div class='news-header-wrapper col-lg-8 col-md-8 col-sm-12'>
					<h1 class='news-heading'>Tin tức bất động sản mới nhất</h1>
					<p class='news-subheading'>Thông tin mới, đầy đủ, hấp dẫn về
						thị trường bất động sản Việt Nam thông qua dữ liệu lớn về giá,
						giao dịch, nguồn cung - cầu và khảo sát thực tế của đội ngũ phóng
						viên, biên tập của ...</p>
				</div>
			</div>

			<div class='row'>
				<div class='col-lg-8 col-md-12 col-sm-12'>
					<a href="${pageContext.servletContext.contextPath}/tin-tuc/${firstFourNews[0].newsId}.html">
						<div class='main-article'>
							<img
								src='${pageContext.servletContext.contextPath}/images/News/${firstFourNews[0].thumbnail}'
								alt='' />
							<div class='main-article__textOverlay'>
								<span class='article-date'>${firstFourNews[0].dateUploaded} •
									Tin tức</span> <div>
									<h3 class='article-title'>${firstFourNews[0].title}</h3>
								</div>
								<p class='article-description'>${firstFourNews[0].shortDescription}</p>
							</div>
							<div class='main-article__backgroundOverlay'></div>
						</div>
					</a>
				</div>

				<div class='col-lg-4 col-md-12 col-sm-12'>
					<c:forEach var="news" items="${firstFourNews}" begin="1" end="3">
						<div class='article-right-content'>
							<span class='article-date'>${news.dateUploaded}</span> <a
								href="${pageContext.servletContext.contextPath}/tin-tuc/${news.newsId}.html"
								class='card-info__title'>${news.title} </a>
						</div>
					</c:forEach>
				</div>
			</div>

			<div class='row'>
				<div class='news-content col-xl-8 col-lg-8 col-md-12 col-12'>
					<h2 class='article-list-heading'>Các tin khác</h2>
					<div id="additional-news-wrapper" class="additional-news-wrapper">
						<c:forEach var="news" items="${initialNews}">
							<a href="${pageContext.servletContext.contextPath}/tin-tuc/${news.newsId}.html" class='news-card'>
								<div class='card-img-container'>
									<img
										src='${pageContext.servletContext.contextPath}/images/News/${news.thumbnail}'
										alt='' /> <span class='card-highlight'>Tin tức</span>
								</div>
								<div class='card-info-container'>
									<span class='article-date'>${news.dateUploaded}</span> <div
										 class='card-info__title'>${news.title}
									</div>
									<div class='card-description'>${news.shortDescription}</div>
								</div>
							</a>
						</c:forEach>
					</div>
					<div class="load-more">
						<a href="tin-tuc/danh-sach.html"><button id="load-more-btn"
								class="btn btn-primary">Xem thêm tin</button></a>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="../../../components/footer.jsp"%>
	
	<script>
		$(document)
				.ready(
						function() {
							let searchInput = $(".searchBar-wrapper input");
							let searchInputButton = $(".searchBar-wrapper .fa-magnifying-glass");

							$(searchInputButton).on("click", handleSearch);
							$(searchInput).on("keyup", function(event) {
								if (event.which === 13) { // Enter key code
									event.preventDefault(); // Prevent default form submission if necessary
									handleSearch();
								}
							});

							function handleSearch() {
								let url = "${pageContext.servletContext.contextPath}/tin-tuc/danh-sach.html";
								url += "?searchInput=" + searchInput.val();
								window.location.href = url;
							}
						})
	</script>
</body>
</html>