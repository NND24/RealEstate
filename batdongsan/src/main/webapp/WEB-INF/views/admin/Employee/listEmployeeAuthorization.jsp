<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Website số 1 về bất động sản</title>
<link rel="stylesheet" href="../../../css/client/index.css"
	type="text/css">

<link rel="stylesheet" href="../../../css/admin/listEmployee.css?version=57"
	type="text/css">
<link rel="stylesheet" href="../../../css/admin/headerAdmin.css?version=57"
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
				<h3>Quản lý nhân viên</h3>
				<button class='add-new-button' id="addEmployeeButton">Thêm
					mới</button>
			</div>
			<div class='search-wrapper'>
				<div class='input-container'>
					<i class='fa-solid fa-magnifying-glass'></i> <input type='text'
						placeholder='Mã hoặc tên nhân viên ...' />
				</div>
			</div>
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
					<tbody>
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
		</div>
		<!-- AUTHO MODEL -->
		<div class='add-modal' style="display: flex;" id="updateModelForm">
			<div class='modal-wrapper'>
				<div class='modal-container'>
					<h1>Phân quyền</h1>
					${message}
					<form:form action="confirm.html"
						modelAttribute="permissions" method="post" id="authorizationForm">
						<table class='table table-hover table-striped'>
							<thead>
								<tr>
									<th scope='col'>Mã quyền</th>
									<th scope='col'>Tên quyền</th>
									<th scope='col'>Mô tả</th>
									<th scope='col'>Phân quyền</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="role" items="${roles}">
									<tr>
										<th scope='row'>${role.roleId}</th>
										<td>${role.roleName}</td>
										<td>${role.description}</td>	
										<td><c:forEach var="permission"
												items="${rolePermissions[role]}">
												<c:choose>
													<c:when test="${permission.status}">
														<form:checkbox path="permissionId"
															value="${permission.permissionId}" checked="true" />
													</c:when>
													<c:otherwise>
														<form:checkbox path="permissionId"
															value="${permission.permissionId}" />
													</c:otherwise>
												</c:choose>
											</c:forEach></td>

									</tr>
								</c:forEach>
							</tbody>
						</table>
						<input type="hidden" id="permissionIds" name="permissionIds" value="" />
						<input type="hidden" id="unselectedPermissionIds" name="unselectedPermissionIds" value="" />
						<div class='button-wrapper'>
							<div></div>
							<button class='continue-button' id="confirmButton">
								<span>Xác nhận</span>
							</button>
						</div>
					</form:form>

				</div>
			</div>
			<button class='close-btn' id="closeUpdateModelButton"
				onclick="window.location.href='/batdongsan/admin/updateEmployee/cancel.html'">
				<i class='fa-solid fa-xmark'></i>
			</button>
		</div>
		<!-- END -->
	</div>
	<script>
    $(document).ready(function() {
        $('#confirmButton').click(function() {
            var selectedPermissions = [];
            var unselectedPermissions = [];
            // Lặp qua tất cả các checkbox và lấy giá trị của những cái được chọn
            $('input[type="checkbox"][name="permissionId"]:checked').each(function() {
                selectedPermissions.push($(this).val());
            });
            
        	// Lặp qua tất cả các checkbox và lấy giá trị của những cái không được chọn
            $('input[type="checkbox"][name="permissionId"]:not(:checked)').each(function() {
                unselectedPermissions.push($(this).val());
            });

            // Cập nhật giá trị của trường ẩn permissionIds và unselectedPermissionIds
            $('#permissionIds').val(selectedPermissions.join(","));
            $('#unselectedPermissionIds').val(unselectedPermissions.join(","));

            // Submit form
            $('#authorizationForm').submit();
        });
    });
</script>
</body>
</html>