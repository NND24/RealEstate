<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Website số 1 về bất động sản</title>
<link rel="stylesheet" href="css/client/index.css" type="text/css">
<link rel="stylesheet" href="css/client/header.css" type="text/css">
<link rel="stylesheet" href="css/client/login.css?version=50" type="text/css">
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
								<div class='form-item email'>
									<div class='input-wrapper'>
										<i class='fa-regular fa-user'></i> <input type='text'
											placeholder='SĐT chính hoặc email' name="email" />
										<div class='button clear-button'>
											<i class='fa-solid fa-xmark'></i>
										</div>
									</div>
									<p class="errorMessage" style="display: none"></p>
								</div>
								<div class='form-item password'>
									<div class='input-wrapper'>
										<i class='fa-solid fa-lock'></i> <input type='password'
											placeholder='Mật khẩu' class="password" name="password" />
										<div class='button show-pass show'>
											<i class='fa-solid fa-eye-slash'></i>
											<i class="fa-solid fa-eye"></i>
										</div>
									</div>
									<%
									String error = (String) request.getAttribute("error");
									if(error != null && !error.isEmpty()) {
									%>
									<p class="errorMessage errorCtrlMessage"><%= error %></p>
									<% } %>
									<p class="errorMessage" style="display: none"></p>
								</div>
								<button class='signin-button' disabled="disabled">Đăng nhập</button>
							</form>
							<div class='nav-wrapper'>
								<div>
									
								</div>
								<a href='${pageContext.servletContext.contextPath}/khoi-phuc-mat-khau.html'><span>Quên mật khẩu?</span></a>
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
			
			$('input[name="email"], input[name="password"]').on("mouseout", function() { 
			    var email = $('input[name="email"]');
			    var password = $('input[name="password"]');
			    
			    if (email.val().trim() === "") {
			        $(".email .errorMessage").css("display", "block").text("Email không được bỏ trống");
			        $(".email input[name='email']").css("border-color", "rgb(224, 60, 49)");
			    } else if (email.val().trim() !== "") {
			        $(".email .errorMessage").css("display", "none").text("");
			        $(".email input[name='email']").css("border-color", "#ccc");
			    }
			    
			    if (password.val().trim() === "") {
			        $(".password .errorMessage").css("display", "block").text("Mật khẩu không được bỏ trống");
			        $(".password input[name='password']").css("border-color", "rgb(224, 60, 49)");
			    } else {
			        $(".password .errorMessage").css("display", "none").text("");
			        $(".password input[name='password']").css("border-color", "#ccc");
			    }
			    
			    if(email.val().trim() !== "" && password.val().trim() !== "") {
			        $(".signin-button").css("opacity", "1").prop('disabled', false);
			    } else {
			        $(".signin-button").css("opacity", "0.4").prop('disabled', true);
			    }
			});
			
			$('input[name="password"]').on("input", function() {
				$(".errorCtrlMessage").css("display", "none")
			})
		})
	</script>
</body>
</html>