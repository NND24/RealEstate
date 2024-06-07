<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Website số 1 về bất động sản</title>
<link rel="stylesheet" href="../css/client/index.css" type="text/css">
<link rel="stylesheet" href="../css/admin/verifyCode.css?version=57"
	type="text/css">
<%@ include file="../../../../links/links.jsp"%>
</head>
<body>
	<div class='loginAdmin'
		style="background-image:url('${pageContext.servletContext.contextPath}/images/bg-login-admin3.jpg');">

		<form class="otp-Form" action="confirmVerifyCode.html" method = "post">
			<span class="mainHeading">Nhập mã xác nhận</span>
			<p class="otpSubheading">Kiểm tra Email của bạn để lấy mã xác
				nhận</p>
			<div class="inputContainer">
				<input required="required" maxlength="1" type="text" class="otp-input" name="verify-code-1"> 
				<input required="required" maxlength="1" type="text" class="otp-input" name="verify-code-2"> 
				<input required="required" maxlength="1" type="text" class="otp-input" name="verify-code-3">
				<input required="required" maxlength="1" type="text" class="otp-input" name="verify-code-4"> 
				<input required="required" maxlength="1" type="text" class="otp-input" name="verify-code-5"> 
				<input required="required" maxlength="1" type="text" class="otp-input" name="verify-code-6">
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

			<button class="verifyButton" type="submit">Xác nhận</button>
			<button class="exitBtn">×</button>
		</form>
	</div>
</body>
</html>

