<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Spring MVC</title>
<link rel="stylesheet" href="css/client/header.css" type="text/css">
<link rel="stylesheet" href="css/client/sell.css" type="text/css">
<%@ include file="../../../links/links.jsp"%>
</head>
<body>
	<%@ include file="../../components/header.jsp"%>
	<div class="sell">
		<div class='container '>
			<div class='row'>
				<div class='sell-content col-lg-9'>
					<div class='breadcrumb'>
						<a href=''>Cho thuê</a> <span> / </span> <a href=''>Tất cả BĐS
							trên toàn quốc</a>
					</div>
					<h3 class='sell-content__title'>Cho thuê nhà đất trên
						toàn quốc</h3>
					<div class='sell-content__navbar'>
						<span class='total-count'>Hiện có 30.549 bất động sản.</span>
						<div class='navbar-filter dropdown'>
							<div class=' dropdown-toggle' data-toggle='dropdown'>
								<span>Thông thường</span> <i
									class='fa-solid fa-chevron-down'></i>
							</div>
							<ul class='dropdown-menu'>
								<li><span>Thông thường</span></li>
								<li><span>Tin xác thực xếp trước</span></li>
								<li><span>Tin mới nhất</span></li>
								<li><span>Giá thấp đến cao</span></li>
								<li><span>Giá cao đến thấp</span></li>
								<li><span>Diện tích bé đến lớn</span></li>
								<li><span>Diện tích lớn đến bé</span></li>
							</ul>
						</div>
					</div>

					<!-- CARD -->
					<div class='product-card'>
						<div class='card-img-container'>
							<img src="" alt='' class='image-1' /> <img src=""
								alt='' class='image-2' /> <img src="" alt=''
								class='image-3' /> <img src="" alt=''
								class='image-4' />

							<div class='card-image-feature'>
								<i class='fa-regular fa-image'></i> <span>9</span>
							</div>
						</div>
						<div class='card-info-container'>
							<div class='card-info-content'>
								<h3 class='card-info__title'>BẢNG GIÁ CHUẨN CẬP NHẬT
									MỚI NHẤT T2/2024 QUỸ HÀNG 50 NĂM VÀ LÂU DÀI, CAM KẾT K BÁO GIÁ
									ẢO CÂU KHÁCH</h3>
								<div class='card-info__detail'>
									<div class='card-config'>
										<span class='card-config__item card-config__price'>3,6
											tỷ</span> <span class='card-config__item card-config__dot'>·</span>
										<span class='card-config__item card-config__area'>92
											m²</span> <span class='card-config__item card-config__dot'>·</span>
										<span class='card-config__item'>39,13 tr/m²</span> <span
											class='card-config__item card-config__dot'>·</span> <span
											class='card-config__item'> <span>3</span> <i
											class='fa-solid fa-bed'></i>
										</span> <span class='card-config__item card-config__dot'>·</span>
										<span class='card-config__item'> <span>2</span> <i
											class='fa-solid fa-bath'></i>
										</span> <span class='card-config__item card-config__dot'>·</span>
									</div>
									<span class='card-location'>Hà Đông, Hà Nội</span>
								</div>
								<div class='card-description'>Chính sách chiết khấu
									theo hình thức thanh toán 10%, tặng kèm gói quà tặng 250tr trừ
									thẳng giá hợp đồng. Đóng trước 30% đến khi nhận nhà, NH hỗ trợ
									70% lãi suất 0% trong 18 thángThông tin chủ đầu tư và pháp
									lý:Chủ đầu tư dự án là Liên danh công ty: Công ty Tập đoàn Phát
									triển nhà và Đô thị Thăng Long Việt Nam và Công ty CP thiết bị
									Thủy lợi (HESCO).Đơn vị thi công phần ngầm Liên danh nhà thầu:
									Công ty cổ phần Contrexim số 1 (tòa nhà Sông Đà Cầu G...)</div>
							</div>
						</div>
						<div class='card-contact-container'>
							<div class='card-published-info'>
								<img src="" alt='' class='card-published-info__avatar' />
								<div>
									<div class='card-published-info__name'>Tiến Hoàng
										Nguyễn</div>
									<div class='card-published-info__update-time'>Đăng
										hôm nay</div>
								</div>
							</div>
							<div class='card-contact-button-container'>
								<div class='card-contact-button__phonenumber'>
									<i class='fa-solid fa-phone-volume'></i> <span>0912
										345 679</span> <span
										class='card-contact-button__phonenumber__dot'>·</span> <span>Hiện
										số</span>
								</div>
								<div class='card-contact-button__favorite'>
									<i class='fa-regular fa-heart'></i>
								</div>
							</div>
						</div>
						<div class='card-label-img'></div>
					</div>
				</div>

				<div class='sell-sidebar col-lg-3'>
					<div class='sidebar-box'>
						<h5 class='sidebar-box__title'>Lọc theo khỏa giá</h5>
						<ul class='sidebar-box__content'>
							<li class='sidebar-box__item'><a href='#'>Thỏa thuận</a>
							</li>
							<li class='sidebar-box__item'><a>Dưới 500 triệu</a></li>
							<li class='sidebar-box__item'><a>500 - 800 triệu</a></li>
							<li class='sidebar-box__item'><a>800 triệu - 1 tỷ</a></li>
							<li class='sidebar-box__item'><a>1 - 2 tỷ</a></li>
						</ul>
					</div>

					<div class='sidebar-box'>
						<h5 class='sidebar-box__title'>Lọc theo diện tích</h5>
						<ul class='sidebar-box__content'>
							<li class='sidebar-box__item'><a href='#'>Thỏa thuận</a>
							</li>
							<li class='sidebar-box__item'><a>Dưới 500 triệu</a></li>
							<li class='sidebar-box__item'><a>500 - 800 triệu</a></li>
							<li class='sidebar-box__item'><a>800 triệu - 1 tỷ</a></li>
							<li class='sidebar-box__item'><a>1 - 2 tỷ</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="../../components/footer.jsp"%>
</body>
</html>