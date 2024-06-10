<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@page import="batdongsan.models.EmployeeModel"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Website số 1 về bất động sản</title>
<link rel="stylesheet" href="../css/client/index.css" type="text/css">
<link rel="stylesheet" href="../css/admin/listEmployee.css?version=60"
	type="text/css">
<link rel="stylesheet" href="../css/admin/headerAdmin.css"
	type="text/css">
<%@ include file="../../../../links/links.jsp"%>


</head>
<body>
	<%@ include file="../../../components/headerAdmin.jsp"%>
	<div class='admin'>
		<%@ include file="../../../components/sidebarAdmin.jsp"%>
		<!-- ListEmployee -->
		<div class='list-category'>
			<div class='header-wrapper'>
				<h3>Quản lý nhân viên</h3>
				<a href="listEmployee/add.html"><button class='add-new-button'
						id="addEmployeeButton">Thêm mới</button></a>
			</div>
			<div class='search-wrapper'>
				<div class='input-container search-input'>
					<i class='fa-solid fa-magnifying-glass'></i> <input type='text'
						id="searchInput" placeholder='Tìm kiếm theo tên'
						value="${search != null ? search : ''}" />
				</div>
			</div>
			<%
				List<EmployeeModel> employees = (List<EmployeeModel>) request.getAttribute("employees");
				Integer currentAllPage = (Integer) request.getAttribute("currentAllPage");
				Integer totalAllPages = (Integer) request.getAttribute("totalAllPages");
				Integer totalAllResults = (Integer) request.getAttribute("totalAllResults");
				%>
			<div class='table-wrapper'>
				<table class='table table-hover table-striped'>
					<thead>
						<tr>
							<th scope='col'>Mã nhân viên</th>
							<th scope='col'>Họ tên</th>
							<th scope='col'>Trạng thái</th>
							<th scope='col'>Chi tiết</th>
							<th scope='col'>Phân quyền</th>
							<th scope='col'>Thao tác</th>
						</tr>
					</thead>
					<tbody id="employeeTable">
						<c:forEach var="e" items="${employees}">
							<tr>
								<th scope='row'><p>${e.id}</p></th>
								<td><p>${e.fullname}</p></td>
								<td class="status" data-status='${e.status}'><p>${e.status ? 'Còn làm' : 'Đã nghỉ'}</p></td>
								<td><a href='listEmployee/detail/${e.id}.html'>
										<p class="detail-emp">Xem chi tiết</p>
								</a></td>
								<td><a href="listEmployee/authorization/${e.id}.html"
									class="authorization-link">
										<button class="authorization-button">Phân quyền</button>
								</a></td>
								<td><a href='listEmployee/update/${e.id}.html'
									class="updateModelButton"> <i class='fa-solid fa-pencil'></i>
								</a> <a href='listEmployee/delete/${e.id}.html'> <i
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
					href="${pageContext.servletContext.contextPath}/admin/listEmployee.html?pageAll=<%=currentAllPage - 1%>">
					<i class="fa-solid fa-chevron-left"></i>
				</a>
				<%
				}
				%>

				<%
				for (int i = 1; i <= totalAllPages; i++) {
				%>
				<a
					href="${pageContext.servletContext.contextPath}/admin/listEmployee.html?pageAll=<%=i%>"
					class="<%=i == currentAllPage ? "active" : ""%>"><%=i%></a>
				<%
				}
				%>

				<%
				if (currentAllPage < totalAllPages) {
				%>
				<a
					href="${pageContext.servletContext.contextPath}/admin/listEmployee.html?pageAll=<%=currentAllPage + 1%>">
					<i class="fa-solid fa-angle-right"></i>
				</a>
				<%
				}
				%>
			</div>
		</div>
		<script>
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
				let url = "${pageContext.servletContext.contextPath}/admin/listEmployee.html";
				url += "?searchInput=" + searchInput.val();
				window.location.href = url;
			}
		})
		</script>
</body>
</html>