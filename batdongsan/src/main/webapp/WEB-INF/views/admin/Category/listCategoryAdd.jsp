<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Thêm danh mục</title>
<link rel="stylesheet" href="../../css/client/index.css" type="text/css">

<link rel="stylesheet" href="../../css/admin/listCategory.css"
	type="text/css">
<link rel="stylesheet" href="../../css/admin/headerAdmin.css"
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
				<h3>Chỉnh sửa danh mục</h3>
				<button class='add-new-button' id="addCategoryButton">Thêm mới</button>
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
							<th scope='col'>STT</th>
							<th scope='col'>Loại</th>
							<th scope='col'>Tên danh mục</th>
							<th scope='col'>Trạng thái</th>
							<th scope='col'>Thao tác</th>
						</tr>
					</thead>
					<tbody>
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
		</div>
		
		<!-- UPDATEMODEL -->
		<div class='add-modal' style="display: flex;" id="addModelForm">
			<div class='modal-wrapper'>
				<div class='modal-container'>
					<h1>Thêm danh mục</h1>
					<form:form action="addCategory.html"
						modelAttribute="category" method="post">
						<div class='input-container'>
							<div class='form-item'>
								<p>Tên danh mục</p>
								<div class='input-wrapper'>
									<form:input path="name" placeholder='Nhập tên' />
								</div>
								<form:errors class="errorMessage" path="name" element="p"/>
							</div>
							<div class='form-item'>
								<p>Loại danh mục</p>
								<form:select path="type" class='select-wrapper' name='' id=''>
									<option value='Nhà đất bán'>Nhà đất bán</option>
									<option value='Nhà đất cho thuê'>Nhà đất cho thuê</option>
								</form:select>
							</div>
						</div>

						<div class='input-container'>
							<div class='form-item'>
								<p>Trạng thái</p>
								<form:select path="status" class='select-wrapper' name='' id=''>
									<option value='true'>Kích hoạt</option>
									<option value='false'>Ẩn</option>
								</form:select>
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
			<button class='close-btn' id="closeUpdateModelButton" onclick="window.location.href='/batdongsan/admin/update/cancel.html'">
				<i class='fa-solid fa-xmark'></i>
			</button>
		</div>
		<!-- END -->
	
	</div>
	
</body>
</html>