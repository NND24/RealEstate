<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@page import="batdongsan.models.UsersModel"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Website số 1 về bất động sản</title>
<link rel="stylesheet" href="../css/client/index.css" type="text/css">
<link rel="stylesheet" href="../css/admin/listUser.css?version=70"
	type="text/css">
<link rel="stylesheet" href="../css/admin/detailUser.css?version=62"
	type="text/css">
<link rel="stylesheet" href="../css/admin/headerAdmin.css"
	type="text/css">
<%@ include file="../../../../links/links.jsp"%>


</head>
<body>
	<%@ include file="../../../components/headerAdmin.jsp"%>
	<div class='admin'>
		<%@ include file="../../../components/sidebarAdmin.jsp"%>
		<!-- List User -->
		<div class='list-category'>
			<div class='header-wrapper'>
				<h3>Quản lý người bán</h3>

			</div>
			<div class='search-wrapper'>
				<div class='input-container search-input'>
					<i class='fa-solid fa-magnifying-glass'></i> <input type='text'
						id="searchInput" placeholder='Tìm kiếm theo tên'
						value="${search != null ? search : ''}" />
				</div>
			</div>
			<%
			List<UsersModel> listUsers = (List<UsersModel>) request.getAttribute("listUsers");
			Integer currentAllPage = (Integer) request.getAttribute("currentAllPage");
			Integer totalAllPages = (Integer) request.getAttribute("totalAllPages");
			Integer totalAllResults = (Integer) request.getAttribute("totalAllResults");
			%>
			<div class='table-wrapper'>
				<table class='table table-hover table-striped'>
					<thead>
						<tr>
							<th scope='col'>Mã User</th>
							<th scope='col'>Họ tên</th>
							<th scope='col'>SĐT</th>
							<th scope='col'>Trạng thái</th>
							<th scope='col'>Xem chi tiết</th>
							<th scope='col'>Thao tác</th>
						</tr>
					</thead>
					<tbody id="userTable">
						<c:forEach var="u" items="${listUsers}">
							<tr>
								<th scope='row'><p>${u.userId}</p></th>
								<td class="user-name"><img
									src="${pageContext.servletContext.contextPath}/images/${u.avatar}"
									alt="" class="user-avatar" />
									<p>${u.name}</p></td>
								<td><p>${u.phonenumber}</p></td>
								<td class="status" data-status='${u.status}'><p>${u.status ? 'Hoạt động' : 'Đã khóa'}</p></td>
								<td><a href='listUser/detail/${u.userId}.html'>
										<p class="detail-emp">Xem chi tiết</p>
								</a></td>
								<td><a href='listUser/change-status/${u.userId}.html' onclick="return confirmDelete();">
										<i
										class='${u.status ? "fa-solid fa-lock-open" : "fa-solid fa-lock"}'></i>
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
					href="${pageContext.servletContext.contextPath}/admin/listUser.html?pageAll=<%=currentAllPage - 1%>">
					<i class="fa-solid fa-chevron-left"></i>
				</a>
				<%
				}
				%>

				<%
				for (int i = 1; i <= totalAllPages; i++) {
				%>
				<a
					href="${pageContext.servletContext.contextPath}/admin/listUser.html?pageAll=<%=i%>"
					class="<%=i == currentAllPage ? "active" : ""%>"><%=i%></a>
				<%
				}
				%>

				<%
				if (currentAllPage < totalAllPages) {
				%>
				<a
					href="${pageContext.servletContext.contextPath}/admin/listUser.html?pageAll=<%=currentAllPage + 1%>">
					<i class="fa-solid fa-angle-right"></i>
				</a>
				<%
				}
				%>
			</div>
		</div>
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
									let url = "${pageContext.servletContext.contextPath}/admin/listUser.html";
									url += "?searchInput=" + searchInput.val();
									window.location.href = url;
								}
							})
		</script>
</body>
</html>