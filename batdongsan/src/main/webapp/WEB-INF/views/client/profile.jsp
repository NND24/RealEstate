<%@page import="batdongsan.models.RealEstateModel"%>
<%@page import="java.util.List"%>
<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Website số 1 về bất động sản</title>
<link rel="stylesheet" href="css/client/index.css" type="text/css">
<link rel="stylesheet" href="css/client/header.css?version=53"" type="text/css">
<link rel="stylesheet" href="css/client/profile.css?version=50" type="text/css">
<link rel="stylesheet" href="css/client/footer.css" type="text/css">
<%@ include file="../../../links/links.jsp"%>
<base href="${pageContext.servletContext.contextPath}/">
</head>
<body>
	<%@ include file="../../components/header.jsp"%>
	<div>
		<div class='profile'>
			<img src="images/cover.png" class='coverImg' alt='' />
			<div class='container'>
				<div class='info-container'>
					<%
					UsersModel userInfo = (UsersModel) request.getAttribute("userInfo");
			
					%>
					<img src="images/<%= userInfo.getAvatar() %>" alt='' />
					<div>
						<h5 class='name'><%= userInfo.getName() %></h5>
						<div class='button-container'>
							<button>
								<i class='fa-solid fa-phone-volume'></i> <span><%= userInfo.getPhonenumber() %>
									∙ Hiện số</span>
							</button>
						</div>
					</div>
				</div>
				<div class='product-container'>
					<%
					List<RealEstateModel> sellRealEstates = (List<RealEstateModel>) request.getAttribute("sellRealEstates");
					%>
					<h3 class='heading'>Danh sách tin đăng bán (<%= sellRealEstates.size() %>)</h3>
					<div class='row gx-5 gy-5'>
						<%
						if (sellRealEstates != null) {
							for (RealEstateModel r : sellRealEstates) {
								String imageStr = (String) r.getImages();

								if (imageStr != null && !imageStr.isEmpty()) {
									imageStr = imageStr.substring(1, imageStr.length() - 1);
									String[] imgPaths = imageStr.split(",");
						%>
						<div class='sale-card col-lg-3 col-md-4 col-sm-6 col-xs-2'>
							<div class='card-image'>
								<img src="images/<%=imgPaths[0]%>" alt='' />
								<div class='card-image-feature'>
									<i class='fa-regular fa-image'></i> <span>6</span>
								</div>
							</div>
							<div class='card-info-container'>
								<div class='card-info__title'><%=r.getTitle()%></div>
								<div class='card-info__config'>
									<span class='card-config__item card-config__price'>
									<%
									if(r.getPrice() < 1000000000) {
									    out.print((int)(r.getPrice() / 1000000) + " triệu");
									} else {
									    out.print(r.getPrice() / 1000000000 + " tỷ");
									}
									%>
									<%
									if(r.getUnit().equals("triệu")) {
									    out.print("");
									} else {
									    out.print(r.getUnit());
									}
									%>
									</span> <span class='card-config__item card-config__dot'>·</span>
									<span class='card-config__item card-config__area'><%= r.getArea()%> m²</span>
								</div>
								<div class='card-info__location'>
									<i class='fa-solid fa-location-dot'></i> <span><%=r.getDistrict().getName()%>, <%=r.getProvince().getName()%></span>
								</div>
								<div class='card-info__contact'>
									<div class='card-published-info'>Đăng 5 ngày trước</div>
									<div class='card-contact-button__favorite'
										value="<%=r.getRealEstateId()%>">
										<i class='fa-regular fa-heart'
											style="display: <%=r.getFavourite().size() > 0 ? "none" : "block"%>;"></i>
										<i class="fa-solid fa-heart"
											style="color: #e03c31;display: <%=r.getFavourite().size() > 0 ? "block" : "none"%>;"></i>
									</div>
								</div>
							</div>
						</div>
						<%
						}
						}
						}
						%>
					</div>
				</div>
				<div class='product-container'>
					<%
						List<RealEstateModel> rentRealEstates = (List<RealEstateModel>) request.getAttribute("rentRealEstates");
					%>
					<h3 class='heading'>Danh sách tin đăng cho thuê (<%= rentRealEstates.size() %>)</h3>
					<div class='row gx-5 gy-5'>
					<%
						if (rentRealEstates != null) {
							for (RealEstateModel r : rentRealEstates) {
								String imageStr = (String) r.getImages();

								if (imageStr != null && !imageStr.isEmpty()) {
									imageStr = imageStr.substring(1, imageStr.length() - 1);
									String[] imgPaths = imageStr.split(",");
						%>
						<div class='sale-card col-lg-3 col-md-4 col-sm-6 col-xs-2'>
							<div class='card-image'>
								<img src="images/<%=imgPaths[0]%>" alt='' />
								<div class='card-image-feature'>
									<i class='fa-regular fa-image'></i> <span>6</span>
								</div>
							</div>
							<div class='card-info-container'>
								<div class='card-info__title'><%=r.getTitle()%></div>
								<div class='card-info__config'>
									<span class='card-config__item card-config__price'>
									<%
									if(r.getPrice() < 1000000000) {
									    out.print((int)(r.getPrice() / 1000000) + " triệu");
									} else {
									    out.print(r.getPrice() / 1000000000 + " tỷ");
									}
									%>
									<%
									if(r.getUnit().equals("triệu")) {
									    out.print("");
									} else {
									    out.print(r.getUnit());
									}
									%>
									</span> <span class='card-config__item card-config__dot'>·</span>
									<span class='card-config__item card-config__area'><%= r.getArea()%> m²</span>
								</div>
								<div class='card-info__location'>
									<i class='fa-solid fa-location-dot'></i> <span><%=r.getDistrict().getName()%>, <%=r.getProvince().getName()%></span>
								</div>
								<div class='card-info__contact'>
									<div class='card-published-info'>Đăng 5 ngày trước</div>
									<div class='card-contact-button__favorite'
										value="<%=r.getRealEstateId()%>">
										<i class='fa-regular fa-heart'
											style="display: <%=r.getFavourite().size() > 0 ? "none" : "block"%>;"></i>
										<i class="fa-solid fa-heart"
											style="color: #e03c31;display: <%=r.getFavourite().size() > 0 ? "block" : "none"%>;"></i>
									</div>
								</div>
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
		</div>
	</div>
	<%@ include file="../../components/footer.jsp"%>
	
	<script type="text/javascript">
	$(document).ready(function() {
		<%
		if (user != null) {
		%>
		// HANDLE ADD TO FAVOURITE
	    $(".card-contact-button__favorite").on("click", function(e) {
	    	e.preventDefault();
	        var regularHeartIcon = $(this).find(".fa-regular.fa-heart");
	        var solidHeartIcon = $(this).find(".fa-solid.fa-heart");
	        if (regularHeartIcon.css("display") === "block") {
	        	regularHeartIcon.css("display", "none");
	        	solidHeartIcon.css("display", "block");
	        } else {
	        	regularHeartIcon.css("display", "block");
	        	solidHeartIcon.css("display", "none");
	        }
	        
	        var realEstateId = $(this).attr("value");
	        $.ajax({
				type: 'GET',
				url: '${pageContext.servletContext.contextPath}/addToFavourite.html',
				data: {realEstateId: realEstateId},
				dataType: 'text',
				success: function(data) {
					console.log("Thêm thành công");
				},
				error: function(xhr, status, error) {
					console.log("Thêm thất bại")
				}
			});
	    });
		<% } %>
	})
	</script>
</body>
</html>