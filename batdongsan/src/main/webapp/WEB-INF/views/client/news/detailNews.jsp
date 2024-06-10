<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Website số 1 về bất động sản</title>
<link rel="stylesheet" href="../css/client/index.css" type="text/css">
<link rel="stylesheet" href="../css/client/header.css?version=51" type="text/css">
<link rel="stylesheet" href="../css/client/news.css?version=50"
	type="text/css">
<link rel="stylesheet" href="../css/admin/detail.css"
	type="text/css">
<link rel="stylesheet" href="../css/client/moreNews.css" type="text/css">
<link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/client/footer.css" type="text/css">
<%@ include file="../../../../links/links.jsp"%>
</head>
<body>
	<%@ include file="../../../components/headerNews.jsp"%>
	<!-- ListNews -->
	<div class='detail'>
		<div class='container '>
			<div class='row'>
				<!-- Content -->
				<div class='detail-content col-lg-12'>


					<div class='breadcrumb'>
						<a href='tin-tuc.html'> <i class="fa-solid fa-house"></i>
						</a> <span> > </span> <a href=''>${news.title}</a>
					</div>
					<h3 class='detail-content__title'>${news.title}</h3>

					<div class='short-info-writter-container'>
						<div class="writter-info">
							<span>Được đăng bởi </span>
							<p class="writter-name">${news.employee.fullname}</p>
							<br> <span>Đăng vào ngày</span>
							<p class="writter-info">${news.dateUploaded}</p>
						</div>
					</div>
					<div class="short-description-container">
						<strong class='detail-content__address'>${news.shortDescription}</strong>
					</div>

					<div class='short-info-container'>

						<img
							src="${pageContext.servletContext.contextPath}/images/News/${news.thumbnail}"
							alt="" />
					</div>
					<div class='description-container'>
						<div class='description-body'>${news.description}</div>
						<p class="writter-name">${news.employee.fullname}</p>
					</div>
				</div>

				<!-- Sidebar -->

			</div>
		</div>
	</div>

	<%@ include file="../../../components/footer.jsp"%>
</body>
</html>