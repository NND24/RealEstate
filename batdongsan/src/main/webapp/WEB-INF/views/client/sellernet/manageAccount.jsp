<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Website số 1 về bất động sản</title>
<link rel="stylesheet" href="../css/client/index.css" type="text/css">
<link rel="stylesheet" href="../css/client/header.css?version=62"
	type="text/css">
<link rel="stylesheet" href="../css/client/sellernet.css?version=64"
	type="text/css">
<link rel="stylesheet" href="../css/client/manageAccount.css?version=64"
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
							<%}%>><a data-toggle='tab' href='#edit'>Chỉnh sửa thông
								tin </a></li>
						<li <%if (setting != null && !setting.isEmpty()) {%>
							class='active' <%}%>><a data-toggle='tab' href='#setting'>
								Cài đặt tài khoản</a></li>
					</ul>

					<div class='tab-content'>
						<form:form action="sellernet/updateAccount.html"
							modelAttribute="user" method="post" enctype="multipart/form-data"
							id='edit' class='tab-pane fade'>
							<div class='input-wrapper'>
								<h3>Thông tin cá nhân</h3>
								<div class='avatar-container'>
									<div class="image-wrapper">
										<img src="images/<%=user.getAvatar()%>" /> <i
											class="fa-solid fa-xmark remove-img"></i>
									</div>
									<label class='avatar__label' for="avatarInput"
										style="display: none;">
										<div style="transform: translate(15px, 40px);">
											<i class='fa-solid fa-camera'></i> <span>Tải ảnh</span>
										</div>

									</label> <input type='file' id='avatarInput' name='userAvatar'
										style="display: none;" />
								</div>
								<div class='input-container'>
									<div class='form-item'>
										<p>Họ và tên</p>
										<div class="${not empty nameError ? 'input-wrapper error-border' : 'input-wrapper'}">
											<form:input path='name' type='text' placeholder='Nhập tên'
											 />
										</div>
										<c:if test="${not empty nameError}">
											<p class="errorMessage">${nameError}</p>
										</c:if>
									</div>

									<div class='form-item'>
										<p>Mã số thuế cá nhân</p>
										<div class="${not empty taxCodeError ? 'input-wrapper error-border' : 'input-wrapper'}">
											<form:input path='taxCode' type='text'
												placeholder='Nhập số đã đăng ký' />
										</div>
										<c:if test="${not empty taxCodeError}">
											<p class="errorMessage">${taxCodeError}</p>
										</c:if>
									</div>
								</div>
							</div>

							<div class='input-wrapper'>
								<h3>Thông tin liên hệ</h3>
								<div class='input-container'>
									<div class='form-item'>
										<p>Số điện thoại</p>
										<div class="${not empty phonenumber ? 'input-wrapper error-border' : 'input-wrapper'}">
											<form:input path='phonenumber' type='text'
												placeholder='Nhập số điện thoại' />
										</div>
										<c:if test="${not empty phonenumberError}">
											<p class="errorMessage">${phonenumberError}</p>
										</c:if>
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
						<form:form action="sellernet/updatePassword.html" method="post"
							id='setting' class='tab-pane fade'>
							<div class='input-wrapper'>
								<h3>Đổi mật khẩu</h3>
								<div class='input-container'>
									<%
									String passwordError = (String) request.getAttribute("passwordError");
									String newPasswordError = (String) request.getAttribute("newPasswordError");
									%>
									<div class='form-item password'>
										<p>Mật khẩu hiện tại</p>
										<div class='input-wrapper'>
											<input name="password" type='password' />
											<div class='button show-pass'>
												<i class='fa-solid fa-eye-slash'></i> <i
													class="fa-solid fa-eye"></i>
											</div>
										</div>
										<%
										if (passwordError != null && !passwordError.isEmpty()) {
										%>
										<p class="errorMessage errorCtrlMessage"><%=passwordError%></p>
										<%
										}
										%>
										<p class="errorMessage password" style="display: none"></p>
									</div>

									<div class='form-item'>
										<p></p>
										<a
											href='${pageContext.servletContext.contextPath}/khoi-phuc-mat-khau.html'>Bạn
											quên mật khẩu</a>
									</div>

									<div class='form-item newPassword'>
										<p>Mật khẩu mới</p>
										<div class='input-wrapper'>
											<input name="newPassword" type='password' />
											<div class='button show-pass'>
												<i class='fa-solid fa-eye-slash'></i> <i
													class="fa-solid fa-eye"></i>
											</div>
										</div>
										<p class="errorMessage" style="display: none"></p>
									</div>

									<div class='form-item'>
										<span></span>
									</div>

									<div class='form-item reNewPassword'>
										<p>Nhập lại mật khẩu mới</p>
										<div class='input-wrapper'>
											<input name="reNewPassword" type='password' />
											<div class='button show-pass'>
												<i class='fa-solid fa-eye-slash'></i> <i
													class="fa-solid fa-eye"></i>
											</div>
										</div>
										<p class="errorMessage" style="display: none"></p>
									</div>

									<div class='form-item'>
										<p></p>
										<button class="update-pass-btn" disabled="disabled">Lưu
											thay đổi</button>
									</div>
								</div>
								<ul>
									<li class="check1">Mật khẩu tối thiểu 8 ký tự</li>
									<li class="check2">Chứa ít nhất 1 ký tự viết hoa</li>
									<li class="check3">Chứa ít nhất 1 ký tự số</li>
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
			
			$(".show-pass").on("click", function() {
			    $(this).toggleClass("show");
			    
			    var passwordField;

			    if ($(this).closest(".form-item").find("input[name='password']").length > 0) {
			        passwordField = $('input[name="password"]');
			    } else if ($(this).closest(".form-item").find("input[name='newPassword']").length > 0) {
			        passwordField = $('input[name="newPassword"]');
			    } else {
			        passwordField = $('input[name="reNewPassword"]');
			    }

			    var currentType = passwordField.attr("type");
			    var newType = currentType === "password" ? "text" : "password";
			    passwordField.attr("type", newType);
			});


			var password = $('input[name="password"]');
			var newPassword = $('input[name="newPassword"]');
			var reNewPassword = $('input[name="reNewPassword"]');

			$('input[type="newPassword"], input[name="reNewPassword"]').on("input", function() {		    
			    if (newPassword.val() !== "" && reNewPassword.val() !== "" && reNewPassword.val() !== newPassword.val()) {
			        $(".reNewPassword .errorMessage").css("display", "block").text("Mật khẩu không trùng khớp");
			        $(".reNewPassword .input-wrapper").css("border-color", "rgb(224, 60, 49)")
			    } else {
			        $(".reNewPassword .errorMessage").css("display", "none").text("");
			        $(".reNewPassword .input-wrapper").css("border-color", "#ccc")
			    }
			    
			    var containsUppercase = /[A-Z]/.test(newPassword.val());
			    var containsNumber = /\d/.test(newPassword.val());
			    
			    if(newPassword.val().length >= 8 && containsUppercase && containsNumber && password.val().trim() !== "" 
			    		&& newPassword.val().trim() !== "" && reNewPassword.val().trim() !== "" && reNewPassword.val() === newPassword.val()) {
			    	 $(".update-pass-btn").css("opacity", "1").prop('disabled', false);
			    } else {
		            $(".update-pass-btn").css("opacity", "0.4").prop('disabled', true);
			    }
			});
			
			newPassword.on("input", function() {
			    if (newPassword.val().length >= 8) {
			        $(".check1").css("color", "rgb(7, 163, 93)");
			    } else {
			        $(".check1").css("color", "rgb(153, 153, 153)");
			    }

			    var containsUppercase = /[A-Z]/.test(newPassword.val());

			    if (containsUppercase) {
			        $(".check2").css("color", "rgb(7, 163, 93)");
			    } else {
			        $(".check2").css("color", "rgb(153, 153, 153)");
			    }

			    var containsNumber = /\d/.test(newPassword.val());

			    if (containsNumber) {
			        $(".check3").css("color", "rgb(7, 163, 93)");
			    } else {
			        $(".check3").css("color", "rgb(153, 153, 153)");
			    }
			});
			
			password.on("input", function() {
				$(".errorCtrlMessage").css("display", "none")
			})

		})
	</script>
</body>
</html>