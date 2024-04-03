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
							<h3>Đăng ký tài khoản mới</h3>
							<form action=''>
								<div class='input-wrapper'>
									<i class='fa-solid fa-phone'></i> <input type='text'
										placeholder='SĐT chính hoặc email' />
									<button class='clear-button'>
										<i class='fa-solid fa-xmark'></i>
									</button>
								</div>

								<button class='signup-button'>Tiếp tục</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>