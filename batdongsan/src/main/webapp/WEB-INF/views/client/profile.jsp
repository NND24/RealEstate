<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Website số 1 về bất động sản</title>
<link rel="stylesheet" href="css/client/header.css" type="text/css">
<link rel="stylesheet" href="css/client/profile.css" type="text/css">
<%@ include file="../../../links/links.jsp"%>
</head>
<body>
	<%@ include file="../../components/header.jsp"%>
	<div>
		<div className='profile'>
			<img src={cover} className='coverImg' alt='' />
			<div className='container'>
				<div className='info-container'>
					<img src={avatar} alt='' />
					<div>
						<h5 className='name'>Đạt Nguyễn</h5>
						<div className='button-container'>
							<button>
								<i className='fa-solid fa-phone-volume'></i> <span>093501****
									∙ Hiện số</span>
							</button>
						</div>
					</div>
				</div>
				<div className='product-container'>
					<h3 className='heading'>Danh sách tin đăng bán (32)</h3>
					<div className='row gx-5 gy-5'>
						<div className='sale-card col-lg-3 col-md-4 col-sm-6 col-xs-2'>
							<div className='card-image'>
								<img src={home} alt='' />
								<div className='card-image-feature'>
									<i className='fa-regular fa-image'></i> <span>6</span>
								</div>
							</div>
							<div className='card-info-container'>
								<div className='card-info__title'>Thuê phòng trọ mới xây
									đường Lý Thường Kiệt, gần ĐH Bách Khoa, giờ giấc tự do, giá
									2tr5/th</div>
								<div className='card-info__config'>
									<span className='card-config__item card-config__price'>3,6
										tỷ</span> <span className='card-config__item card-config__dot'>·</span>
									<span className='card-config__item card-config__area'>92
										m²</span>
								</div>
								<div className='card-info__location'>
									<i className='fa-solid fa-location-dot'></i> <span>Quận
										11, Hồ Chí Minh</span>
								</div>
								<div className='card-info__contact'>
									<div className='card-published-info'>Đăng 5 ngày trước</div>
								</div>
							</div>
						</div>
						<div className='sale-card col-lg-3 col-md-4 col-sm-6 col-xs-2'>
							<div className='card-image'>
								<img src={home} alt='' />
								<div className='card-image-feature'>
									<i className='fa-regular fa-image'></i> <span>6</span>
								</div>
							</div>
							<div className='card-info-container'>
								<div className='card-info__title'>Thuê phòng trọ mới xây
									đường Lý Thường Kiệt, gần ĐH Bách Khoa, giờ giấc tự do, giá
									2tr5/th</div>
								<div className='card-info__config'>
									<span className='card-config__item card-config__price'>3,6
										tỷ</span> <span className='card-config__item card-config__dot'>·</span>
									<span className='card-config__item card-config__area'>92
										m²</span>
								</div>
								<div className='card-info__location'>
									<i className='fa-solid fa-location-dot'></i> <span>Quận
										11, Hồ Chí Minh</span>
								</div>
								<div className='card-info__contact'>
									<div className='card-published-info'>Đăng 5 ngày trước</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div className='product-container'>
					<h3 className='heading'>Danh sách tin đăng cho thuê (4)</h3>
					<div className='row'></div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="../../components/footer.jsp"%>
</body>
</html>