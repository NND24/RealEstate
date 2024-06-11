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
	href="${pageContext.servletContext.contextPath}/css/client/moreNews.css?version=52"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath}/css/client/footer.css"
	type="text/css">
<%@ include file="../../../../links/links.jsp"%>
</head>
<body>
	<%@ include file="../../../components/headerNews.jsp"%>
	<!-- ListNews -->
	<div class='more-list-news'>
		<div class='head-container'>
			<h1>Danh sách tin tức</h1>
		</div>
		<div class='content-container'>
			<div class='filter-wrapper'>
				<div class='search-input'>
					<input type='text' id="searchInput"
						placeholder='Tìm theo mã tin, tiêu đề' />
				</div>
			</div>
			<%
			List<NewsModel> listOfNews = (List<NewsModel>) request.getAttribute("allNews");
			Integer currentAllPage = (Integer) request.getAttribute("currentAllPage");
			Integer totalAllPages = (Integer) request.getAttribute("totalAllPages");
			Integer totalAllResults = (Integer) request.getAttribute("totalAllResults");
			%>
			<div class='post-container'>
				<div class='tab-content' id="news-container">
					<c:forEach var="n" items="${listOfNews}">
						<div class='more-post-card'>
							<div>
								<div class="img-wrapper">
									<img
										src="${pageContext.servletContext.contextPath}/images/News/${n.thumbnail}"
										alt="" />
								</div>
								<div class='post-content-container'>
									<div class='detail-container'>
										<div class='detail-item'>
											<span class='primary'>Tên người viết:
												${n.employee.fullname}</span>
											<div class='secondary'></div>
										</div>
										<div class='detail-item'>
											<span class='primary'>${n.dateUploaded}</span>
											<div class='secondary'></div>
										</div>

									</div>
									<div>
										<a href="${pageContext.servletContext.contextPath}/tin-tuc/${n.newsId}.html"><h4 class='header'>${n.title}</h4></a>
										<div class='location'>
											<span>${n.shortDescription}</span>
										</div>
									</div>
								</div>
							</div>
							<div>
								<div class='blank-container'></div>
							</div>
						</div>
						<!-- End -->
					</c:forEach>

				</div>
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
	<input type="hidden" id="totalPages" value="${totalPages}" />
	<input type="hidden" id="currentPage" value="${currentPage}" />
	<%@ include file="../../../components/footer.jsp"%>
	<script>
		$(document)
				.ready(
						function() {
							let searchInput = $(".search-input input");
							let searchInputButton = $(".search-input .fa-magnifying-glass");

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