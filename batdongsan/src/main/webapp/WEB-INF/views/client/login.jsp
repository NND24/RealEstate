<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Website số 1 về bất động sản</title>
<link rel="stylesheet" href="css/client/header.css" type="text/css">
<link rel="stylesheet" href="css/client/login.css" type="text/css">
<%@ include file="../../../links/links.jsp"%>
</head>
<body>
	<%@ include file="../../components/header.jsp"%>
	<div class="login">
		<div class='loginBox'>
			<div class='login-container'>
				<div class='left-wrapper'>
					<img src={loginImg} alt='' />
				</div>

				<div class='right-wrapper'>
					<div class='form-wrapper'>
						<div>
							<h5>Xin chào bạn</h5>
							<h3>Đăng nhập để tiếp tục</h3>
							<form action=''>
								<div class='input-wrapper'>
									<i class='fa-regular fa-user'></i> <input type='text'
										placeholder='SĐT chính hoặc email' />
									<button class='clear-button'>
										<i class='fa-solid fa-xmark'></i>
									</button>
								</div>
								<div class='input-wrapper'>
									<i class='fa-solid fa-lock'></i> <input type='password'
										placeholder='Mật khẩu' />
									<button class='show-pass'>
										<i class='fa-solid fa-eye-slash'></i>
									</button>
								</div>
								<button class='signin-button'>Đăng nhập</button>
							</form>
							<div class='nav-wrapper'>
								<div>
									<input type='checkbox' name='' id='remember' /> <label
										htmlFor='remember'>Nhớ tài khoản</label>
								</div>
								<span>Quên mật khẩu</span>
							</div>
						</div>
						<div class='form-footer'>
							<span> Chưa là thành viên? <a href=''>Đăng ký</a> tại đây
							</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>