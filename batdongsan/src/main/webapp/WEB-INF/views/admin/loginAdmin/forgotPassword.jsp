<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Website số 1 về bất động sản</title>
<link rel="stylesheet" href="../css/client/index.css" type="text/css">
<link rel="stylesheet" href="../css/admin/forgotPassword.css?version=57"
	type="text/css">
<%@ include file="../../../../links/links.jsp"%>
</head>
<body>
	<div class='loginAdmin'
		style="background-image: url('${pageContext.servletContext.contextPath}/images/bg-login-admin3.jpg');">

		<div class="form-container">
			<div class="logo-container">Quên mật khẩu</div>

			<form:form action="sendVerifyCode.html" method="post" modelAttribute="account" class="form">
				<div class="form-group">
					<label for="email">Email</label> 
					<form:input type="text" id="email"
						path="email" placeholder="Nhập email"/>
					<form:errors class="errorMessage errorCtrlMessage" path="email" />
				</div>

				<button class="form-submit-btn" type="submit">Gửi email</button>
			</form:form>
		</div>


	</div>
</body>
</html>

