<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@page import="batdongsan.models.UsersModel"%>
<%@page import="batdongsan.models.HCMRealEstateModel"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Website số 1 về bất động sản</title>
<link rel="stylesheet" href="../../../css/client/index.css"
	type="text/css">
<link rel="stylesheet"
	href="../../../css/admin/detailUser.css?version=75" type="text/css">
<link rel="stylesheet" href="../../../css/admin/listUser.css?version=60"
	type="text/css">
<link rel="stylesheet"
	href="../../../css/admin/headerAdmin.css?version=60" type="text/css">
<%@ include file="../../../../links/links.jsp"%>
</head>
<body>
	<%@ include file="../../../components/headerAdmin.jsp"%>
	<div class='admin'>
		<%@ include file="../../../components/sidebarAdmin.jsp"%>
		<!-- ListCategory -->
		<div class="container-user">
			<div class="title">Chi tiết user</div>
			<div class="user-info">
				<div class="user-avatar">
					<img
						src="${pageContext.servletContext.contextPath}/images/${user.avatar}"
						alt="">
				</div>
				<div class="user-detail-info">
					<div class="user-detail-info-left">
						<div class="user-detail-info-item">
							<p class="user-detail-info-item-label">Id:</p>
							<p class="user-detail-info-item-show">${user.userId}</p>
						</div>
						<div class="user-detail-info-item">
							<p class="user-detail-info-item-label">Tên:</p>
							<p class="user-detail-info-item-show">${user.name}</p>
						</div>
						<div class="user-detail-info-item">
							<p class="user-detail-info-item-label">Email:</p>
							<p class="user-detail-info-item-show">${user.email}</p>
						</div>
					</div>
					<div class="user-detail-info-right">
						<div class="user-detail-info-item">
							<p class="user-detail-info-item-label">MST:</p>
							<p class="user-detail-info-item-show">${user.taxCode}</p>
						</div>
						<div class="user-detail-info-item">
							<p class="user-detail-info-item-label">SĐT:</p>
							<p class="user-detail-info-item-show">${user.phonenumber}</p>
						</div>
						<div class="user-detail-info-item">
							<p class="user-detail-info-item-label">Tiền trong TK:</p>
							<p class="user-detail-info-item-show">${user.accountBalance}</p>
						</div>
					</div>
				</div>
			</div>
			<%
			List<HCMRealEstateModel> sellRealEstates = (List<HCMRealEstateModel>) request.getAttribute("sellRealEstates");
			%>
			<div class="title">Các tin đã đăng</div>
			<div class="user-real-estate-new">
				<%
				if (sellRealEstates != null) {
					for (HCMRealEstateModel r : sellRealEstates) {
						String imageStr = (String) r.getImages();

						if (imageStr != null && !imageStr.isEmpty()) {
					imageStr = imageStr.substring(1, imageStr.length() - 1);
					String[] imgPaths = imageStr.split(",");
				%>
				<div class="card-real-estate">
					<div class="card-thumbnail">
						<img
							src="${pageContext.servletContext.contextPath}/images/<%=imgPaths[0]%>"
							alt="">
					</div>
					<div class="card-name">
						<a
							href="${pageContext.servletContext.contextPath}/admin/chi-tiet.html?realEstateId=<%= r.getRealEstateId() %>"><%=r.getTitle()%></a>
					</div>
					<div class="card-info-upper">
						<div class="real-estate-price">
							<%
							if (r.getPrice() < 1000000000) {
								out.print((int) (r.getPrice() / 1000000) + " triệu");
							} else {
								out.print(r.getPrice() / 1000000000 + " tỷ");
							}
							%>
							<%
							if (r.getUnit().equals("triệu")) {
								out.print("");
							} else {
								out.print(r.getUnit());
							}
							%>
						</div>
						<div class="real-estate-size"><%=r.getSize()%>
							m²
						</div>
					</div>
					<div class="card-info-lower">
						<div class="real-estate-location">Quận 1, TPHCM</div>
						<div class="real-estate-uploaded-date"><%=r.getSubmittedDate()%></div>
					</div>
				</div>





				<%
				}
				}
				}
				%>
			</div>
		</div>
	</div>
</body>
</html>