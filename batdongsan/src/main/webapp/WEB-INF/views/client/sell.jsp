<%@page import="batdongsan.models.RealEstateModel"%>
<%@page import="java.util.List"%>
<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Spring MVC</title>
<link rel="stylesheet" href="css/client/index.css" type="text/css">
<link rel="stylesheet" href="css/client/header.css" type="text/css">
<link rel="stylesheet" href="css/client/sell.css" type="text/css">
<link rel="stylesheet" href="css/client/footer.css" type="text/css">
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
					<h3 class='sell-content__title'>Cho thuê nhà đất trên toàn
						quốc</h3>
					<div class='sell-content__navbar'>
						<span class='total-count'>Hiện có 30.549 bất động sản.</span>
						<div class='navbar-filter dropdown'>
							<div class=' dropdown-toggle' data-toggle='dropdown'>
								<span>Thông thường</span> <i class='fa-solid fa-chevron-down'></i>
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
					<%
					// Lấy danh sách bất động sản từ phía server
					List<RealEstateModel> realEstates = (List<RealEstateModel>) request.getAttribute("realEstates");

					// Kiểm tra và hiển thị danh sách bất động sản
					if (realEstates != null) {
						for (RealEstateModel r : realEstates) {
							String imageString = (String) r.getImages(); // Lưu ý ép kiểu sang String

							// Kiểm tra xem chuỗi hình ảnh có rỗng không
							if (imageString != null && !imageString.isEmpty()) {
						// Xóa dấu ngoặc vuông ở hai đầu chuỗi
						imageString = imageString.substring(1, imageString.length() - 1);

						// Tách chuỗi theo dấu phẩy và khoảng trắng
						String[] imagePaths = imageString.split(", ");
					%>
					<div class='product-card'>
						<div class='card-img-container'>
							<img src="<%=imagePaths[0]%>" alt='' class='image-1' /> <img
								src="<%=imagePaths[0]%>" alt='' class='image-2' /> <img
								src="<%=imagePaths[0]%>" alt='' class='image-3' /> <img
								src="<%=imagePaths[0]%>" alt='' class='image-4' />

							<div class='card-image-feature'>
								<i class='fa-regular fa-image'></i> <span><%=imagePaths.length%></span>
							</div>
						</div>

						<div class='card-info-container'>
							<div class='card-info-content'>
								<h3 class='card-info__title'><%=r.getTitle()%></h3>
								<div class='card-info__detail'>
									<div class='card-config'>
										<span class='card-config__item card-config__price'><%=r.getPrice()%>
											<%=r.getUnit()%></span> <span
											class='card-config__item card-config__dot'>·</span> <span
											class='card-config__item card-config__area'><%=r.getArea()%>
											m²</span>
										<%
										if (r.getNumberOfBedrooms() > 0) {
										%>
										<span class='card-config__item card-config__dot'>·</span> <span
											class='card-config__item'> <span><%=r.getNumberOfBedrooms()%></span>
											<i class='fa-solid fa-bed'></i>
										</span>
										<%
										}
										%>
										<%
										if (r.getNumberOfBedrooms() > 0) {
										%>
										<span class='card-config__item card-config__dot'>·</span> <span
											class='card-config__item'> <span><%=r.getNumberOfToilets()%></span>
											<i class='fa-solid fa-bath'></i>
										</span>
										<%
										}
										%>
										<span class='card-config__item card-config__dot'>·</span>
									</div>
									<span class='card-location'><%=r.getWard().getName()%>, <%=r.getDistrict().getName()%>,
										<%=r.getProvince().getName()%></span>
								</div>
								<div class='card-description'></div>
							</div>
						</div>
						<div class='card-contact-container'>
							<div class='card-published-info'>
								<img src="" alt='' class='card-published-info__avatar' />
								<div>
									<div class='card-published-info__name'><%=r.getContactName()%></div>
									<div class='card-published-info__update-time'>Đăng hôm
										nay</div>
								</div>
							</div>
							<div class='card-contact-button-container'>
								<div class='card-contact-button__phonenumber'>
									<i class='fa-solid fa-phone-volume'></i> <span>0912 345
										679</span> <span class='card-contact-button__phonenumber__dot'>·</span>
									<span>Hiện số</span>
								</div>
								<div class='card-contact-button__favorite'>
									<i class='fa-regular fa-heart'></i>
								</div>
							</div>
						</div>
						<div class='card-label-img'></div>
					</div>
					<%
					}
					}
					}
					%>
				</div>

				<div class='sell-sidebar col-lg-3'>
					<div class='sidebar-box'>
						<h5 class='sidebar-box__title'>Lọc theo khỏa giá</h5>
						<ul class='sidebar-box__content'>
							<li class='sidebar-box__item'><a href='#'>Thỏa thuận</a></li>
							<li class='sidebar-box__item'><a>Dưới 500 triệu</a></li>
							<li class='sidebar-box__item'><a>500 - 800 triệu</a></li>
							<li class='sidebar-box__item'><a>800 triệu - 1 tỷ</a></li>
							<li class='sidebar-box__item'><a>1 - 2 tỷ</a></li>
						</ul>
					</div>

					<div class='sidebar-box'>
						<h5 class='sidebar-box__title'>Lọc theo diện tích</h5>
						<ul class='sidebar-box__content'>
							<li class='sidebar-box__item'><a href='#'>Thỏa thuận</a></li>
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