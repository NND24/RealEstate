<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Website số 1 về bất động sản</title>
<link rel="stylesheet" href="css/admin/headerAdmin.css" type="text/css">
<link rel="stylesheet" href="css/admin/listNews.css" type="text/css">
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

		<!-- ListNews -->
		<div className='admin-list-news'>
			<div className='head-container'>
				<h1>Danh sách tin tức</h1>
				<button className='add-new-button'>Thêm mới</button>
			</div>
			<div className='content-container'>
				<div className='filter-wrapper'>
					<div className='search-input'>
						<input type='text' placeholder='Tìm theo mã tin, tiêu đề' /> <i
							className='fa-solid fa-magnifying-glass'></i>
					</div>
					<div className='dropdown'>
						<button className='btn dropdown-toggle' type='button'
							data-toggle='dropdown'>
							<i className='fa-regular fa-calendar'></i> <span>Mặc định
								1</span> <i className='fa-solid fa-angle-down'></i>
						</button>
						<ul className='dropdown-menu'>
							<li><a href='#HTML'>Mặc định</a></li>
							<li><a href='#'>1 tuần qua</a></li>
							<li><a href='#'>30 ngày qua</a></li>
						</ul>
					</div>
				</div>

				<div className='post-container'>
					<div className='tab-content'>
						<div className='admin-post-card'>
      <div>
        <img src="" alt='' />
        <div className='post-content-container'>
          <div>
            <h4 className='header'>Lê DươngTech - Tiên Phong Ứng Dụng Công Nghệ Cao Trong An Toàn Lao Động Và PCCC</h4>
            <div className='location'>
              <span>Bán nhà mặt phố</span>
              <span> · </span>
              <span>Bình Thạnh, Hồ Chí Minh</span>
            </div>
          </div>
          <div className='detail-container'>
            <div className='detail-item'>
              <span className='primary'>Trạng thái</span>
              <div className='status'>Đang hiển thị</div>
            </div>
            <div className='detail-item'>
              <span className='primary'>Mã tin</span>
              <div className='secondary'>28794101</div>
            </div>
            <div className='detail-item'>
              <span className='primary'>Ngày đăng</span>
              <div className='secondary'>21/12/2022</div>
            </div>
            <div className='detail-item'>
              <span className='primary'>Ngày hết hạn</span>
              <div className='secondary'>31/12/2022</div>
            </div>
            <div className='detail-item'>
              <span className='primary'>Thời gian</span>
              <div className='secondary'>Còn 10 ngày</div>
            </div>
          </div>
        </div>
      </div>
      <div>
        <div className='blank-container'></div>
        <div className='button-container'>
          <div className='button-item'>
            <i className='fa-regular fa-flag'></i>
            <span>Duyệt tin</span>
          </div>
          <div className='button-item'>
            <i className='fa-solid fa-ranking-star'></i>
            <span>Chi tiết</span>
          </div>
          <div className='button-item'>
            <i className='fa-solid fa-pencil'></i>
            <span>Ẩn tin</span>
          </div>
          <div className='button-item'>
            <i className='fa-regular fa-share-from-square'></i>
            <span>Xóa tin</span>
          </div>
          <div className='dropdown'>
            <div className='button-item dropdown-toggle' type='button' data-toggle='dropdown'>
              <i className='fa-solid fa-ellipsis'></i>
              <span>Thao tác</span>
            </div>
            <ul className='dropdown-menu'>
              <li>
                <a href='#'>
                  <i className='fa-solid fa-pencil'></i>
                  <span>Sửa tin</span>
                </a>
              </li>
              <li>
                <a href='#'>CSS</a>
              </li>
              <li>
                <a href='#'>JavaScript</a>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>
					</div>
				</div>
			</div>
		</div>

		<!-- ADDMODAL -->
		<div className='add-modal'>
			<div className='modal-wrapper'>
				<div className='modal-container'>
					<h1>Thêm tin tức</h1>
					<form>
						<div className='input-container'>
							<div className='form-item'>
								<p>Mã tin tức</p>
								<div className='input-wrapper'>
									<input type='text' placeholder='Nhập tên' readOnly />
								</div>
							</div>

							<div className='form-item'>
								<p>Danh sách từ khóa</p>
								<select className='select-wrapper' name='' id=''>
									<option value=''>Bất động sản Hà Nội</option>
									<option value=''>Diễn biến thị trường BĐS 2024</option>
									<option value=''>Thị trường đất nền</option>
								</select>
							</div>
						</div>

						<div className='input-container'>
							<div className='form-item'>
								<p>Tiêu đề</p>
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

						<div className='input-container'>
							<div className='form-item full-width'>
								<p>Mô tả</p>
								<div className='input-wrapper'>
									<textarea name='' id='' cols='10' rows='2'></textarea>
								</div>
							</div>
						</div>

						<div className='input-container'>
							<div className='form-item full-width'>
								<p>Nội dung</p>
								<div className='input-wrapper'>
									<textarea name='' id='' cols='10' rows='6'></textarea>
								</div>
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