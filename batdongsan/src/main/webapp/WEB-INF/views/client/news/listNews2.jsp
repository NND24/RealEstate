<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@page import="batdongsan.models.NewsModel"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Website số 1 về bất động sản</title>
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath}/css/client/index.css"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath}/css/client/header.css?version=52"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath}/css/client/news.css?version=52"
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
							<a
								href='${pageContext.servletContext.contextPath}/trang-chu.html'>
								<i class='fa-solid fa-house-chimney'></i>
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
		<%
		List<NewsModel> listOfNews = (List<NewsModel>) request.getAttribute("allNews");
		Integer currentAllPage = (Integer) request.getAttribute("currentAllPage");
		Integer totalAllPages = (Integer) request.getAttribute("totalAllPages");
		Integer totalAllResults = (Integer) request.getAttribute("totalAllResults");
		%>
		<div class='container '>
			<div class='row'>
				<div class='news-content col-12'>
					<div id="additional-news-wrapper" class="additional-news-wrapper">
						<c:forEach var="news" items="${listOfNews}">
							<a
								href="${pageContext.servletContext.contextPath}/tin-tuc/${news.newsId}.html"
								class='news-card'>
								<div class='card-img-container'>
									<img
										src='${pageContext.servletContext.contextPath}/images/News/${news.thumbnail}'
										alt='' /> <span class='card-highlight'>Tin tức</span>
								</div>
								<div class='card-info-container'>
									<span class='article-date'>${news.dateUploaded}</span>
									<div class='card-info__title'>${news.title}</div>
									<div class='card-description'>${news.shortDescription}</div>
								</div>
							</a>
						</c:forEach>
					</div>
					<!-- Phân trang -->
					<div class="pagination">
						<%
						if (currentAllPage > 1) {
						%>
						<a
							href="${pageContext.servletContext.contextPath}/tin-tuc/danh-sach.html?pageAll=<%=currentAllPage - 1%>">
							<i class="fa-solid fa-chevron-left"></i>
						</a>
						<%
						}
						%>

						<%
						for (int i = 1; i <= totalAllPages; i++) {
						%>
						<a
							href="${pageContext.servletContext.contextPath}/tin-tuc/danh-sach.html?pageAll=<%=i%>"
							class="<%=i == currentAllPage ? "active" : ""%>"><%=i%></a>
						<%
						}
						%>

						<%
						if (currentAllPage < totalAllPages) {
						%>
						<a
							href="${pageContext.servletContext.contextPath}/tin-tuc/danh-sach.html?pageAll=<%=currentAllPage + 1%>">
							<i class="fa-solid fa-angle-right"></i>
						</a>
						<%
						}
						%>
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