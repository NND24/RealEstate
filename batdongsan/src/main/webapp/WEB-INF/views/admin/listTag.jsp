<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Website số 1 về bất động sản</title>
<link rel="stylesheet" href="css/admin/headerAdmin.css" type="text/css">
<link rel="stylesheet" href="css/admin/listTag.css" type="text/css">
<%@ include file="../../../links/links.jsp"%>
</head>
<body>
	<%@ include file="../../components/headerAdmin.jsp"%>
	<div class='admin active'>
		<div class='sidebar '>
			<div class='open-close-button'>
				<i class='fa-solid fa-chevron-left'></i>
			</div>
			<div class='sidebar-wrapper'>
				<div class='panel-group'>
					<div class='panel panel-default'>
						<div class='panel-heading'>
							<h4 class='panel-title'>
								<a data-toggle='collapse' href='#collapse1'>
									<div>
										<i class='fa-solid fa-list'></i> <span> Quản lý tin
											đăng</span>
									</div> <i class='fa-solid fa-angle-down'></i>
								</a>
							</h4>
						</div>
						<div id='collapse1' class='panel-collapse collapse'>
							<ul class='list-group'>
								<li class='list-group-item'>Đăng mới</li>
								<li class='list-group-item'>Danh sách tin</li>
								<li class='list-group-item'>Tin nháp</li>
							</ul>
						</div>
					</div>
				</div>

				<div class='panel-group'>
					<div class='panel panel-default'>
						<div class='panel-heading'>
							<h4 class='panel-title'>
								<a data-toggle='collapse' href='#collapse2'>
									<div>
										<i class='fa-solid fa-coins'></i> <span> Quản lý tài
											chính</span>
									</div> <i class='fa-solid fa-angle-down'></i>
								</a>
							</h4>
						</div>
						<div id='collapse2' class='panel-collapse collapse'>
							<ul class='list-group'>
								<li class='list-group-item'>Thông tin số dư</li>
								<li class='list-group-item'>Lịch sử giao dịch</li>
								<li class='list-group-item'>Nạp tiền vào tài khoản</li>
							</ul>
						</div>
					</div>
				</div>

				<div class='panel-group'>
					<div class='panel panel-default'>
						<div class='panel-heading'>
							<h4 class='panel-title'>
								<a data-toggle='collapse' href='#collapse3'>
									<div>
										<i class='fa-solid fa-paperclip'></i> <span>Báo giá &
											hướng dẫn</span>
									</div> <i class='fa-solid fa-angle-down'></i>
								</a>
							</h4>
						</div>
						<div id='collapse3' class='panel-collapse collapse'>
							<ul class='list-group'>
								<li class='list-group-item'>Báo giá</li>
								<li class='list-group-item'>Hướng dẫn thanh toán</li>
								<li class='list-group-item'>Hướng dẫn sử dụng</li>
							</ul>
						</div>
					</div>
				</div>

				<div class='panel-group'>
					<div class='panel panel-default'>
						<div class='panel-heading'>
							<h4 class='panel-title'>
								<a data-toggle='collapse' href='#collapse4'>
									<div>
										<i class='fa-solid fa-gear'></i> <span>Tiện ích</span>
									</div> <i class='fa-solid fa-angle-down'></i>
								</a>
							</h4>
						</div>
						<div id='collapse4' class='panel-collapse collapse'>
							<ul class='list-group'>
								<li class='list-group-item'>Thông báo</li>
								<li class='list-group-item'>Quản lý đăng ký nhận email</li>
								<li class='list-group-item'>Yêu cầu khóa tài khoản</li>
							</ul>
						</div>
					</div>
				</div>
			</div>

			<div class='collapse-container collapse-container-1'>
				<ul class='list-group'>
					<li class='list-group-item'>Đăng mới</li>
					<li class='list-group-item'>Danh sách tin</li>
					<li class='list-group-item'>Tin nháp</li>
				</ul>
			</div>

			<div class='collapse-container collapse-container-2'>
				<ul class='list-group'>
					<li class='list-group-item'>Đăng mới</li>
					<li class='list-group-item'>Danh sách tin</li>
					<li class='list-group-item'>Tin nháp</li>
				</ul>
			</div>

			<div class='collapse-container collapse-container-3'>
				<ul class='list-group'>
					<li class='list-group-item'>Đăng mới</li>
					<li class='list-group-item'>Danh sách tin</li>
					<li class='list-group-item'>Tin nháp</li>
				</ul>
			</div>
		</div>

		<!-- ListTag -->
		<div className='list-tag'>
			<div className='header-wrapper'>
				<h3>Quản lý danh mục</h3>
				<button className='add-new-button'>Thêm mới</button>
			</div>
			<div className='search-wrapper'>
				<div className='input-container'>
					<i className='fa-solid fa-magnifying-glass'></i> <input type='text'
						placeholder='Tìm kiếm...' />
				</div>
				<div className='filter-container'>
					<select name='' id=''>
						<option value=''>Nhà đất bán</option>
						<option value=''>Nhà đất cho thuê</option>
					</select>
				</div>
			</div>
			<div className='table-wrapper'>
				<table className='table table-hover table-striped'>
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
						<tr>
							<th scope='row'>
								<p>1</p>
							</th>
							<td>
								<p>Nhà đất bán</p>
							</td>
							<td>
								<p>Bán căn hộ chung cư</p>
							</td>
							<td>
								<p>Hiển thị</p>
							</td>
							<td><a href=''> <i className='fa-solid fa-pencil'></i>
							</a> <a href=''> <i className='fa-solid fa-trash'></i>
							</a></td>
						</tr>
						<tr>
							<th scope='row'>
								<p>2</p>
							</th>
							<td>
								<p>Nhà đất cho thuê</p>
							</td>
							<td>
								<p>Cho thuê căn hộ chung cư</p>
							</td>
							<td>
								<p>Ẩn</p>
							</td>
							<td><a href=''> <i className='fa-solid fa-pencil'></i>
							</a> <a href=''> <i className='fa-solid fa-trash'></i>
							</a></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>

		<!-- ADDMODAL -->
		<div className='add-modal'>
			<div className='modal-wrapper'>
				<div className='modal-container'>
					<h1>Thêm danh mục</h1>
					<form>
						<div className='input-container'>
							<div className='form-item'>
								<p>Mã danh mục</p>
								<div className='input-wrapper'>
									<input type='text' placeholder='Nhập tên' readOnly />
								</div>
							</div>

							<div className='form-item'>
								<p>Loại danh mục</p>
								<select className='select-wrapper' name='' id=''>
									<option value=''>Nhà đất bán</option>
									<option value=''>Nhà đất cho thuê</option>
								</select>
							</div>
						</div>

						<div className='input-container'>
							<div className='form-item'>
								<p>Tên danh mục</p>
								<div className='input-wrapper'>
									<input type='text' placeholder='Nhập tên' />
								</div>
							</div>

							<div className='form-item'>
								<p>Trạng thái</p>
								<select className='select-wrapper' name='' id=''>
									<option value=''>Kích hoạt</option>
									<option value=''>Ẩn</option>
								</select>
							</div>
						</div>

						<div className='button-wrapper'>
							<div></div>
							<button className='continue-button'>
								<span>Lưu</span>
							</button>
						</div>
					</form>
				</div>
			</div>
			<button className='close-btn'>
				<i className='fa-solid fa-xmark'></i>
			</button>
		</div>
	</div>
</body>
</html>