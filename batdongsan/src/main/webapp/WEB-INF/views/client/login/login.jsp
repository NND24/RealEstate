<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Website số 1 về bất động sản</title>
<link rel="stylesheet" href="css/client/index.css" type="text/css">
<link rel="stylesheet" href="css/client/header.css" type="text/css">
<link rel="stylesheet" href="css/client/login.css?version=52"
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
							<h5>Xin chào bạn</h5>
							<h3>Đăng nhập để tiếp tục</h3>
							<form:form action="login.html" method="post"
								modelAttribute="account">								
								<div class='form-item email'>
									<div class='input-wrapper'>
										<i class='fa-regular fa-user'></i>
										<form:input path="email" id="email" type="text" placeholder='SĐT chính hoặc email' 
                        				cssClass="${not empty emailError || not empty error ? 'error-border' : ''}" />
										<form:errors class="errorMessage errorCtrlMessage"
											path="email" />
										<div class='button clear-button'>
											<i class='fa-solid fa-xmark'></i>
										</div>
									</div>
								</div>
								<div class='form-item'>
									<div class='input-wrapper'>
										<i class='fa-solid fa-lock'></i>
										<form:input path="password" id="password" type="password" placeholder='Mật khẩu'
										cssClass="${not empty passwordError || not empty error  ? 'error-border' : ''}" />
										<form:errors class="errorMessage errorCtrlMessage"
											path="password" />
										<div class='button show-pass show'>
											<i class='fa-solid fa-eye-slash'></i> <i
												class="fa-solid fa-eye"></i>
										</div>
									</div>
									<c:if test="${not empty error}">
										<p class="errorMessage errorCtrlMessage">${error}</p>
									</c:if>
								</div>
								<button class="signin-button" type="submit">Đăng nhập</button>
							</form:form>
							<div class='nav-wrapper'>
								<div></div>
								<a
									href='${pageContext.servletContext.contextPath}/khoi-phuc-mat-khau.html'><span>Quên
										mật khẩu?</span></a>
							</div>
						</div>
						<div class='form-footer'>
							<span> Chưa là thành viên? <a
								href='${pageContext.servletContext.contextPath}/dang-ky.html'>Đăng
									ký</a> tại đây
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
				
				var passwordField = $("#password");
			    var currentType = passwordField.attr("type");
			    var newType = currentType === "password" ? "text" : "password";
			    passwordField.attr("type", newType);
			})
		})
	</script>
</body>
</html>