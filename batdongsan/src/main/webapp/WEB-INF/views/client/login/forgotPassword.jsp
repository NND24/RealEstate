<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Website số 1 về bất động sản</title>
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath}/css/client/index.css"
	type="text/css">
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath}/css/client/header.css?version=53"
	" type="text/css">
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath}/css/client/login.css?version=52"
	type="text/css">
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
							<h3>Khôi phục mật khẩu</h3>
							<form action='mailer/checkForgotPassEmail.html' method="POST">
								<div class='input-wrapper'>
									<i class="fa-regular fa-envelope"></i> <input type="email"
										placeholder='Nhập email' name="to" id="email"
										class="${not empty emailError || not empty error ? 'error-border' : ''}" />
									<button class='clear-button'>
										<i class='fa-solid fa-xmark'></i>
									</button>
								</div>
								<c:if test="${not empty error}">
									<p class="errorMessage errorCtrlMessage">${error}</p>
								</c:if>

								<button class='signup-button' disabled="disabled">Tiếp
									tục</button>
							</form>
						</div>
						<div class='form-footer'>
							<span>Bạn đã có tài khoản? <a
								href='${pageContext.servletContext.contextPath}/dang-nhap.html'>Đăng
									nhập</a> tại đây
							</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$(document).ready(
				function() {
					$(document).ready(
							function() {
								$("#email").on(
										"input",
										function(e) {
											var emailValue = $(this).val();

											if (emailValue.length > 0) {
												$(".signup-button").css(
														"opacity", "1").prop(
														'disabled', false);
											} else {
												$(".signup-button").css(
														"opacity", "0.4").prop(
														'disabled', true);
											}
										});
							});
				});
	</script>
</body>
</html>