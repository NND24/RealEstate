<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Website số 1 về bất động sản</title>
<link rel="stylesheet" href="css/client/index.css" type="text/css">
<link rel="stylesheet" href="css/client/header.css" type="text/css">
<link rel="stylesheet" href="css/client/login.css" type="text/css">
<%@ include file="../../../../links/links.jsp"%>
<base href="${pageContext.servletContext.contextPath}/">
</head>
<body>
	<%@ include file="../../../components/header.jsp"%>
	<div class="login">
		<div class='loginBox'>
			<div class='login-container'>
				<div class='left-wrapper'>
					<img src="images/loginImg.png" alt='' />
				</div>

				<div class='right-wrapper'>
					<div class='form-wrapper'>
						<div>
							<h5>Xin chào bạn</h5>
							<h3>Đăng nhập để tiếp tục</h3>
							<form action='login.html' method="post">
								<div class='input-wrapper'>
									<i class='fa-regular fa-user'></i> <input type='text'
										placeholder='SĐT chính hoặc email' name="email" />
									<div class='button clear-button'>
										<i class='fa-solid fa-xmark'></i>
									</div>
								</div>
								<div class='input-wrapper'>
									<i class='fa-solid fa-lock'></i> <input type='password'
										placeholder='Mật khẩu' class="password" name="password" />
									<div class='button show-pass show'>
										<i class='fa-solid fa-eye-slash'></i>
										<i class="fa-solid fa-eye"></i>
									</div>
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
							<span> Chưa là thành viên? <a href='${pageContext.servletContext.contextPath}/dang-ky.html'>Đăng ký</a> tại đây
							</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$(document).ready(function() {
			$(".show-pass").on("click", () => {
				$(".show-pass").toggleClass("show");
				
				var passwordField = $(".password");
			    var currentType = passwordField.attr("type");
			    var newType = currentType === "password" ? "text" : "password";
			    passwordField.attr("type", newType);
			})
		})
	</script>
</body>
</html>