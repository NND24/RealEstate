<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Website số 1 về bất động sản</title>
<link rel="stylesheet" href="../css/client/index.css" type="text/css">
<link rel="stylesheet" href="../css/client/header.css" type="text/css">
<link rel="stylesheet" href="../css/client/sellernet.css"
	type="text/css">
<link rel="stylesheet" href="../css/client/manageAccount.css"
	type="text/css">
<%@ include file="../../../../links/links.jsp"%>
<script
	src="https://cdn.ckeditor.com/ckeditor5/41.2.1/classic/ckeditor.js"></script>


<base href="${pageContext.servletContext.contextPath}/">
</head>
<body>
	<%@ include file="../../../components/header.jsp"%>
	<div class='sellernet'>
		<%@ include file="../../../components/sellernetSidebar.jsp"%>

		<!-- ManageAccount -->
		<div class='manage-account'>
			<div class='content-container'>
				<h1>Quản lý tài khoản</h1>
				<div class='post-container'>
					<%
						String edit = (String) request.getAttribute("edit");
						String setting = (String) request.getAttribute("setting");
					%>
					<ul class='nav nav-tabs'>
						<li 
						<% if(edit != null && !edit.isEmpty()) { %>
						class='active'
						<% } %>
						>
							<a data-toggle='tab' href='#home'>Chỉnh sửa thông tin </a>
						</li>
						<li
						<% if(setting != null && !setting.isEmpty()) { %>
						class='active'
						<% } %>
						>
							<a data-toggle='tab' href='#menu1'> Cài đặt tài khoảns</a>
						</li>
					</ul>

					<div class='tab-content'>
						<div id='home' class='tab-pane fade
						<% if(edit != null && !edit.isEmpty()) { %>
						 in active
						<% } %>			 
						 '>
							<div class='input-wrapper'>
								<h3>Thông tin cá nhân</h3>
								<div class='avatar-container'>
									<div class='avatar'>
										<i class='fa-solid fa-camera'></i> <span>Tải ảnh</span>
									</div>
								</div>
								<div class='input-container'>
									<div class='form-item'>
										<p>Họ và tên</p>
										<div class='input-wrapper'>
											<input type='text' placeholder='Nhập tên' />
										</div>
									</div>

									<div class='form-item'>
										<p>Mã số thuế cá nhân</p>
										<div class='input-wrapper'>
											<input type='text' placeholder='Nhập số đã đăng ký' />
										</div>
									</div>
								</div>
							</div>

							<div class='input-wrapper'>
								<h3>Thông tin liên hệ</h3>
								<div class='input-container'>
									<div class='form-item'>
										<p>Số điện thoại</p>
										<div class='input-wrapper'>
											<input type='text' placeholder='Nhập tên' />
										</div>
									</div>

									<div class='form-item'>
										<p>Email</p>
										<div class='input-wrapper'>
											<input type='text' placeholder='Nhập số đã đăng ký' />
										</div>
									</div>
								</div>
							</div>

							<div class='button-wrapper'>
								<div></div>
								<button class='continue-button'>
									<span>Lưu thay đổi</span> <i
										class='fa-solid fa-angle-right'></i>
								</button>
							</div>
						</div>
						<div id='menu1' class='tab-pane fade
						<% if(setting != null && !setting.isEmpty()) { %>
						 in active
						<% } %>	
						'>
							<div class='input-wrapper'>
								<h3>Đổi mật khẩu</h3>
								<div class='input-container'>
									<div class='form-item'>
										<p>Mật khẩu hiện tại</p>
										<div class='input-wrapper'>
											<input type='password' /> <i class='fa-regular fa-eye'></i>
										</div>
									</div>

									<div class='form-item'>
										<p></p>
										<span>Bạn quên mật khẩu</span>
									</div>

									<div class='form-item'>
										<p>Mật khẩu mới</p>
										<div class='input-wrapper'>
											<input type='password' /> <i class='fa-regular fa-eye'></i>
										</div>
									</div>

									<div class='form-item'>
										<span></span>
									</div>

									<div class='form-item'>
										<p>Nhập lại mật khẩu mới</p>
										<div class='input-wrapper'>
											<input type='password' /> <i class='fa-regular fa-eye'></i>
										</div>
									</div>

									<div class='form-item'>
										<p></p>
										<button>Lưu thay đổi</button>
									</div>
								</div>
								<ul>
									<li>Mật khẩu tối thiểu 8 ký tự</li>
									<li>Chứa ít nhất 1 ký tự viết hoa</li>
									<li>Chứa ít nhất 1 ký tự số</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		
	</script>
</body>
</html>