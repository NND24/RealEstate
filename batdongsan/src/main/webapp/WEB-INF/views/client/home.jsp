<%@page import="batdongsan.models.RealEstateModel"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Website số 1 về bất động sản</title>
<link rel="stylesheet" href="css/client/index.css" type="text/css">
<link rel="stylesheet" href="css/client/header.css" type="text/css">
<link rel="stylesheet" href="css/client/home.css" type="text/css">
<link rel="stylesheet" href="css/client/footer.css" type="text/css">
<%@ include file="../../../links/links.jsp"%>
</head>
<body>
	<%@ include file="../../components/header.jsp"%>
	<div class="home">
		<!-- CAROUSEL -->
		<div class='carousel-container'>
			<div id='myCarousel' class='carousel slide' data-ride='carousel'>

				<ol class='carousel-indicators'>
					<li data-target='#myCarousel' data-slide-to='0' class='active'></li>
					<li data-target='#myCarousel' data-slide-to='1'></li>
					<li data-target='#myCarousel' data-slide-to='2'></li>
				</ol>


				<div class='carousel-inner'>
					<div class='item active'>
						<img
							src='https://maxweb.vn/wp-content/uploads/2020/05/banner-bat-dong-san-dep-00.jpg' />
					</div>

					<div class='item'>
						<img
							src='https://nikedu.vn/wp-content/uploads/2021/10/banner-bat-dong-san-8.jpg' />
					</div>

					<div class='item'>
						<img
							src='https://bachkhoaland.com/wp-content/uploads/2020/02/du-an-green-star-min-1024x427.jpg' />
					</div>
				</div>

				<a class='left carousel-control' href='#myCarousel'
					data-slide='prev'> <span
					class='glyphicon glyphicon-chevron-left'></span> <span
					class='sr-only'>Previous</span>
				</a> <a class='right carousel-control' href='#myCarousel'
					data-slide='next'> <span
					class='glyphicon glyphicon-chevron-right'></span> <span
					class='sr-only'>Next</span>
				</a>
			</div>

			<!-- TABS -->
			<div class='tabs-container'>
				<ul class='nav nav-tabs'>
					<li class='active'><a data-toggle='tab' href='#home'> Nhà
							đất bán </a></li>
					<li><a data-toggle='tab' href='#menu1'> Nhà cho thuê </a></li>
					<li><a data-toggle='tab' href='#menu2'> Dự án </a></li>
				</ul>

				<div class='tab-content'>
					<div id='home' class='tab-pane fade in active'>
						<div class='search-container'>
							<div class='search-dropdown'>
								<i class='fa-solid fa-house'></i> <span>Loại nhà đất</span> <i
									class='fa-solid fa-chevron-down'></i>
							</div>
							<input type='text' placeholder='Dự án Ecopark' />
							<button class='search-button'>
								<i class='fa-solid fa-magnifying-glass'></i> <span>Tìm
									kiếm</span>
							</button>
						</div>
						<div class='dropdown-menu-container'>
							<div class='dropdown-item'>
								<span>Trên toàn quốc</span> <i class='fa-solid fa-chevron-down'></i>
							</div>
							<div class='dropdown-item'>
								<span>Mức giá</span> <i class='fa-solid fa-chevron-down'></i>
							</div>
							<div class='dropdown-item'>
								<span>Diện tích</span> <i class='fa-solid fa-chevron-down'></i>
							</div>
							<div class='dropdown-item'>
								<span>Lọc thêm</span> <i class='fa-solid fa-chevron-down'></i>
							</div>
							<i class='fa-solid fa-arrows-rotate'></i>
						</div>
					</div>
					<div id='menu1' class='tab-pane fade'>
						<div class='search-container'>
							<div class='search-dropdown'>
								<i class='fa-solid fa-house'></i> <span>Loại nhà đất</span> <i
									class='fa-solid fa-chevron-down'></i>
							</div>
							<input type='text' placeholder='Dự án Ecopark' />
							<button class='search-button'>
								<i class='fa-solid fa-magnifying-glass'></i> <span>Tìm
									kiếm</span>
							</button>
						</div>
						<div class='dropdown-menu-container'>
							<div class='dropdown-item'>
								<span>Trên toàn quốc</span> <i class='fa-solid fa-chevron-down'></i>
							</div>
							<div class='dropdown-item'>
								<span>Mức giá</span> <i class='fa-solid fa-chevron-down'></i>
							</div>
							<div class='dropdown-item'>
								<span>Diện tích</span> <i class='fa-solid fa-chevron-down'></i>
							</div>
							<div class='dropdown-item'>
								<span>Lọc thêm</span> <i class='fa-solid fa-chevron-down'></i>
							</div>
							<i class='fa-solid fa-arrows-rotate'></i>
						</div>
					</div>
					<div id='menu2' class='tab-pane fade'>
						<div class='search-container'>
							<div class='search-dropdown'>
								<i class='fa-solid fa-house'></i> <span>Loại nhà đất</span> <i
									class='fa-solid fa-chevron-down'></i>
							</div>
							<input type='text' placeholder='Dự án Ecopark' />
							<button class='search-button'>
								<i class='fa-solid fa-magnifying-glass'></i> <span>Tìm
									kiếm</span>
							</button>
						</div>
						<div class='dropdown-menu-container'>
							<div class='dropdown-item'>
								<span>Trên toàn quốc</span> <i class='fa-solid fa-chevron-down'></i>
							</div>
							<div class='dropdown-item'>
								<span>Mức giá</span> <i class='fa-solid fa-chevron-down'></i>
							</div>
							<div class='dropdown-item'>
								<span>Trạng thái</span> <i class='fa-solid fa-chevron-down'></i>
							</div>
							<i class='fa-solid fa-arrows-rotate'></i>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- ArticleContent -->
		<div class='content-container white-background'>
			<div class='container home__article-container'>
				<div class='article-info-preview'>
					<ul class='nav nav-tabs'>
						<li class='active'><a data-toggle='tab' href='#tinNoiBat'>
								Tin nổi bật </a></li>
						<li><a data-toggle='tab' href='#tinTuc'> Tin tức </a></li>
						<li><a data-toggle='tab' href='#bdsHcm'> BĐS TPHCM </a></li>
						<li><a data-toggle='tab' href='#bdsHN'> BDS Hà Nội </a></li>
						<a href='' class='tabview'> <span>Xem thêm</span> <i
							class='fa-solid fa-arrow-right'></i>
						</a>
					</ul>

					<div class='tab-content'>
						<div id='tinNoiBat' class='tab-pane fade in active'>
							<div class='article-container'>
								<div class='article-info-container'>
									<img
										src='https://img.iproperty.com.my/angel/610x342-crop/wp-content/uploads/sites/7/2024/01/a1-1.jpg'
										alt='' />
									<h3>4 Yếu Tố Tác Động Mạnh Đến Thị Trường Bất Động Sản
										2024</h3>
									<span class='article-time'> <i
										class='fa-regular fa-clock'></i> <span> 1 ngày trước</span>
									</span>
								</div>
								<div class='article-list-container'>
									<ul>
										<li><a href=''>Phân Khúc Bất Động Sản Nào Là “Ngôi
												Sao” Của Thị Trường 2024?</a></li>
										<li><a href=''>Lãi Suất Vay Ngân Hàng Tháng 1/2024 -
												Từ 5%/Năm</a></li>
										<li><a href=''>Nhiều Dự Án Chung Cư Tăng Giá Trong
												Năm 2023</a></li>
										<li><a href=''>7 Mẹo Nhỏ Cho Thuê Nhà Nhanh Và Được
												Giá</a></li>
										<li><a href=''>4 Yếu Tố Tác Động Mạnh Đến Thị Trường
												Bất Động Sản 2024</a></li>
										<li><a href=''>Thị Trường Đất Nền Khó Khăn Ra Sao
												Trong Năm 2023?</a></li>
									</ul>
								</div>
							</div>
						</div>
						<div id='tinTuc' class='tab-pane fade'>
							<div class='article-container'>
								<div class='article-info-container'>
									<img
										src='https://img.iproperty.com.my/angel/610x342-crop/wp-content/uploads/sites/7/2024/01/a1-1.jpg'
										alt='' />
									<h3>4 Yếu Tố Tác Động Mạnh Đến Thị Trường Bất Động Sản
										2024</h3>
									<span class='article-time'> <i
										class='fa-regular fa-clock'></i> <span> 1 ngày trước</span>
									</span>
								</div>
								<div class='article-list-container'>
									<ul>
										<li><a href=''>Phân Khúc Bất Động Sản Nào Là “Ngôi
												Sao” Của Thị Trường 2024?</a></li>
										<li><a href=''>Lãi Suất Vay Ngân Hàng Tháng 1/2024 -
												Từ 5%/Năm</a></li>
										<li><a href=''>Nhiều Dự Án Chung Cư Tăng Giá Trong
												Năm 2023</a></li>
										<li><a href=''>7 Mẹo Nhỏ Cho Thuê Nhà Nhanh Và Được
												Giá</a></li>
										<li><a href=''>4 Yếu Tố Tác Động Mạnh Đến Thị Trường
												Bất Động Sản 2024</a></li>
										<li><a href=''>Thị Trường Đất Nền Khó Khăn Ra Sao
												Trong Năm 2023?</a></li>
									</ul>
								</div>
							</div>
						</div>
						<div id='bdsHcm' class='tab-pane fade'>
							<div class='article-container'>
								<div class='article-info-container'>
									<img
										src='https://img.iproperty.com.my/angel/610x342-crop/wp-content/uploads/sites/7/2024/01/a1-1.jpg'
										alt='' />
									<h3>4 Yếu Tố Tác Động Mạnh Đến Thị Trường Bất Động Sản
										2024</h3>
									<span class='article-time'> <i
										class='fa-regular fa-clock'></i> <span> 1 ngày trước</span>
									</span>
								</div>
								<div class='article-list-container'>
									<ul>
										<li><a href=''>Phân Khúc Bất Động Sản Nào Là “Ngôi
												Sao” Của Thị Trường 2024?</a></li>
										<li><a href=''>Lãi Suất Vay Ngân Hàng Tháng 1/2024 -
												Từ 5%/Năm</a></li>
										<li><a href=''>Nhiều Dự Án Chung Cư Tăng Giá Trong
												Năm 2023</a></li>
										<li><a href=''>7 Mẹo Nhỏ Cho Thuê Nhà Nhanh Và Được
												Giá</a></li>
										<li><a href=''>4 Yếu Tố Tác Động Mạnh Đến Thị Trường
												Bất Động Sản 2024</a></li>
										<li><a href=''>Thị Trường Đất Nền Khó Khăn Ra Sao
												Trong Năm 2023?</a></li>
									</ul>
								</div>
							</div>
						</div>
						<div id='bdsHN' class='tab-pane fade'>
							<div class='article-container'>
								<div class='article-info-container'>
									<img
										src='https://img.iproperty.com.my/angel/610x342-crop/wp-content/uploads/sites/7/2024/01/a1-1.jpg'
										alt='' />
									<h3>4 Yếu Tố Tác Động Mạnh Đến Thị Trường Bất Động Sản
										2024</h3>
									<span class='article-time'> <i
										class='fa-regular fa-clock'></i> <span> 1 ngày trước</span>
									</span>
								</div>
								<div class='article-list-container'>
									<ul>
										<li><a href=''>Phân Khúc Bất Động Sản Nào Là “Ngôi
												Sao” Của Thị Trường 2024?</a></li>
										<li><a href=''>Lãi Suất Vay Ngân Hàng Tháng 1/2024 -
												Từ 5%/Năm</a></li>
										<li><a href=''>Nhiều Dự Án Chung Cư Tăng Giá Trong
												Năm 2023</a></li>
										<li><a href=''>7 Mẹo Nhỏ Cho Thuê Nhà Nhanh Và Được
												Giá</a></li>
										<li><a href=''>4 Yếu Tố Tác Động Mạnh Đến Thị Trường
												Bất Động Sản 2024</a></li>
										<li><a href=''>Thị Trường Đất Nền Khó Khăn Ra Sao
												Trong Năm 2023?</a></li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class='home__hot-news-banner'>
					<img
						src='https://tpc.googlesyndication.com/simgad/3748612651896058688'
						alt='' />
				</div>
			</div>
		</div>

		<!-- BDSForYouContent -->
		<div class='content-container gray-background '>
			<div class='container '>
				<div class='content__header'>
					<h3 class='content__header--label'>Bất động sản dành cho bạn</h3>
					<div class='content-container-link'>
						<a href=''>Tin nhà đất mới nhất</a> <span>|</span> <a href=''>Tin
							nhà đất cho thuê mới nhất</a>
					</div>
				</div>
				<div class='product-container '>
					<div class='row'>
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
						<div class='col-lg-3'>
							<div class='card'>
								<img class='card-img-top' src="<%=imagePaths[0]%>" alt='' />
								<div class='card-info-container'>
									<h3 class='card-title'><%=r.getTitle()%></h3>
									<div class='card-config'>
										<span class='card-config-price'><%=r.getPrice()%> <%=r.getUnit()%></span>
										<i class='fa-solid fa-circle'></i> <span
											class='card-config-area'><%=r.getArea()%> m²</span>
									</div>
									<div class='card-location'>
										<i class='fa-solid fa-location-dot'></i> <span><%=r.getDistrict().getName()%>,
											<%=r.getProvince().getName()%></span>
									</div>
									<div class='card-contact'>
										<span class='card-published-info' data-toggle='tooltip2'
											data-placement='right' title='13/01/2024'> Đăng 3 ngày
											trước </span>
										<button class='card-contact-button' data-toggle='tooltip'
											data-placement='bottom' title='Bấm để lưu tin'>
											<i class='fa-regular fa-heart'></i>
										</button>
									</div>
								</div>
							</div>
						</div>
						<%
						}
						}
						}
						%>

					</div>
				</div>
				<div class='product-view-container'>
					<button class='product-view-more'>
						<span>Mở rộng</span> <i class='fa-solid fa-chevron-down'></i>
					</button>
				</div>
			</div>
		</div>

		<!-- ProjectBlockContent -->
		<div class='content-container white-background '>
			<div class='container '>
				<div class='content__header'>
					<h3 class='content__header--label'>Dự án bất động sản nổi bật</h3>
					<a href='' class='tabview'> <span>Xem thêm</span> <i
						class='fa-solid fa-arrow-right'></i>
					</a>
				</div>
				<div class='product-container '>
					<div class='row'>
						<div class='col-lg-3'>
							<div class='card'>
								<img class='card-img-top'
									src='https://file4.batdongsan.com.vn/crop/260x146/2023/12/20/20231220211756-ae4e_wm.jpg'
									alt='' />
								<div class='card-info-container'>
									<div class='project-tag-info project-prepare'>Sắp mở bán</div>
									<h3 class='card-title'>HXT Nguyễn Trãi Quận 5, xây 2 tầng
										4x20m -(80m2), sổ riêng vuông vức, giá chỉ 11,5 tỷ</h3>
									<div class='card-config'>
										<span class='card-config-area'>25 ha</span>
									</div>
									<div class='card-location'>
										<span>Sơn Dương, Tuyên Quang</span>
									</div>
								</div>
							</div>
						</div>
						<div class='col-lg-3'>
							<div class='card'>
								<img class='card-img-top'
									src='https://file4.batdongsan.com.vn/crop/260x146/2023/12/20/20231220211756-ae4e_wm.jpg'
									alt='' />
								<div class='card-info-container'>
									<div class='project-tag-info project-open'>Đang mở bán</div>
									<h3 class='card-title'>HXT Nguyễn Trãi Quận 5, xây 2 tầng
										4x20m -(80m2), sổ riêng vuông vức, giá chỉ 11,5 tỷ</h3>
									<div class='card-config'>
										<span class='card-config-area'>25 ha</span>
									</div>
									<div class='card-location'>
										<span>Sơn Dương, Tuyên Quang</span>
									</div>
								</div>
							</div>
						</div>
						<div class='col-lg-3'>
							<div class='card'>
								<img class='card-img-top'
									src='https://file4.batdongsan.com.vn/crop/260x146/2023/12/20/20231220211756-ae4e_wm.jpg'
									alt='' />
								<div class='card-info-container'>
									<div class='project-tag-info project-prepare'>Sắp mở bán</div>
									<h3 class='card-title'>HXT Nguyễn Trãi Quận 5, xây 2 tầng
										4x20m -(80m2), sổ riêng vuông vức, giá chỉ 11,5 tỷ</h3>
									<div class='card-config'>
										<span class='card-config-area'>25 ha</span>
									</div>
									<div class='card-location'>
										<span>Sơn Dương, Tuyên Quang</span>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- PlaceBlockContent -->
		<div class='content-container white-background '>
			<div class='container'>
				<div class='content__header'>
					<h3 class='content__header--label'>Bất động sản theo địa điểm</h3>
				</div>
				<div class='place-container'>
					<div class='place-item place-big'>
						<img
							src='https://file4.batdongsan.com.vn/images/newhome/cities1/HCM-web-2.jpg'
							alt='' />
						<div class='place-info'>
							<span class='place-name'>TP. Hồ Chí Minh</span> <span
								class='place-number'>48.743 tin đăng</span>
						</div>
					</div>
					<div class='place-small'>
						<div class='row'>
							<div class='col-lg-6 place-item'>
								<img
									src='https://file4.batdongsan.com.vn/images/newhome/cities1/HN-web-2.jpg'
									alt='' />
								<div class='place-info'>
									<span class='place-name'>Hà Nội</span> <span
										class='place-number'>51.869 tin đăng</span>
								</div>
							</div>
							<div class='col-lg-6 place-item'>
								<img
									src='https://file4.batdongsan.com.vn/images/newhome/cities1/DDN-web-2.jpg'
									alt='' />
								<div class='place-info'>
									<span class='place-name'>Đà Nẵng</span> <span
										class='place-number'>48.743 tin đăng</span>
								</div>
							</div>
							<div class='col-lg-6 place-item'>
								<img
									src='https://file4.batdongsan.com.vn/images/newhome/cities1/BD-web-1.jpg'
									alt='' />
								<div class='place-info'>
									<span class='place-name'>Bình Dương</span> <span
										class='place-number'>48.743 tin đăng</span>
								</div>
							</div>
							<div class='col-lg-6 place-item'>
								<img
									src='https://file4.batdongsan.com.vn/images/newhome/cities1/DNA-web-2.jpg'
									alt='' />
								<div class='place-info'>
									<span class='place-name'>Đồng Nai</span> <span
										class='place-number'>48.743 tin đăng</span>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- NewsBlockContent -->
		<div class='content-container white-background '>
			<div class='container'>
				<div class='content__header'>
					<h3 class='content__header--label'>Tin tức bất động sản</h3>
				</div>
				<div class='product-container '>
					<div class='row'>
						<div class='col-lg-4'>
							<div class='card'>
								<img class='card-img-top'
									src='https://file4.batdongsan.com.vn/crop/260x146/2023/12/20/20231220211756-ae4e_wm.jpg'
									alt='' />
								<div class='card-info-container'>
									<h3 class='card-title'>HXT Nguyễn Trãi Quận 5, xây 2 tầng
										4x20m -(80m2), sổ riêng vuông vức, giá chỉ 11,5 tỷ</h3>
								</div>
							</div>
						</div>
						<div class='col-lg-4'>
							<div class='card'>
								<img class='card-img-top'
									src='https://file4.batdongsan.com.vn/crop/260x146/2023/12/20/20231220211756-ae4e_wm.jpg'
									alt='' />
								<div class='card-info-container'>
									<h3 class='card-title'>HXT Nguyễn Trãi Quận 5, xây 2 tầng
										4x20m -(80m2), sổ riêng vuông vức, giá chỉ 11,5 tỷ</h3>
								</div>
							</div>
						</div>
						<div class='col-lg-4'>
							<div class='card'>
								<img class='card-img-top'
									src='https://file4.batdongsan.com.vn/crop/260x146/2023/12/20/20231220211756-ae4e_wm.jpg'
									alt='' />
								<div class='card-info-container'>
									<h3 class='card-title'>HXT Nguyễn Trãi Quận 5, xây 2 tầng
										4x20m -(80m2), sổ riêng vuông vức, giá chỉ 11,5 tỷ</h3>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="../../components/footer.jsp"%>
</body>
</html>