<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Website số 1 về bất động sản</title>
<link rel="stylesheet" href="../css/client/index.css" type="text/css">
<link rel="stylesheet" href="../css/admin/loginAdmin.css?version=58"
	type="text/css">
<%@ include file="../../../../links/links.jsp"%>
</head>
<body>
	<div class='loginAdmin'
		style="background-image: url('${pageContext.servletContext.contextPath}/images/bg-login-admin3.jpg');">

		<div class="login-card">
			<div class="card-header">
				<div class="log">Đăng nhập</div>
			</div>
			<form:form action="loginInAdminPage.html" method="post"
				modelAttribute="account">
				<div class="form-group">
					<label for="email">Email:</label>
					<form:input path="email" id="email" type="text" />
					<form:errors class="errorMessage errorCtrlMessage" path="email" />
				</div>
				<div class="form-group">
					<label for="password">Mật khẩu:</label>
					<form:input path="password" id="password" type="password" />
					<form:errors class="errorMessage errorCtrlMessage" path="password" />
				</div>
				<div class="form-group">
					<a href="forgot-password.html"><span class="forget-password">Quên mật khẩu?</span> </a>
				</div>
				<%
				String error = (String) request.getAttribute("error");
				if (error != null && !error.isEmpty()) {
				%>
				<p class="errorMessage errorCtrlMessage"><%=error%></p>
				<%
				}
				%>
				<p class="errorMessage" style="display: none"></p>
				<div class="form-group">
					<form:button class="form-submit-btn" type="submit">Đăng nhập</form:button>
				</div>
			</form:form>
		</div>


	</div>
</body>
</html>

