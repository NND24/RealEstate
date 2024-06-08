<%@page import="batdongsan.models.EmployeeModel"%>
<%@ page pageEncoding="utf-8"%>

<header class='header'>
      <div class='header-container'>
        <div class='header-menu'>
          <div class='left-menu'>
            <a href='#'>
              <img src='https://staticfile.batdongsan.com.vn/images/logo/standard/red/logo.svg' alt='' />
            </a>
          </div>
        </div>
        <div class='control-menu logined'>
          <div class='user-option-container'>
            <span class='avatar'>
              <h3>U</h3>
            </span>
            <span>${loginEmp.fullname}</span>
            <i class='fa-solid fa-angle-down'></i>

            <div class='model-container'>
              <div class='model-item'>
              	<span><strong>Mã nhân viên: </strong>${loginEmp.id}</span>
              </div>
              <div class='model-item'>
                <span><strong>Họ và tên: </strong>${loginEmp.fullname}</span>
              </div>
              <div class='model-item'>
                <i class="fa-regular fa-id-card"></i>
                <span>Thông tin cá nhân</span>
              </div>
              <div class='model-item'>
                <i class="fa-solid fa-key"></i>
                <span>Thay đổi mật khẩu</span>
              </div>
              <div class='model-item'>
                <i class="fa-solid fa-right-from-bracket" style="color: #ff0000;"></i>
                <span style = "color: red;">Đăng xuất</span>
              </div>
            </div>
          </div>
        </div>
      </div>

    </header>