<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Website số 1 về bất động sản</title>
<link rel="stylesheet" href="css/admin/headerAdmin.css" type="text/css">
<link rel="stylesheet" href="css/admin/listPost.css" type="text/css">
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
										<i class='fa-solid fa-coins'></i> <span> Quản lý
											tài chính</span>
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
										<i class='fa-solid fa-paperclip'></i> <span>Báo giá
											& hướng dẫn</span>
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

		<!-- ListPost -->
		<div class='admin-list-post'>
			<h1>Danh sách tin</h1>
			<div class='content-container'>
				<div class='filter-wrapper'>
					<div class='search-input'>
						<input type='text' placeholder='Tìm theo mã tin, tiêu đề' /> <i
							class='fa-solid fa-magnifying-glass'></i>
					</div>
					<div class='dropdown'>
						<button class='btn dropdown-toggle' type='button'
							data-toggle='dropdown'>
							<i class='fa-regular fa-calendar'></i> <span>Mặc định</span>
							<i class='fa-solid fa-angle-down'></i>
						</button>
						<ul class='dropdown-menu'>
							<li><a href='#HTML'>Mặc định</a></li>
							<li><a href='#'>1 tuần qua</a></li>
							<li><a href='#'>30 ngày qua</a></li>
						</ul>
					</div>
				</div>

				<div class='post-container'>
					<div class='tab-content'>
						<div class='admin-post-card'>
							<div>
								<img src="" alt='' />
								<div class='post-content-container'>
									<div>
										<h4 class='header'>Bán nhà riêng m2 riêng m2 đường
											Nguyễn Thái Học, Bán nhà riêng m2 riêng m2 đường Nguyễn Thái
											Học</h4>
										<div class='location'>
											<span>Bán nhà mặt phố</span> <span> · </span> <span>Bình
												Thạnh, Hồ Chí Minh</span>
										</div>
									</div>
									<div class='detail-container'>
										<div class='detail-item'>
											<span class='primary'>Trạng thái</span>
											<div class='status'>Đang hiển thị</div>
										</div>
										<div class='detail-item'>
											<span class='primary'>Mã tin</span>
											<div class='secondary'>28794101</div>
										</div>
										<div class='detail-item'>
											<span class='primary'>Ngày đăng</span>
											<div class='secondary'>21/12/2022</div>
										</div>
										<div class='detail-item'>
											<span class='primary'>Ngày hết hạn</span>
											<div class='secondary'>31/12/2022</div>
										</div>
										<div class='detail-item'>
											<span class='primary'>Thời gian</span>
											<div class='secondary'>Còn 10 ngày</div>
										</div>
									</div>
								</div>
							</div>
							<div>
								<div class='blank-container'></div>
								<div class='button-container'>
									<div class='button-item'>
										<i class='fa-regular fa-flag'></i> <span>Duyệt tin</span>
									</div>
									<div class='button-item'>
										<i class='fa-solid fa-ranking-star'></i> <span>Chi
											tiết</span>
									</div>
									<div class='button-item'>
										<i class='fa-solid fa-pencil'></i> <span>Ẩn tin</span>
									</div>
									<div class='button-item'>
										<i class='fa-regular fa-share-from-square'></i> <span>Xóa
											tin</span>
									</div>
									<div class='dropdown'>
										<div class='button-item dropdown-toggle' type='button'
											data-toggle='dropdown'>
											<i class='fa-solid fa-ellipsis'></i> <span>Thao
												tác</span>
										</div>
										<ul class='dropdown-menu'>
											<li><a href='#'> <i class='fa-solid fa-pencil'></i>
													<span>Sửa tin</span>
											</a></li>
											<li><a href='#'>CSS</a></li>
											<li><a href='#'>JavaScript</a></li>
										</ul>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>