<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Website số 1 về bất động sản</title>
<link rel="stylesheet" href="../css/client/index.css" type="text/css">
<link rel="stylesheet" href="../css/client/header.css" type="text/css">
<link rel="stylesheet" href="../css/client/sellernet.css"
	type="text/css">
<link rel="stylesheet" href="../css/client/manageAccount.css?version=60"
	type="text/css">
<%@ include file="../../../../links/links.jsp"%>
<base href="${pageContext.servletContext.contextPath}/">
</head>
<body>
	<%@ include file="../../../components/header.jsp"%>
	<div class='sellernet'>
		<%@ include file="../../../components/sellernetSidebar.jsp"%>

		<!-- ManageAccount -->
		<div class='manage-account'>
			<div class='content-container'>
				<h1>Quản lý tài khoản</h1>
				<div class='post-container'>
					<%
					String edit = (String) request.getAttribute("edit");
					String setting = (String) request.getAttribute("setting");
					%>
					<ul class='nav nav-tabs'>
						<li <%if (edit != null && !edit.isEmpty()) {%> class='active'
							<%}%>><a data-toggle='tab' href='#edit'>Chỉnh
								sửa thông tin </a></li>
						<li <%if (setting != null && !setting.isEmpty()) {%>
							class='active' <%}%>><a data-toggle='tab'
							href='#setting'> Cài đặt tài khoản</a></li>
					</ul>

					<div class='tab-content'>
						<form:form action="sellernet/updateAccount.html" modelAttribute="user"
							method="post" enctype="multipart/form-data" id='edit'
							class='tab-pane fade'>
							<div class='input-wrapper'>
								<h3>Thông tin cá nhân</h3>
								<div class='avatar-container'>
									<div class="image-wrapper">
										<img src="<%=user.getAvatar()%>" />
										<i class="fa-solid fa-xmark remove-img"></i>
									</div>
									<label class='avatar__label' for="avatarInput" style="display: none;">
										<div style="transform: translate(15px, 40px);">
											<i class='fa-solid fa-camera'></i> 
										<span>Tải ảnh</span>
										</div>
										
									</label>
									<input type='file' id='avatarInput' name='userAvatar' style="display: none;" />
								</div>
								<div class='input-container'>
									<div class='form-item'>
										<p>Họ và tên</p>
										<div class='input-wrapper'>
											<form:input path='name' type='text' placeholder='Nhập tên' />
										</div>
									</div>

									<div class='form-item'>
										<p>Mã số thuế cá nhân</p>
										<div class='input-wrapper'>
											<form:input path='taxCode' type='text'
												placeholder='Nhập số đã đăng ký' />
										</div>
									</div>
								</div>
							</div>

							<div class='input-wrapper'>
								<h3>Thông tin liên hệ</h3>
								<div class='input-container'>
									<div class='form-item'>
										<p>Số điện thoại</p>
										<div class='input-wrapper'>
											<form:input path='phonenumber' type='text'
												placeholder='Nhập số điện thoại' />
										</div>
									</div>

									<div class='form-item'>
										<p>Email</p>
										<div class='input-wrapper'>
											<form:input path='email' type='email'
												placeholder='Nhập email' readonly="true" />
										</div>
									</div>
								</div>
							</div>

							<div class='button-wrapper'>
								<div></div>
								<button class='continue-button'>
									<span>Lưu thay đổi</span> <i class='fa-solid fa-angle-right'></i>
								</button>
							</div>
						</form:form>
						<form:form id='setting' class='tab-pane fade'>
							<div class='input-wrapper'>
								<h3>Đổi mật khẩu</h3>
								<div class='input-container'>
									<div class='form-item'>
										<p>Mật khẩu hiện tại</p>
										<div class='input-wrapper'>
											<input type='password' /> <i class='fa-regular fa-eye'></i>
										</div>
									</div>

									<div class='form-item'>
										<p></p>
										<span>Bạn quên mật khẩu</span>
									</div>

									<div class='form-item'>
										<p>Mật khẩu mới</p>
										<div class='input-wrapper'>
											<input type='password' /> <i class='fa-regular fa-eye'></i>
										</div>
									</div>

									<div class='form-item'>
										<span></span>
									</div>

									<div class='form-item'>
										<p>Nhập lại mật khẩu mới</p>
										<div class='input-wrapper'>
											<input type='password' /> <i class='fa-regular fa-eye'></i>
										</div>
									</div>

									<div class='form-item'>
										<p></p>
										<button>Lưu thay đổi</button>
									</div>
								</div>
								<ul>
									<li>Mật khẩu tối thiểu 8 ký tự</li>
									<li>Chứa ít nhất 1 ký tự viết hoa</li>
									<li>Chứa ít nhất 1 ký tự số</li>
								</ul>
							</div>
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		$(document).ready(function() {
			<%if (edit != null && !edit.isEmpty()) {%>
				$("#edit").addClass("active in")
			<%}%>
				
			<%if (setting != null && !setting.isEmpty()) {%>
				$("#setting").addClass("active in")
			<%}%>
			
			$(".remove-img").on("click", () => {
			    $(".image-wrapper").css("display", "none");
			    $(".avatar__label").css("display", "block");
			    
			    $(".remove-img").on("click", () => {
				    $(".image-wrapper").css("display", "none");
				    $(".avatar__label").css("display", "block");
				});
			});
			
			$("#avatarInput").on("change", function() {
			    // Kiểm tra nếu đã chọn một tệp
			    if (this.files && this.files[0]) {
			        var reader = new FileReader();
			        
			        // Đọc tệp hình ảnh và hiển thị nó trong thẻ <img>
			        reader.onload = function(e) {
			            $('.image-wrapper img').attr('src', e.target.result);
			            $('.image-wrapper').show(); // Hiển thị phần tử image-wrapper nếu đang ẩn
			        };
			        
			        // Đọc dữ liệu của tệp hình ảnh
			        reader.readAsDataURL(this.files[0]);
			        

				    $(".image-wrapper").css("display", "block");
				    $(".avatar__label").css("display", "none");
			    }
			});

		})
	</script>
</body>
</html>