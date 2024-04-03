<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Website số 1 về bất động sản</title>
<link rel="stylesheet" href="css/admin/headerAdmin.css" type="text/css">
<link rel="stylesheet" href="css/admin/detail.css" type="text/css">
<%@ include file="../../../links/links.jsp"%>
</head>
<body>
	<%@ include file="../../components/headerAdmin.jsp"%>
	<div class='admin active'>
		<div class='sidebar '>
			<div class='open-close-button'>
				<i class='fa-solid fa-chevron-left'></i>
			</div>
			<div class='sidebar-wrapper'>
				<div class='panel-group'>
					<div class='panel panel-default'>
						<div class='panel-heading'>
							<h4 class='panel-title'>
								<a data-toggle='collapse' href='#collapse1'>
									<div>
										<i class='fa-solid fa-list'></i> <span> Quản lý tin
											đăng</span>
									</div> <i class='fa-solid fa-angle-down'></i>
								</a>
							</h4>
						</div>
						<div id='collapse1' class='panel-collapse collapse'>
							<ul class='list-group'>
								<li class='list-group-item'>Đăng mới</li>
								<li class='list-group-item'>Danh sách tin</li>
								<li class='list-group-item'>Tin nháp</li>
							</ul>
						</div>
					</div>
				</div>

				<div class='panel-group'>
					<div class='panel panel-default'>
						<div class='panel-heading'>
							<h4 class='panel-title'>
								<a data-toggle='collapse' href='#collapse2'>
									<div>
										<i class='fa-solid fa-coins'></i> <span> Quản lý tài
											chính</span>
									</div> <i class='fa-solid fa-angle-down'></i>
								</a>
							</h4>
						</div>
						<div id='collapse2' class='panel-collapse collapse'>
							<ul class='list-group'>
								<li class='list-group-item'>Thông tin số dư</li>
								<li class='list-group-item'>Lịch sử giao dịch</li>
								<li class='list-group-item'>Nạp tiền vào tài khoản</li>
							</ul>
						</div>
					</div>
				</div>

				<div class='panel-group'>
					<div class='panel panel-default'>
						<div class='panel-heading'>
							<h4 class='panel-title'>
								<a data-toggle='collapse' href='#collapse3'>
									<div>
										<i class='fa-solid fa-paperclip'></i> <span>Báo giá &
											hướng dẫn</span>
									</div> <i class='fa-solid fa-angle-down'></i>
								</a>
							</h4>
						</div>
						<div id='collapse3' class='panel-collapse collapse'>
							<ul class='list-group'>
								<li class='list-group-item'>Báo giá</li>
								<li class='list-group-item'>Hướng dẫn thanh toán</li>
								<li class='list-group-item'>Hướng dẫn sử dụng</li>
							</ul>
						</div>
					</div>
				</div>

				<div class='panel-group'>
					<div class='panel panel-default'>
						<div class='panel-heading'>
							<h4 class='panel-title'>
								<a data-toggle='collapse' href='#collapse4'>
									<div>
										<i class='fa-solid fa-gear'></i> <span>Tiện ích</span>
									</div> <i class='fa-solid fa-angle-down'></i>
								</a>
							</h4>
						</div>
						<div id='collapse4' class='panel-collapse collapse'>
							<ul class='list-group'>
								<li class='list-group-item'>Thông báo</li>
								<li class='list-group-item'>Quản lý đăng ký nhận email</li>
								<li class='list-group-item'>Yêu cầu khóa tài khoản</li>
							</ul>
						</div>
					</div>
				</div>
			</div>

			<div class='collapse-container collapse-container-1'>
				<ul class='list-group'>
					<li class='list-group-item'>Đăng mới</li>
					<li class='list-group-item'>Danh sách tin</li>
					<li class='list-group-item'>Tin nháp</li>
				</ul>
			</div>

			<div class='collapse-container collapse-container-2'>
				<ul class='list-group'>
					<li class='list-group-item'>Đăng mới</li>
					<li class='list-group-item'>Danh sách tin</li>
					<li class='list-group-item'>Tin nháp</li>
				</ul>
			</div>

			<div class='collapse-container collapse-container-3'>
				<ul class='list-group'>
					<li class='list-group-item'>Đăng mới</li>
					<li class='list-group-item'>Danh sách tin</li>
					<li class='list-group-item'>Tin nháp</li>
				</ul>
			</div>
		</div>

		<!-- Detail -->
		<div class='detail'>
			<div class='container '>
				<div class='row'>
					<!-- Content -->
					<div class='detail-content col-lg-9'>
						<div class='swiper mySwiper2'>
							<div class='swiper-wrapper'>
								<div class='swiper-slide'>
									<img src='https://swiperjs.com/demos/images/nature-1.jpg' />
								</div>
								<div class='swiper-slide'>
									<img src='https://swiperjs.com/demos/images/nature-2.jpg' />
								</div>
								<div class='swiper-slide'>
									<img src='https://swiperjs.com/demos/images/nature-3.jpg' />
								</div>
								<div class='swiper-slide'>
									<img src='https://swiperjs.com/demos/images/nature-4.jpg' />
								</div>
								<div class='swiper-slide'>
									<img src='https://swiperjs.com/demos/images/nature-5.jpg' />
								</div>
								<div class='swiper-slide'>
									<img src='https://swiperjs.com/demos/images/nature-6.jpg' />
								</div>
								<div class='swiper-slide'>
									<img src='https://swiperjs.com/demos/images/nature-7.jpg' />
								</div>
								<div class='swiper-slide'>
									<img src='https://swiperjs.com/demos/images/nature-8.jpg' />
								</div>
								<div class='swiper-slide'>
									<img src='https://swiperjs.com/demos/images/nature-9.jpg' />
								</div>
								<div class='swiper-slide'>
									<img src='https://swiperjs.com/demos/images/nature-10.jpg' />
								</div>
							</div>
							<div class='swiper-button-next'></div>
							<div class='swiper-button-prev'></div>
							<div class='swiper-pagination'></div>
						</div>
						<div thumbsSlider='' class='swiper mySwiper'>
							<div class='swiper-wrapper'>
								<div class='swiper-slide'>
									<img src='https://swiperjs.com/demos/images/nature-1.jpg' />
								</div>
								<div class='swiper-slide'>
									<img src='https://swiperjs.com/demos/images/nature-2.jpg' />
								</div>
								<div class='swiper-slide'>
									<img src='https://swiperjs.com/demos/images/nature-3.jpg' />
								</div>
								<div class='swiper-slide'>
									<img src='https://swiperjs.com/demos/images/nature-4.jpg' />
								</div>
								<div class='swiper-slide'>
									<img src='https://swiperjs.com/demos/images/nature-5.jpg' />
								</div>
								<div class='swiper-slide'>
									<img src='https://swiperjs.com/demos/images/nature-6.jpg' />
								</div>
								<div class='swiper-slide'>
									<img src='https://swiperjs.com/demos/images/nature-7.jpg' />
								</div>
								<div class='swiper-slide'>
									<img src='https://swiperjs.com/demos/images/nature-8.jpg' />
								</div>
								<div class='swiper-slide'>
									<img src='https://swiperjs.com/demos/images/nature-9.jpg' />
								</div>
								<div class='swiper-slide'>
									<img src='https://swiperjs.com/demos/images/nature-10.jpg' />
								</div>
							</div>
						</div>

						<div class='breadcrumb'>
							<a href=''>Cho thuê</a> <span> / </span> <a href=''>Hồ Chí
								Minh</a> <span> / </span> <a href=''>Tất cả BĐS trên toàn quốc</a>
						</div>
						<h3 class='detail-content__title'>Phòng trọ full nội thất
							đường Gò Cẩm Đệm, P. 10, Q. Tân Bình, gần ngã tư Âu Cơ - Lạc Long
							Quân</h3>
						<p class='detail-content__address'>13/1C, Đường Gò Cẩm
							Đệm, Phường 10, Tân Bình, Hồ Chí Minh</p>
						<div class='short-info-container'>
							<div>
								<div class='short-info__item'>
									<span class='title'>Mức giá</span> <span class='value'>4
										triệu/tháng</span>
								</div>
								<div class='short-info__item'>
									<span class='title'>Diện tích</span> <span
										class='value'>14 m²</span>
								</div>
							</div>
							<div>
								<a href='' class='short-info__button'> <i
									class='fa-solid fa-share-nodes'></i>
								</a> <a href='' class='short-info__button'> <i
									class='fa-solid fa-triangle-exclamation'></i>
								</a> <a href='' class='short-info__button'> <i
									class='fa-regular fa-heart'></i>
								</a>
							</div>
						</div>
						<div class='description-container'>
							<div class='section-title'>Thông tin mô tả</div>
							<div class='description-body'>
								Căn hộ mini 14m², tầng đất không phải leo cầu thang với trang
								thiết bị đầy đủ: <br />- Máy lạnh - định kỳ vệ sinh 4 tháng 1
								lần miễn phí.
							</div>
						</div>
						<div class='spec-container'>
							<div class='section-title'>Đặc điểm bất động sản</div>
							<div class='row'>
								<div class='spec-content-item col-lg-6'>
									<i class='fa-regular fa-square spec-content-item__icon'></i>
									<div class='spec-content-item__title'>Diện tích</div>
									<div class='spec-content-item__value'>14 m²</div>
								</div>
								<div class='spec-content-item col-lg-6'>
									<i class='fa-solid fa-dong-sign spec-content-item__icon'></i>
									<div class='spec-content-item__title'>Mức giá</div>
									<div class='spec-content-item__value'>4 triệu/tháng</div>
								</div>
								<div class='spec-content-item col-lg-6'>
									<i class='fa-solid fa-bath spec-content-item__icon'></i>
									<div class='spec-content-item__title'>Số toilet</div>
									<div class='spec-content-item__value'>1 phòng</div>
								</div>
								<div class='spec-content-item col-lg-6'>
									<i class='fa-solid fa-couch spec-content-item__icon'></i>
									<div class='spec-content-item__title'>Nội thất</div>
									<div class='spec-content-item__value'>1 phòng</div>
								</div>
							</div>
						</div>
						<div class='search-tag-container'>
							<div class='section-title'>Tìm kiếm theo từ khóa</div>
							<div class='search-tag-list'>
								<a href='' class='search-tag-item'> Thuê trọ phường 10
									Tân Bình </a> <a href='' class='search-tag-item'> Thuê trọ
									Gò Cẩm Đệm Tân Bình </a> <a href='' class='search-tag-item'>
									Thuê trọ Tân Bình Hồ Chí Minh </a> <a href=''
									class='search-tag-item'> Thuê trọ Hồ Chí Minh </a> <a
									href='' class='search-tag-item'> Thuê căn hộ mini Hồ
									Chí Minh </a>
							</div>
						</div>
						<div class='short-info-container'>
							<div>
								<div class='short-info__item'>
									<span class='title'>Ngày đăng</span> <span
										class='value'>23/02/2024</span>
								</div>
								<div class='short-info__item'>
									<span class='title'>Ngày hết hạn</span> <span
										class='value'>09/03/2024</span>
								</div>
								<div class='short-info__item'>
									<span class='title'>Loại tin</span> <span class='value'>Tin
										VIP Bạc</span>
								</div>
								<div class='short-info__item'>
									<span class='title'>Mã tin</span> <span class='value'>38842695</span>
								</div>
							</div>
						</div>
					</div>

					<!-- Sidebar -->
					<div class='detail-sidebar col-lg-3'>
						<div class='sidebar-box-contact'>
							<img class='contact-avatar' src={avatar} alt='' />
							<p>Được đăng bởi</p>
							<h5 class='contact-name'>Vu Thi Kim Diep</h5>
							<div class='contact-button contact-button__phonenumber'>
								<span>0912 345 679</span> <span
									class='contact-button__phonenumber__dot'>·</span> <span>Hiện
									số</span>
							</div>
							<div class='contact-button'>
								<span>Chat qua zalo</span>
							</div>
							<div class='contact-button'>
								<span>Gửi email</span>
							</div>
							<div class='contact-button'>
								<span>Yêu cầu liên hệ lại</span>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		var swiper = new Swiper(".mySwiper", {
			spaceBetween : 10,
			slidesPerView : 6,
			freeMode : true,
			watchSlidesProgress : true,
		});
		var swiper2 = new Swiper(".mySwiper2", {
			spaceBetween : 10,
			navigation : {
				nextEl : ".swiper-button-next",
				prevEl : ".swiper-button-prev",
			},
			thumbs : {
				swiper : swiper,
			},
			pagination : {
				el : ".swiper-pagination",
				type : "fraction",
			},
		});
		var swiper3 = new Swiper(".mySwiper3", {
			slidesPerView : 3,
			spaceBetween : 15,
			navigation : {
				nextEl : ".swiper-button-next",
				prevEl : ".swiper-button-prev",
			},
		});
	</script>
</body>
</html>

