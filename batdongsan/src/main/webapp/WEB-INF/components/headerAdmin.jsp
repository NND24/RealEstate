<%@page import="batdongsan.models.EmployeeModel"%>
<%@ page pageEncoding="utf-8"%>

<header class='header'>
	<div class='header-container'>
		<div class='header-menu'>
			<div class='left-menu'>
				<a href='#'> <img
					src='https://staticfile.batdongsan.com.vn/images/logo/standard/red/logo.svg'
					alt='' />
				</a>
			</div>
		</div>
		<div class='control-menu logined'>
			<div class='user-option-container'>
				<span class='avatar'>
					<h3>U</h3>
				</span> <span>${loginEmp.fullname}</span> <i class='fa-solid fa-angle-down'></i>

				<div class='model-container'>
					<div class='model-item'>
						<span><strong>Mã nhân viên: </strong>${loginEmp.id}</span>
					</div>
					<div class='model-item'>
						<span><strong>Họ và tên: </strong>${loginEmp.fullname}</span>
					</div>
					<div class='model-item' id="show-detail-info">
						<i class="fa-regular fa-id-card"></i> <span>Thông tin cá
							nhân</span>
					</div>
					<a href="logout.html">
						<div class='model-item'>
							<i class="fa-solid fa-right-from-bracket" style="color: #ff0000;"></i>
							<span style="color: red;">Đăng xuất</span>
						</div>
					</a>

				</div>
			</div>
		</div>
	</div>


	<!-- Detail Info -->
	<div class='add-modal' style="display: none;" id="detail-info-form">
		<div class='modal-wrapper'>
			<div class='modal-container'>
				<h1>Thông tin cá nhân</h1>
				${message}
				<form>
					<div class='input-container'>
						<div class='form-item'>
							<p>Mã nhân viên</p>
							<div class='input-wrapper'>
								<input type="text" value="${loginEmp.id}" readonly />
							</div>
						</div>
						<div class='form-item'>
							<p>Họ và tên</p>
							<div class='input-wrapper'>
								<input type="text" value="${loginEmp.fullname}" readonly />
							</div>
						</div>
					</div>

					<div class='input-container'>
						<div class='form-item'>
							<p>Email</p>
							<div class='input-wrapper'>
								<input type="text" value="${loginEmp.email}" readonly />
							</div>
						</div>
						<div class='form-item'>
							<p>Căn cước công dân</p>
							<div class='input-wrapper'>
								<input type="text" value="${loginEmp.cccd}" readonly />
							</div>
						</div>
					</div>

					<div class='input-container'>
						<div class='form-item'>
							<p>Ngày sinh</p>
							<div class='input-wrapper'>
								<input type="text" value="${loginEmp.birthday}" readonly />
							</div>
						</div>
						<div class='form-item'>
							<p>Địa chỉ</p>
							<div class='input-wrapper'>
								<input type="text" value="${loginEmp.address}" readonly />
							</div>
						</div>
					</div>

					<div class='input-container'>
						<div class='form-item'>
							<p>Số điện thoại</p>
							<div class='input-wrapper'>
								<input type="text" value="${loginEmp.phoneNumber}" readonly />
							</div>
						</div>
						<div class='form-item'>
							<p>Ngày vào làm</p>
							<div class='input-wrapper'>
								<input type="text" value="${loginEmp.createDate}" readonly />
							</div>
						</div>
					</div>

				</form>

			</div>
		</div>
		<button class='close-btn' id="closeDetailButton">
			<i class='fa-solid fa-xmark'></i>
		</button>
	</div>
	<!-- End -->




</header>

<script type="text/javascript">
	$(document).ready(function() {
		$("#show-detail-info").click(function() {
			$("#detail-info-form").fadeIn();
		});

		$("#closeDetailButton").click(function() {
			$("#detail-info-form").fadeOut();
		});

		$("#change-password").click(function() {
			$("#change-password-form").fadeIn();
		});

		$("#closeChangePassword").click(function() {
			$("#change-password-form").fadeOut();
		});

		$("#showPassword").change(function() {
			var passwordInputs = $(".password-input");
			if ($(this).is(":checked")) {
				passwordInputs.attr("type", "text");
			} else {
				passwordInputs.attr("type", "password");
			}
		});
	});
</script>