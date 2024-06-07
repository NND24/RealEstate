<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Website số 1 về bất động sản</title>
<link rel="stylesheet" href="../css/client/index.css" type="text/css">
<link rel="stylesheet" href="../css/admin/headerAdmin.css"
	type="text/css">
<link rel="stylesheet" href="../css/admin/dashboard.css?version=55"
	type="text/css">
<%@ include file="../../../../links/links.jsp"%>
</head>
<body>
	<%@ include file="../../components/headerAdmin.jsp"%>
	<div class='admin'>
		<%@ include file="../../components/sidebarAdmin.jsp"%>
		<!-- Dashboard -->
		<div class='dashboard'>
			<div class='header-wrapper'>
				<h3>Bảng thống kê</h3>
			</div>

			 <div class="row">
                <div class="col-md-3">
                    <div class="card card-sales">
                        <h3>Tổng doanh thu</h3>
                        <p>$50,000</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card card-users">
                        <h3>Số người dùng</h3>
                        <p>1,200</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card card-posts">
                        <h3>Số bài đăng</h3>
                        <p>320</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card card-articles">
                        <h3>Số bài viết</h3>
                        <p>150</p>
                    </div>
                </div>
            </div>
		</div>
	</div>
</body>
</html>