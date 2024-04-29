<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Website số 1 về bất động sản</title>
<link rel="stylesheet" href="../css/client/index.css" type="text/css">
<link rel="stylesheet" href="../css/admin/headerAdmin.css" type="text/css">
<link rel="stylesheet" href="../css/admin/listCategory.css?version=50" type="text/css">
<link rel="stylesheet" href="../css/admin/listTag.css" type="text/css">
<%@ include file="../../../links/links.jsp"%>
</head>
<body>
	<%@ include file="../../components/headerAdmin.jsp"%>
	<div class='admin active'>
		<%@ include file="../../components/sidebarAdmin.jsp"%>
		<!-- ListCategory -->
		<div class='list-category'>
			<div class='header-wrapper'>
				<h3>Quản lý danh mục</h3>
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
								<th scope='row'>${c.categoryId}</th>
								<td>${c.type}</td>
								<td>${c.name}</td>
								<td>${c.status ? 'Hiển thị' : 'Ẩn'}</td>
								<td><a href='update/${c.categoryId}.html'
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
		
		<!-- ADDMODAL -->
		<div class='add-modal' style="display: none;" id="addModelForm">
			<div class='modal-wrapper'>
				<div class='modal-container'>
					<h1>Thêm danh mục</h1>
					${message}
					<form:form action="listCategory/add.html" modelAttribute="category"
						method="post">
						<div class='input-container'>
							<div class='form-item'>
								<p>Mã danh mục</p>
								<div class='input-wrapper'>
									<form:input path="categoryId" placeholder="Nhập tên" />
								</div>
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
								<p>Tên danh mục</p>
								<div class='input-wrapper'>
									<form:input path="name" type='text' placeholder='Nhập tên' />
								</div>
							</div>

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
			<button class='close-btn' id="closeAddModelButton">
				<i class='fa-solid fa-xmark'></i>
			</button>
		</div>
		<!-- END -->



	</div>
	<script>
		$(document).ready(function() {
			// Xử lý sự kiện Add Model
			$("#addCategoryButton").click(function() {
				$("#addModelForm").show();
			});

			// Xử lý sự kiện click vào nút đóng modal
			$("#closeAddModelButton").click(function() {
				$("#addModelForm").hide();
			});
			// End Add Model



		});
	</script>
</body>
</html>