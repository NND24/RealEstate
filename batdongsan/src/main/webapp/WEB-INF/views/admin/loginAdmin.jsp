<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Website số 1 về bất động sản</title>
<link rel="stylesheet" href="../css/client/index.css"
	type="text/css">
<link rel="stylesheet" href="../css/admin/loginAdmin.css?version=51"
	type="text/css">
<%@ include file="../../../links/links.jsp"%>
</head>
<body>
	<div class='loginAdmin' style="background-image: url('${pageContext.servletContext.contextPath}/images/bg-01.jpg');">
      <div class='login-container'>
        <h4>Đăng nhập</h4>
        <div>
          <label htmlFor=''>Tên tài khoản</label>
          <input type='text' />
        </div>
        <div>
          <label htmlFor=''>Mật khẩu</label>
          <div class='input-wrapper'>
            <input type='password' />
            <i class='fa-regular fa-eye'></i>
          </div>
        </div>
        <p>Quên mật khẩu?</p>
        <button>Đăng nhập</button>
      </div>
    </div>
</body>
</html>

