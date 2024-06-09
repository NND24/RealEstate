<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
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
				<div class='input-container'>
					<i class='fa-solid fa-magnifying-glass'></i> <input type='text' id="searchInput"
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
			<div class="pagination-container">
				<nav aria-label="Page navigation">
					<ul id="pagination" class="pagination"></ul>
				</nav>
			</div>
			<!-- ADDMODAL -->
			<div class='add-modal' style="display: none;" id="addModelForm">
				<div class='modal-wrapper'>
					<div class='modal-container'>
						<h1>Thêm nhân viên</h1>
						${message}
						<form:form action="listEmployee/addEmployee.html"
							modelAttribute="employee" method="post" id="employeeForm">
							<div class='input-container'>
								<div class='form-item'>
									<p>Tên nhân viên</p>
									<div class='input-wrapper'>
										<form:input path="fullname" placeholder='Nhập tên' />
										<form:errors class="errorMessage errorCtrlMessage"
											path="fullname" />
									</div>
								</div>
								<div class='form-item'>
									<p>Email</p>
									<div class='input-wrapper'>
										<form:input path="email" placeholder='Email' />
										<form:errors class="errorMessage errorCtrlMessage"
											path="email" />
									</div>
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
										<form:errors class="errorMessage errorCtrlMessage"
											path="phoneNumber" />
									</div>
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
										<form:errors class="errorMessage errorCtrlMessage" path="cccd" />
									</div>
								</div>
							</div>
							<div class='button-wrapper'>
								<div></div>
								<button class='continue-button' id='submitButton'>
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
		$(document).ready(function () {
		    var totalPages = ${totalPages};
		    var currentPage = ${currentPage};

		    function initPagination() {
		        $('#pagination').twbsPagination({
		            totalPages: totalPages,
		            visiblePages: 5,
		            startPage: currentPage,
		            onPageClick: function (event, page) {
		                console.info('Page ' + page + ' clicked.');
		                $.get("listEmployee.html", { page: page })
		                .done(function(data) {
		                    $('#employeeTable').html($(data).find('#employeeTable').html());
		                    currentPage = page;
		                })
		                .fail(function() {
		                    console.error('Error while fetching data from server.');
		                });
		            },
		            first: 'Đầu',
		            prev: '<i class="fas fa-angle-left"></i>',
		            next: '<i class="fas fa-angle-right"></i>',
		            last: 'Cuối'
		        });
		    }

		    // Initialize pagination
		    initPagination();
		    
		    $('#searchInput').on('keyup', function () {
		        var searchText = $(this).val().toLowerCase(); // Lấy giá trị của ô input và chuyển đổi thành chữ thường
		        $('#employeeTable tr').each(function () {
		        	var employeeId = $(this).find('th').text().trim().toLowerCase(); // Lấy mã nhân viên từ cột đầu tiên trong dòng
		        	console.log("Employee ID:", employeeId); 
		        	var employeeName = $(this).find('td:eq(0)').text().trim().toLowerCase();
		            console.log("Employee Name:", employeeName); 
		     
		            if (employeeId.includes(searchText) || employeeName.includes(searchText)) {
		                $(this).show(); // Hiện nhân viên nếu tìm thấy kết quả
		            } else {
		                $(this).hide(); // Ẩn nhân viên nếu không tìm thấy kết quả
		            }
		        });
		    });
		});
		</script>
</body>
</html>