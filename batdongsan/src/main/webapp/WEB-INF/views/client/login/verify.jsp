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
							<h3>Nhập mã xác minh</h3>
							<form action='verify.html' method="post">
								<div class='input-wrapper'>
									<i class="fa-regular fa-circle-check"></i> <input type="number"
										placeholder='Nhập mã xác nhận' name="code" id="code" />
									<button class='clear-button'>
										<i class='fa-solid fa-xmark'></i>
									</button>
								</div>

								<button class='signup-button' disabled="disabled">
								Xác minh
								</button>
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
			$(document).ready(function() {
			    $("#code").on("input", function(e) {
			        var emailValue = $(this).val();
			        
			        if (emailValue.length > 0) {
			            $(".signup-button").css("opacity", "1").prop('disabled', false);
			        } else {
			            $(".signup-button").css("opacity", "0.4").prop('disabled', true);
			        }
			    });
			});
		});
	</script>
</body>
</html>