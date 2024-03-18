<%@ page pageEncoding="utf-8"%>
<link rel="stylesheet" href="css/header.css" type="text/css">

<header class='header'>
	<div class='header-container'>
		<div class='header-menu'>
			<div class='left-menu'>
				<a href='#'> <img
					src='https://staticfile.batdongsan.com.vn/images/logo/standard/red/logo.svg'
					alt='' />
				</a>
			</div>
			<div class='right-menu'>
				<ul class='menu-container'>
					<li class='menu__item'>Nhà đất bán
						<ul class='list-container'>
							<li>Bán căn hộ chung cư</li>
							<li>Bán nhà riêng</li>
							<li>Bán nhà, biệt thự liền kề</li>
							<li>Bán nhà mặt phố</li>
							<li>Bán shophouse, nhà phố thương mại</li>
							<li>Bán đất nền dự án</li>
						</ul>
					</li>
					<li class='menu__item'>Nhà đất cho thuê
						<ul class='list-container'>
							<li>Bán căn hộ chung cư</li>
							<li>Bán nhà riêng</li>
							<li>Bán nhà, biệt thự liền kề</li>
							<li>Bán nhà mặt phố</li>
							<li>Bán shophouse, nhà phố thương mại</li>
							<li>Bán đất nền dự án</li>
						</ul>
					</li>
					<li class='menu__item'>Dự án
						<ul class='list-container'>
							<li>Bán căn hộ chung cư</li>
							<li>Bán nhà riêng</li>
							<li>Bán nhà, biệt thự liền kề</li>
							<li>Bán nhà mặt phố</li>
							<li>Bán shophouse, nhà phố thương mại</li>
							<li>Bán đất nền dự án</li>
						</ul>
					</li>
					<li class='menu__item'>Tin tức</li>
					<li class='menu__item'>Wiki BDS
						<ul class='list-container'>
							<li>Bán căn hộ chung cư</li>
							<li>Bán nhà riêng</li>
							<li>Bán nhà, biệt thự liền kề</li>
							<li>Bán nhà mặt phố</li>
							<li>Bán shophouse, nhà phố thương mại</li>
							<li>Bán đất nền dự án</li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
		
		<div class='control-menu'>
          <i
            class='fa-regular fa-heart'
            data-toggle='tooltip'
            data-placement='bottom'
            title='Danh sách tin đã lưu'
          ></i>
          <div class='user-option-container'>
            <a href='#' class='main-button'>
              Đăng nhập
            </a>
            <span class='line'></span>
            <a href='#' class='main-button'>
              Đăng ký
            </a>
          </div>
          <div class='postProduct__button main-button'>
            <a href='#'>Đăng tin</a>
          </div>
        </div>
		
		<!-- <div class='control-menu logined'>
			<i class='fa-regular fa-heart'></i> <i class='fa-regular fa-bell'>
			</i>
			<div class='user-option-container'>
				<span class='avatar'>
					<h3>U</h3>
				</span> <span>user2699702</span> <i class='fa-solid fa-angle-down'></i>

				<div class='model-container'>
					<div class='model-item'>
						<i class='fa-solid fa-list-ul'></i> <span>Quản lý tin đăng</span>
					</div>
					<div class='model-item'>
						<i class='fa-solid fa-list-ul'></i> <span>Thay đổi thông
							tin cá nhân</span>
					</div>
					<div class='model-item'>
						<i class='fa-solid fa-list-ul'></i> <span>Thay đổi mật khẩu</span>
					</div>
					<div class='model-item'>
						<i class='fa-solid fa-list-ul'></i> <span>Nạp tiền</span>
					</div>
					<div class='model-item'>
						<i class='fa-solid fa-list-ul'></i> <span>Đăng xuất</span>
					</div>
				</div>
			</div>
			<div class='postProduct__button main-button'>
				<a href='#'>Đăng tin</a>
			</div>
		</div> -->
	</div>

	<!-- 
	<form action='#'>
        <div class='search-bar'>
          <div class='search-bar__tab'>
            <a href='#' class='tab-box'>
              Bán
            </a>
            <a href='#' class='tab-box tab-box--actived'>
              Cho thuê
            </a>
          </div>
          <div class='search-bar__input'>
            <i class='fa-solid fa-magnifying-glass'></i>
            <input type='text' />
          </div>
          <div class='filter-wall'></div>
          <div class='search-select-container dropdown'>
            <div class=' dropdown-toggle' data-toggle='dropdown'>
              <div class='search-select__item'>
                <span>Loại nhà đất</span>
                <i class='fa-solid fa-chevron-down'></i>
              </div>
              <span>Tất cả</span>
            </div>
            <div class='dropdown-menu'>
              <ul>
                <li>
                  <i class='fa-solid fa-house'></i>
                  <span>Tất cả nhà đất</span>
                </li>
                <li>
                  <i class='fa-regular fa-building'></i>
                  <span>Căn hộ trung cư</span>
                </li>
              </ul>
              <div class='list-search-select-footer'>
                <div class='list-search-select__reset-button'>
                  <i class='fa-solid fa-rotate'></i>
                  <span>Đặt lại</span>
                </div>
                <div class='list-search-select__search-button'>
                  <i class='fa-solid fa-magnifying-glass'></i>
                  <span>Tìm kiếm</span>
                </div>
              </div>
            </div>
          </div>
          <div class='filter-wall'></div>
          <div class='search-select-container dropdown'>
            <div class=' dropdown-toggle' data-toggle='dropdown'>
              <div class='search-select__item'>
                <span>Khu vực & dự án</span>
                <i class='fa-solid fa-chevron-down'></i>
              </div>
              <span>Tất cả</span>
            </div>
            <ul class='dropdown-menu'>
              <li>
                <span>Tất cả nhà đất</span>
              </li>
              <li>
                <span>Căn hộ trung cư</span>
              </li>
            </ul>
          </div>
          <div class='filter-wall'></div>
          <div class='search-select-container dropdown'>
            <div class=' dropdown-toggle' data-toggle='dropdown'>
              <div class='search-select__item'>
                <span>Mức giá</span>
                <i class='fa-solid fa-chevron-down'></i>
              </div>
              <span>Tất cả</span>
            </div>
            <ul class='dropdown-menu'>
              <li>
                <span>Tất cả nhà đất</span>
              </li>
              <li>
                <span>Căn hộ trung cư</span>
              </li>
            </ul>
          </div>
          <div class='filter-wall'></div>
          <div class='search-select-container dropdown'>
            <div class=' dropdown-toggle' data-toggle='dropdown'>
              <div class='search-select__item'>
                <span>Diện tích</span>
                <i class='fa-solid fa-chevron-down'></i>
              </div>
              <span>Tất cả</span>
            </div>
            <ul class='dropdown-menu'>
              <li>
                <span>Tất cả nhà đất</span>
              </li>
              <li>
                <span>Căn hộ trung cư</span>
              </li>
            </ul>
          </div>
          <div class='filter-wall'></div>
          <div class='search-select-container dropdown'>
            <div class=' dropdown-toggle' data-toggle='dropdown'>
              <div class='search-select__item'>
                <span>Lọc thêm</span>
                <i class='fa-solid fa-sliders'></i>
              </div>
            </div>
            <ul class='dropdown-menu'>
              <li>
                <span>Tất cả nhà đất</span>
              </li>
              <li>
                <span>Căn hộ trung cư</span>
              </li>
            </ul>
          </div>
          <div class='filter-wall'></div>
          <div class='search-select-container dropdown'>
            <div class=' dropdown-toggle'>
              <div class='search-select__item'>
                <span>Đặt lại</span>
                <i class='fa-solid fa-rotate'></i>
              </div>
            </div>
          </div>
        </div>
      </form>
	 -->
</header>