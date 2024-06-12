<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@page import="batdongsan.models.NewsModel"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link rel="icon" type="image/png"
	href="${pageContext.servletContext.contextPath}/images/favicon.png" />
<title>Quản lý tin tức</title>
<link rel="stylesheet" href="../css/admin/listNews.css?version=59"
	type="text/css">
<link rel="stylesheet" href="../css/client/index.css" type="text/css">
<link rel="stylesheet" href="../css/admin/headerAdmin.css"
	type="text/css">
<%@ include file="../../../../links/links.jsp"%>
</head>
<body>
	<%@ include file="../../../components/headerAdmin.jsp"%>
	<div class='admin'>
		<%@ include file="../../../components/sidebarAdmin.jsp"%>

		<!-- ListNews -->
		<div class='admin-list-news'>
			<div class='head-container'>
				<h1>Danh sách tin tức</h1>
				<a href="listNews/add.html"><button class='add-new-button'
						id="addNewsButton">Thêm mới</button></a>
			</div>
			<div class='content-container'>
				<div class='filter-wrapper'>
					<div class='search-input'>
						<input type='text' id="searchInput"
							placeholder='Tìm theo mã tin, tiêu đề' /> <i
							class='fa-solid fa-magnifying-glass'></i>
					</div>
					<%
					List<NewsModel> listOfNews = (List<NewsModel>) request.getAttribute("listOfNews");
					Integer currentAllPage = (Integer) request.getAttribute("currentAllPage");
					Integer totalAllPages = (Integer) request.getAttribute("totalAllPages");
					Integer totalAllResults = (Integer) request.getAttribute("totalAllResults");
					%>
					<div class='dropdown'>
						<button class='btn dropdown-toggle' type='button'
							data-toggle='dropdown'>
							<i class="fa-solid fa-tags"></i> <span id="filter-display">
								<c:choose>
									<c:when test="${filter == null}">Tất cả</c:when>
									<c:when test="${filter == true}">Đã duyệt</c:when>
									<c:when test="${filter == false}">Đã ẩn</c:when>
								</c:choose>
							</span> <i class='fa-solid fa-angle-down'></i>
						</button>
						<ul class='dropdown-menu'>
							<li><a href='listNews.html?filter='>Tất cả</a></li>
							<li><a href='listNews.html?filter=true'>Đã duyệt</a></li>
							<li><a href='listNews.html?filter=false'>Đã ẩn</a></li>
						</ul>
					</div>
				</div>
				<div class='post-container'>
					<div class='tab-content' id="news-container">
						<c:forEach var="n" items="${listOfNews}">
							<div class='admin-post-card'>
								<div>
									<div class="img-wrapper">
										<img
											src="${pageContext.servletContext.contextPath}/images/News/${n.thumbnail}"
											alt="" />
									</div>
									<div class='post-content-container'>
										<div>
											<h4 class='title'>${n.title}</h4>
											<div class='location'>
												<span>${n.shortDescription}</span>
											</div>
										</div>
										<div class='detail-container'>
											<div class='detail-item'>
												<span class='primary'>Trạng thái</span>
												<div class='status' data-status='${n.status}'>${n.status ? 'Đang hiển thị' : 'Ẩn'}</div>
											</div>
											<div class='detail-item'>
												<span class='primary'>Mã tin</span>
												<div class='secondary'>${n.newsId}</div>
											</div>
											<div class='detail-item'>
												<span class='primary'>Ngày đăng</span>
												<div class='secondary'>${n.dateUploaded}</div>
											</div>
											<div class='detail-item'>
												<span class='primary'>Mã viết bài</span>
												<div class='secondary'>${n.employee.id}</div>
											</div>
											<div class='detail-item'>
												<span class='primary'>Tên người viết</span>
												<div class='secondary'>${n.employee.fullname}</div>
											</div>
										</div>
									</div>
								</div>
								<div>
									<div class='blank-container'></div>
									<div class='button-container'>
										<a href='listNews/approve/${n.newsId}.html'
											class='button-item'> <i class='fa-regular fa-flag'></i> <span>Duyệt
												tin</span>
										</a> <a href="listNews/detailNews/${n.newsId}.html"
											class='button-item'> <i class="fa-solid fa-circle-info"></i>
											<span>Chi tiết</span>

										</a> <a href='listNews/hide/${n.newsId}.html' class='button-item'>
											<i class="fa-regular fa-eye-slash"></i> <span>Ẩn tin</span>
										</a> <a href='listNews/delete/${n.newsId}.html'
											class='button-item'> <i class="fa-regular fa-trash-can"></i> <span>Xóa
												tin</span>
										</a> <a href='listNews/update/${n.newsId}.html'
											class='button-item'> <i class='fa-solid fa-pencil'></i> <span>Sửa
												tin</span>

										</a>
									</div>
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
						href="${pageContext.servletContext.contextPath}/admin/listNews.html?pageAll=<%=currentAllPage - 1%>">
						<i class="fa-solid fa-chevron-left"></i>
					</a>
					<%
					}
					%>

					<%
					for (int i = 1; i <= totalAllPages; i++) {
					%>
					<a
						href="${pageContext.servletContext.contextPath}/admin/listNews.html?pageAll=<%=i%>"
						class="<%=i == currentAllPage ? "active" : ""%>"><%=i%></a>
					<%
					}
					%>

					<%
					if (currentAllPage < totalAllPages) {
					%>
					<a
						href="${pageContext.servletContext.contextPath}/admin/listNews.html?pageAll=<%=currentAllPage + 1%>">
						<i class="fa-solid fa-angle-right"></i>
					</a>
					<%
					}
					%>
				</div>
			</div>
		</div>


	</div>
	<script type="text/javascript">
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
								let url = "${pageContext.servletContext.contextPath}/admin/listNews.html";
								url += "?searchInput=" + searchInput.val();
								window.location.href = url;
							}
						})
	</script>
</body>
</html>