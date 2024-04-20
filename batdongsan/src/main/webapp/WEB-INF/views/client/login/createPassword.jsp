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
							<h3>Tạo mật khẩu</h3>
							<form action='createAccount.html' method="post">
								<div class='input-wrapper'>
									<i class='fa-solid fa-lock'></i> <input type='password'
										placeholder='Nhập mật khẩu' class="password" name="password" />
									<div class='button show-pass show'>
										<i class='fa-solid fa-eye-slash'></i>
										<i class="fa-solid fa-eye"></i>
									</div>
								</div>
								<div class='input-wrapper'>
									<i class='fa-solid fa-lock'></i> <input type='password'
										placeholder='Nhập lại mật khẩu' class="password" name="rePassword" />
									<div class='button show-pass show'>
										<i class='fa-solid fa-eye-slash'></i>
										<i class="fa-solid fa-eye"></i>
									</div>
								</div>
								<ul>
									<li>Mật khẩu tối thiểu 8 ký tự</li>
									<li>Chứa ít nhất 1 ký tự viết hoa</li>
									<li>Chứa ít nhất 1 ký tự số</li>
								</ul>
								<button class='signin-button'>Tiếp tục</button>
							</form>
						</div>
						<div class='form-footer'>
							<span>Bạn đã có tài khoản? <a href='${pageContext.servletContext.contextPath}/dang-nhap.html'>Đăng nhập</a> tại đây
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