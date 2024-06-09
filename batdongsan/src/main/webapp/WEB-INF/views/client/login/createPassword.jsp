<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Website số 1 về bất động sản</title>
<link rel="stylesheet" href="css/client/index.css" type="text/css">
<link rel="stylesheet" href="css/client/header.css?version=53"" type="text/css">
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
								<div class='form-item password'>
									<div class='input-wrapper'>
										<i class='fa-solid fa-lock'></i> <input type='password'
											placeholder='Nhập mật khẩu' class="password" name="password" />
										<div class='button show-pass'>
											<i class='fa-solid fa-eye-slash'></i>
											<i class="fa-solid fa-eye"></i>
										</div>
									</div>
									<p class="errorMessage" style="display: none"></p>
								</div>
								<div class='form-item rePassword'>
									<div class='input-wrapper'>
										<i class='fa-solid fa-lock'></i> <input type='password'
											placeholder='Nhập lại mật khẩu' class="password" name="rePassword" />
										<div class='button show-pass'>
											<i class='fa-solid fa-eye-slash'></i>
											<i class="fa-solid fa-eye"></i>
										</div>
									</div>
									<p class="errorMessage" style="display: none"></p>
								</div>
								<ul>
									<li class="check1">Mật khẩu tối thiểu 8 ký tự</li>
									<li class="check2">Chứa ít nhất 1 ký tự viết hoa</li>
									<li class="check3">Chứa ít nhất 1 ký tự số</li>
								</ul>
								<button class='signin-button' disabled="disabled">Tiếp tục</button>
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
		$(".show-pass").on("click", function() {
		    $(this).toggleClass("show");
		    
		    var passwordField;

		    if ($(this).closest(".form-item").find("input[name='password']").length > 0) {
		        passwordField = $('input[name="password"]');
		    } else {
		        passwordField = $('input[name="rePassword"]');
		    }

		    var currentType = passwordField.attr("type");
		    var newType = currentType === "password" ? "text" : "password";
		    passwordField.attr("type", newType);
		});

		var password = $('input[name="password"]');
		var rePassword = $('input[name="rePassword"]');

		$('input[type="password"], input[name="rePassword"]').on("input", function() {
	        if (password.val() !== "" && rePassword.val() !== "" && password.val() !== rePassword.val()) {
	            $(".rePassword .errorMessage").css("display", "block").text("Mật khẩu không trùng khớp");
	            $(".rePassword .input-wrapper").css("border-color", "rgb(224, 60, 49)");
	        } else {
	            $(".rePassword .errorMessage").css("display", "none").text("");
	            $(".rePassword .input-wrapper").css("border-color", "#ccc");
	        }
	        
	        var containsUppercase = /[A-Z]/.test(password.val());
	        var containsNumber = /\d/.test(password.val());
	        
	        if (password.val().length >= 8 && containsUppercase && containsNumber && password.val().trim() !== "" 
	                && rePassword.val().trim() !== "" && password.val() === rePassword.val()) {
	            $(".signin-button").css("opacity", "1").prop('disabled', false);
	        } else {
	            $(".signin-button").css("opacity", "0.4").prop('disabled', true);
	        }
	    });
		
		password.on("input", function() {
		    if (password.val().length >= 8) {
		        $(".check1").css("color", "rgb(7, 163, 93)");
		    } else {
		        $(".check1").css("color", "rgb(153, 153, 153)");
		    }

		    var containsUppercase = /[A-Z]/.test(password.val());

		    if (containsUppercase) {
		        $(".check2").css("color", "rgb(7, 163, 93)");
		    } else {
		        $(".check2").css("color", "rgb(153, 153, 153)");
		    }

		    var containsNumber = /\d/.test(password.val());

		    if (containsNumber) {
		        $(".check3").css("color", "rgb(7, 163, 93)");
		    } else {
		        $(".check3").css("color", "rgb(153, 153, 153)");
		    }
		});
	})
	</script>
</body>
</html>