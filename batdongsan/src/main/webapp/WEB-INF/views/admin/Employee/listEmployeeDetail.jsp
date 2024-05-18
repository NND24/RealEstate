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
<link rel="stylesheet" href="../../../css/admin/listCategory.css"
	type="text/css">
<link rel="stylesheet" href="../../../css/admin/headerAdmin.css"
	type="text/css">
<link rel="stylesheet" href="../../../css/admin/listTag.css"
	type="text/css">
<%@ include file="../../../../links/links.jsp"%>
</head>
<body>
	<%@ include file="../../../components/headerAdmin.jsp"%>
	<div class='admin active'>
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
						placeholder='Tìm kiếm...' />
				</div>
				<div class='filter-container'>
					<select name='' id=''>
						<option value=''>Nhà đất bán</option>
						<option value=''>Nhà đất cho thuê</option>
					</select>
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
								<th scope='row'>${e.id}</th>
								<td>${e.fullname}</td>
								<td class="status" data-status='${e.status}'>${e.status ? 'Còn làm' : 'Đã nghỉ'}</td>
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
		<!-- DETAIL MODEL -->
		<div class='add-modal' style="display: flex;" id="updateModelForm">
			<div class='modal-wrapper'>
				<div class='modal-container'>
					<h1>Chi tiết nhân viên</h1>
					${message}
					<form:form action="" modelAttribute="employee" method="post">
						<div class='input-container'>
							<div class='form-item'>
								<p>Mã nhân viên</p>
								<div class='input-wrapper'>
									<form:input path="id" readonly="true" />
								</div>
							</div>

							<div class='form-item'>
								<p>Trạng thái</p>
								<div class='input-wrapper'>
									<form:input path="status" readonly="true" value="${status ? 'Đang làm việc' : 'Đã nghỉ'}" />
								</div>
							</div>

						</div>
						<div class='input-container'>
							<div class='form-item'>
								<p>Tên nhân viên</p>
								<div class='input-wrapper'>
									<form:input path="fullname" readonly="true" />
								</div>
							</div>
							<div class='form-item'>
								<p>Email</p>
								<div class='input-wrapper'>
									<form:input path="email" readonly="true" />
								</div>
							</div>
						</div>

						<div class='input-container'>
							<div class='form-item'>
								<p>Ngày sinh</p>
								<div class='input-wrapper'>
									<form:input path="birthday" type="date" readonly="true" />
								</div>
							</div>
							<div class='form-item'>
								<p>Số điện thoại</p>
								<div class='input-wrapper'>
									<form:input path="phoneNumber" readonly="true" />
								</div>
							</div>
						</div>

						<div class='input-container'>
							<div class='form-item'>
								<p>Địa chỉ</p>
								<div class='input-wrapper'>
									<form:input path="address" readonly="true" />
								</div>
							</div>
							<div class='form-item'>
								<p>Căn cước</p>
								<div class='input-wrapper'>
									<form:input path="cccd" readonly="true" />
								</div>
							</div>
						</div>

						<div class='input-container'>
							<div class='form-item'>
								<p>Ngày vào làm</p>
								<div class='input-wrapper'>
									<form:input path="createDate" readonly="true" />
								</div>
							</div>
							<c:choose>
								<c:when test="${employee.deleteDate != null}">
									<div class='form-item'>
										<p>Ngày nghỉ làm</p>
										<div class='input-wrapper'>
											<form:input path="deleteDate" readonly="true"/>
										</div>
									</div>
								</c:when>
							</c:choose>
						</div>

						<div class='input-container'>
							<div class='form-item'>
								<p>Chức vụ</p>
								<div class='input-wrapper'>
									 <input type="text" value="${roleName}" readonly="true" />
								</div>
							</div>
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