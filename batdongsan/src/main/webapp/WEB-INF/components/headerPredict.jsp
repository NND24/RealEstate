<%@page import="batdongsan.models.UsersModel"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ page pageEncoding="utf-8"%>

<header class='header'>
	<div class='header-container'>
		<div class='header-menu'>
			<div class='left-menu'>
				<a href='${pageContext.servletContext.contextPath}/trang-chu.html'>
					<img
					src='${pageContext.servletContext.contextPath}/images/logo1.jpg'
					alt='' />
				</a>
			</div>
			<div class='right-menu'>
				<ul class='menu-container'>
					<li class='menu__item'><a
						href="${pageContext.servletContext.contextPath}/nha-dat-ban.html">Nhà
							đất bán</a>
						<ul class='list-container'>
								<c:forEach var="c" items="${categoriesSell}">
								<a
									href="${pageContext.servletContext.contextPath}/nha-dat-ban.html?categoryIds=${c.categoryId}"><li>
										${c.name}</li> </a>
							</c:forEach> 
						</ul></li>
				<!--	<li class='menu__item'><a
						href="${pageContext.servletContext.contextPath}/nha-dat-cho-thue.html">Nhà
							đất cho thuê</a>
						<ul class='list-container'>
							<c:forEach var="c" items="${categoriesRent}">
								<a
									href="${pageContext.servletContext.contextPath}/nha-dat-ban.html?categoryIds=${c.categoryId}"><li>
										${c.name}</li> </a>
							</c:forEach>
						</ul></li> -->
					<li class='menu__item'><a
						href="${pageContext.servletContext.contextPath}/tin-tuc.html">Tin tức</a></li>
					<li class='menu__item' style="border-bottom: 2px solid rgb(228, 54, 54);"><a
					href="${pageContext.servletContext.contextPath}/du-doan-gia-nha.html?categoryId=1">Dự đoán giá bất động sản</a></li>
				</ul>
			</div>
		</div>

		<%
		UsersModel user = (UsersModel) request.getAttribute("user");

		if (user == null) {
		%>
		<div class="control-menu">
			<div class="user-option-container">
				<a href="${pageContext.servletContext.contextPath}/dang-nhap.html"
					class="main-button"> Đăng nhập </a> <span class="line"></span> <a
					href="${pageContext.servletContext.contextPath}/dang-ky.html"
					class="main-button"> Đăng ký </a>
			</div>
		</div>
		<%
		} else {
		%>
		<div class='control-menu logined'>
			<a href="${pageContext.servletContext.contextPath}/tin-da-luu.html">
				<i class='fa-regular fa-heart'></i>
			</a> 
		<!--  	<i class='fa-regular fa-bell'></i> -->
			<div class='user-option-container'>
				<!-- <span class='avatar'>
					<h3>U</h3>
				 </span> -->
				<img class="avatar" alt="" src="${pageContext.servletContext.contextPath}/images/<%=user.getAvatar()%>" /> <span><%=user.getName()%></span>
				<i class='fa-solid fa-angle-down'></i>

				<div class='model-container'>
					<a class='model-item' href="${pageContext.servletContext.contextPath}/sellernet/quan-ly-tin-rao-ban-cho-thue.html">
							<i class='fa-solid fa-list-ul'></i>
							<span>Quản lý tin đăng</span>
					</a>
				
					<a class='model-item' href="${pageContext.servletContext.contextPath}/sellernet/thong-tin-ca-nhan.html?edit=true">
							<i class="fa-regular fa-user"></i>
							<span>Thay đổi thông tin cá nhân</span>
					</a>
				
					<a class='model-item' href="${pageContext.servletContext.contextPath}/sellernet/thong-tin-ca-nhan.html?setting=true">
							<i class="fa-solid fa-lock"></i>
							<span>Thay đổi mật khẩu</span>
					</a>
				
					<a class='model-item' href="${pageContext.servletContext.contextPath}/sellernet/nap-tien.html">
						<i class="fa-regular fa-credit-card"></i>
						<span>Nạp tiền</span>
					</a>
				
					<hr />
				
					<div class='model-item logout'>
						<i class="fa-solid fa-arrow-right-from-bracket"></i>
						<span>Đăng xuất</span>
					</div>
				</div>

			</div>
			<div class='postProduct__button main-button'>
				<a
					href='${pageContext.servletContext.contextPath}/sellernet/dang-tin/ban.html?categoryId=1'>Đăng
					tin</a>
			</div>
		</div>
		<%
		}
		%>

	</div>
</header>
<script type="text/javascript">
$(document).ready(function() {
	$(".user-option-container").on("click", () => {
	    var modelContainer = $(".user-option-container .model-container");
	    
	    // Kiểm tra nếu hiển thị là block thì chuyển thành none, ngược lại chuyển thành block
	    if (modelContainer.css("display") === "block") {
	        modelContainer.css("display", "none");
	    } else {
	        modelContainer.css("display", "block");
	    }
	});
	
	// HANDLE LOGOUT
	$(".logout").on("click", () => {
		$.ajax({
			type: 'GET',
			url: '${pageContext.servletContext.contextPath}/logout.html',
			dataType: 'text', 
			success: function(data) {
				window.location.href = '${pageContext.servletContext.contextPath}/trang-chu.html'
			},
			error: function(xhr, status, error) {
				window.location.href = '${pageContext.servletContext.contextPath}/trang-chu.html'
			}
		});
	})
})
</script>