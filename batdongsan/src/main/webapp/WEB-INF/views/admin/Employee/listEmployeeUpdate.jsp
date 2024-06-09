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
<link rel="stylesheet" href="../../../css/admin/headerAdmin.css?version=61"
	type="text/css">
	<link rel="stylesheet" href="../../../css/admin/listEmployee.css?version=62"
	type="text/css">
<%@ include file="../../../../links/links.jsp"%>
</head>
<body>
	<%@ include file="../../../components/headerAdmin.jsp"%>
	<div class='admin'>
		<%@ include file="../../../components/sidebarAdmin.jsp"%>
		<!-- LIST EMPLOYEE -->
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
		<!-- UPDATE MODEL -->
		<div class='add-modal' style="display: flex;" id="updateModelForm">
			<div class='modal-wrapper'>
				<div class='modal-container'>
					<h1>Chỉnh sửa nhân viên</h1>
					${message}
					<form:form action="${employee.id}.html"
						modelAttribute="employee" method="post">
						<div class='input-container'>
							<div class='form-item'>
								<p>Mã nhân viên</p>
								<div class='input-wrapper'>
									<form:input path="id" readonly="true" />
								</div>
							</div>
						</div>
						<div class='input-container'>
							<div class='form-item'>
								<p>Tên nhân viên</p>
								<div class='input-wrapper'>
									<form:input path="fullname" placeholder='Nhập tên' />	
								</div>
								<form:errors class="errorMessage" path="fullname" element="p"/>
							</div>
							<div class='form-item'>
								<p>Email</p>
								<div class='input-wrapper'>
									<form:input path="email" placeholder='Email' />									
								</div>
								<form:errors class="errorMessage" path="email" element="p"/>
							</div>
						</div>

						<div class='input-container'>
							<div class='form-item'>
								<p>Ngày sinh</p>
								<div class='input-wrapper'>
									<form:input path="birthday" type="date" placeholder='Địa chỉ' />
								</div>
							</div>
							<div class='form-item'>
								<p>Số điện thoại</p>
								<div class='input-wrapper'>
									<form:input path="phoneNumber" placeholder='Số điện thoại' />
								</div>
								<form:errors class="errorMessage" path="phoneNumber" element="p"/>
							</div>
						</div>

						<div class='input-container'>
							<div class='form-item'>
								<p>Địa chỉ</p>
								<div class='input-wrapper'>
									<form:input path="address" placeholder='Địa chỉ' />
								</div>
							</div>
							<div class='form-item'>
								<p>Căn cước công dân</p>
								<div class='input-wrapper'>
									<form:input path="cccd" placeholder='9 hoặc 12 số' />			
								</div>
								<form:errors class="errorMessage" path="cccd" element="p"/>
							</div>
						</div>
						<div class='button-wrapper'>
							<div></div>
							<button class='continue-button'>
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
</body>
</html>