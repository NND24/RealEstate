<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
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
				<div class='input-container'>
					<i class='fa-solid fa-magnifying-glass'></i> <input type='text'
						id="searchInput" placeholder='Tìm kiếm theo tên'
						value="${search != null ? search : ''}" />
				</div>
				<div class='filter-container'>
					<form id="filterForm" method="get" action="">
						<select name="filter" id="filter" onchange="this.form.submit()">
							<option value=""
								<c:if test="${filter == null || filter.isEmpty()}">selected</c:if>>Tất
								cả</option>
							<option value="sell"
								<c:if test="${filter == 'sell'}">selected</c:if>>Nhà
								đất bán</option>
							<option value="rent"
								<c:if test="${filter == 'rent'}">selected</c:if>>Nhà
								đất cho thuê</option>
						</select> <input type="hidden" name="search" id="hiddenSearch"
							value="${search != null ? search : ''}" />
					</form>
				</div>
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
			<div class="pagination-container">
				<nav aria-label="Page navigation">
					<ul id="pagination" class="pagination"></ul>
				</nav>
			</div>
		</div>
	</div>
	<script>
		$(document).ready(
						function() {
							var totalPages = $
							{
								totalPages
							}
							;
							var currentPage = $
							{
								currentPage
							}
							;
							var filter = "${filter}"; // Lấy filter hiện tại từ server
							var searchText = "${search != null ? search : ''}"; // Lấy giá trị tìm kiếm hiện tại từ server

							function loadPage(page) {
								$
										.get("listCategory.html", {
											page : page,
											filter : filter,
											search : searchText
										})
										.done(
												function(data) {
													var newContent = $(data)
															.find(
																	'#categoryTable')
															.html();
													$('#categoryTable').html(
															newContent);
													$('#pagination')
															.twbsPagination(
																	'changeTotalPages',
																	totalPages,
																	page);
												})
										.fail(
												function() {
													console
															.error('Error while fetching data from server.');
												});
							}

							$('#pagination').twbsPagination({
								totalPages : totalPages,
								visiblePages : 5,
								startPage : currentPage,
								onPageClick : function(event, page) {
									if (page !== currentPage) {
										currentPage = page;
										loadPage(page);
									}
								},
								first : 'Đầu',
								prev : '<i class="fas fa-angle-left"></i>',
								next : '<i class="fas fa-angle-right"></i>',
								last : 'Cuối'
							});

							$('#searchInput').on('keyup', function() {
								searchText = $(this).val().toLowerCase();
								$('#hiddenSearch').val(searchText); // Cập nhật giá trị tìm kiếm ẩn trong form
								loadPage(1); // Load lại từ trang đầu tiên khi tìm kiếm
							});

							// Initial load
							loadPage(currentPage);
						});
	</script>
</body>
</html>