<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@page import="batdongsan.models.CategoryModel"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Website số 1 về bất động sản</title>
<link rel="stylesheet" href="../css/client/index.css" type="text/css">
<link rel="stylesheet" href="../css/admin/headerAdmin.css?version=53"
	type="text/css">
<link rel="stylesheet" href="../css/admin/listCategory.css?version=55"
	type="text/css">
<%@ include file="../../../../links/links.jsp"%>
</head>
<body>
	<%@ include file="../../../components/headerAdmin.jsp"%>
	<div class='admin'>
		<%@ include file="../../../components/sidebarAdmin.jsp"%>
		<!-- ListCategory -->
		<div class='list-category'>
			<div class='header-wrapper'>
				<h3>Quản lý danh mục</h3>
				<a href="listCategory/add.html"><button class='add-new-button'
						id="addCategoryButton">Thêm mới</button></a>
			</div>
			<div class='search-wrapper'>
				<div class='input-container search-input'>
					<i class='fa-solid fa-magnifying-glass'></i> <input type='text'
						id="searchInput" placeholder='Tìm kiếm theo tên'
						value="${search != null ? search : ''}" />
				</div>
				<%
				List<CategoryModel> listOfNews = (List<CategoryModel>) request.getAttribute("categories");
				Integer currentAllPage = (Integer) request.getAttribute("currentAllPage");
				Integer totalAllPages = (Integer) request.getAttribute("totalAllPages");
				Integer totalAllResults = (Integer) request.getAttribute("totalAllResults");
				%>
			</div>

			<div class='table-wrapper'>
				<table class='table table-hover table-striped'>
					<thead>
						<tr>
							<th scope='col'>Mã danh mục</th>
							<th scope='col'>Loại</th>
							<th scope='col'>Tên danh mục</th>
							<th scope='col'>Trạng thái</th>
							<th scope='col'>Thao tác</th>
						</tr>
					</thead>
					<tbody id="categoryTable">
						<c:forEach var="c" items="${categories}">
							<tr>
								<th scope='row'><p>${c.categoryId}</p></th>
								<td><p>${c.type}</p></td>
								<td><p>${c.name}</p></td>
								<td><p>${c.status ? 'Hiển thị' : 'Ẩn'}</p></td>
								<td><a href='listCategory/update/${c.categoryId}.html'
									class="updateModelButton"> <i class='fa-solid fa-pencil'></i>
								</a> <a href='listCategory/delete/${c.categoryId}.html'> <i
										class='fa-solid fa-trash'></i>
								</a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<!-- Phân trang -->
			<div class="pagination">
				<%
				if (currentAllPage > 1) {
				%>
				<a
					href="${pageContext.servletContext.contextPath}/admin/listCategory.html?pageAll=<%=currentAllPage - 1%>">
					<i class="fa-solid fa-chevron-left"></i>
				</a>
				<%
				}
				%>

				<%
				for (int i = 1; i <= totalAllPages; i++) {
				%>
				<a
					href="${pageContext.servletContext.contextPath}/admin/listCategory.html?pageAll=<%=i%>"
					class="<%=i == currentAllPage ? "active" : ""%>"><%=i%></a>
				<%
				}
				%>

				<%
				if (currentAllPage < totalAllPages) {
				%>
				<a
					href="${pageContext.servletContext.contextPath}/admin/listCategory.html?pageAll=<%=currentAllPage + 1%>">
					<i class="fa-solid fa-angle-right"></i>
				</a>
				<%
				}
				%>
			</div>
		</div>
	</div>
	<script type="text/javascript">
	$(document).ready(function() {
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
			let url = "${pageContext.servletContext.contextPath}/admin/listCategory.html";
			url += "?searchInput=" + searchInput.val();
			window.location.href = url;
		}
	})
	</script>


</body>
</html>