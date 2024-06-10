<%@page import="java.math.BigInteger"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="batdongsan.models.UsersModel"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Arrays"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ page pageEncoding="utf-8"%>

<header class="header">
	<div class="header-container">
		<div class="header-menu">
			<div class="left-menu">
				<a href="${pageContext.servletContext.contextPath}/trang-chu.html">
					<img
					src="${pageContext.servletContext.contextPath}/images/logo1.jpg"
					alt="" />
				</a>
			</div>
			<div class="right-menu">
				<ul class="menu-container">
					<li class="menu__item" style="border-bottom: 2px solid rgb(228, 54, 54);"><a
						href="${pageContext.servletContext.contextPath}/nha-dat-ban.html">Nhà
							đất bán</a>
						<ul class="list-container">
							<c:forEach var="c" items="${categoriesSell}">
								<a
									href="${pageContext.servletContext.contextPath}/nha-dat-ban.html?categoryIds=${c.categoryId}">
									<li data-category-id="${c.categoryId}"">${c.name}</li>
								</a>
							</c:forEach>
						</ul></li>
					<li class="menu__item"><a
						href="${pageContext.servletContext.contextPath}/nha-dat-cho-thue.html">Nhà
							đất cho thuê</a>
						<ul class="list-container">
							<c:forEach var="c" items="${categoriesRent}">
								<a
									href="${pageContext.servletContext.contextPath}/nha-dat-cho-thue.html?categoryIds=${c.categoryId}">
									<li data-category-id="${c.categoryId}"">${c.name}</li>
								</a>
							</c:forEach>
						</ul></li>
					<li class="menu__item">Tin tức</li>
				</ul>
			</div>
		</div>

		<%
		UsersModel user = (UsersModel) request.getAttribute("user");

		if (user == null) {
		%>
		<div class="control-menu">
			<div class="user-option-container">
				<a href="${pageContext.servletContext.contextPath}/dang-nhap.html" class="main-button"> Đăng nhập </a> <span class="line"></span>
				<a href="${pageContext.servletContext.contextPath}/dang-ky.html" class="main-button"> Đăng ký </a>
			</div>
		</div>
		<%
		} else {
		%>
		<div class='control-menu logined'>
			<a href="${pageContext.servletContext.contextPath}/tin-da-luu.html">
				<i class='fa-regular fa-heart'></i> 
			</a>
			<!--  	<i class='fa-regular fa-bell'></i> -->
			<div class='user-option-container'>
			<!-- <span class='avatar'>
					<h3>U</h3>
				 </span> -->
				<img class="avatar" alt="" src="images/<%= user.getAvatar() %>" />
				<span><%= user.getName() %></span> <i class='fa-solid fa-angle-down'></i>

				<div class='model-container'>
					<div class='model-item'>
						<a href="${pageContext.servletContext.contextPath}/sellernet/quan-ly-tin-rao-ban-cho-thue.html">
							<i class='fa-solid fa-list-ul'></i> <span>Quản lý tin đăng</span>
						</a>
					</div>
					<div class='model-item'>
					<a href="${pageContext.servletContext.contextPath}/sellernet/thong-tin-ca-nhan.html?edit=true">
						<i class="fa-regular fa-user"></i> <span>Thay đổi thông
							tin cá nhân</span>
							</a>
					</div>
					<div class='model-item'>
					<a href="${pageContext.servletContext.contextPath}/sellernet/thong-tin-ca-nhan.html?setting=true">
						<i class="fa-solid fa-lock"></i> <span>Thay đổi mật khẩu</span>
							</a>
					</div>
					<a class='model-item' href="${pageContext.servletContext.contextPath}/sellernet/nap-tien.html">
						<i class="fa-regular fa-credit-card"></i> <span>Nạp tiền</span>
					</a>
					<hr />
					<div class='model-item logout'>
						<i class="fa-solid fa-arrow-right-from-bracket"></i> <span>Đăng xuất</span>
					</div>
				</div>
			</div>
			<div class='postProduct__button main-button'>
				<a href='${pageContext.servletContext.contextPath}/sellernet/dang-tin/ban.html'>Đăng tin</a>
			</div>
		</div>
		<%
		}
		%>
	</div>

	<form action="#">
		<div class="search-bar">
			<div class="search-bar__tab">
				<a href="${pageContext.servletContext.contextPath}/nha-dat-ban.html"
					class="tab-box <%if ("sell".equals(request.getAttribute("page"))) {%> tab-box--actived<%}%>">Bán</a>
				<a
					href="${pageContext.servletContext.contextPath}/nha-dat-cho-thue.html"
					class="tab-box <%if ("rent".equals(request.getAttribute("page"))) {%> tab-box--actived<%}%>">Cho
					thuê</a>

			</div>
			<div class="search-bar__input">
				<i
					class="fa-solid fa-magnifying-glass list-search-select__search-button"></i>
				<input type="text" />
			</div>
			<div class="filter-wall"></div>

			<div class="search-select-container search-type">
				<div>
					<div class="search-select__item">
						<span>Loại nhà đất</span> <i class="fa-solid fa-chevron-down"></i>
					</div>
					<p id="list-type">Tất cả</p>
				</div>
				<div class="dropdown-menu menu-type">
					<div class="menu-list">
						<label for="check-all" id="all" class="type-item">
							<div>
								<i class="fa-solid fa-house"></i> <span>Tất cả nhà đất </span>
							</div> <input type="checkbox" id="check-all"
							<%List<Integer> categoryIdsList = (List<Integer>) request.getAttribute("categoryIds");
							if (categoryIdsList != null && categoryIdsList.containsAll(Arrays.asList(1,2,3,4,5,6,7,8,9,10,11))) {%>
							checked <%}%> /> <span class="checkmark"> </span>
						</label>
						<div class="separate"></div>
						<label for="1" class="type-item">
							<div>
								<i class="fa-solid fa-building"></i> <span>Căn hộ chung
									cư</span>
							</div> <input type="checkbox" id="1" value="1"
							<%if (categoryIdsList != null && categoryIdsList.contains(1)) {%>
							checked <%}%> /> <span class="checkmark"></span>
						</label>
						<div class="separate"></div>
						<label for="2" id="check-type-of-house" class="type-item">
							<div>
								<i class="fa-solid fa-house-user"></i> <span>Các loại nhà
									bán </span>
							</div> <input type="checkbox" id="2"
							<%if (categoryIdsList != null && categoryIdsList.containsAll(Arrays.asList(2, 3, 4, 5))) {%>
							checked <%}%> /> <span class="checkmark"></span>
						</label> <label for="3" class="type-item">
							<div>
								<i></i> <span>Nhà riêng</span>
							</div> <input type="checkbox" id="3" value="2"
							<%if (categoryIdsList != null && categoryIdsList.contains(2)) {%>
							checked <%}%> /> <span class="checkmark"></span>
						</label> <label for="4" class="type-item">
							<div>
								<i></i> <span>Nhà biệt thự, liền kề</span>
							</div> <input type="checkbox" id="4" value="3"
							<%if (categoryIdsList != null && categoryIdsList.contains(3)) {%>
							checked <%}%> /> <span class="checkmark"></span>
						</label> <label for="5" class="type-item">
							<div>
								<i></i> <span>Nhà mặt phố</span>
							</div> <input type="checkbox" id="5" value="4"
							<%if (categoryIdsList != null && categoryIdsList.contains(4)) {%>
							checked <%}%> /> <span class="checkmark"></span>
						</label> <label for="6" class="type-item">
							<div>
								<i></i> <span>Shophouse, nhà phố thương mại</span>
							</div> <input type="checkbox" id="6" value="5"
							<%if (categoryIdsList != null && categoryIdsList.contains(5)) {%>
							checked <%}%> /> <span class="checkmark"></span>
						</label>
						<div class="separate"></div>
						<label for="7" class="type-item" id="check-type-of-land">
							<div>
								<i class="fa-solid fa-panorama"></i> <span>Các loại đất
									bán</span>
							</div> <input type="checkbox" id="7"
							<%if (categoryIdsList != null && categoryIdsList.containsAll(Arrays.asList(6, 7))) {%>
							checked <%}%> /> <span class="checkmark"></span>
						</label> <label for="8" class="type-item">
							<div>
								<i></i> <span>Đất nền dự án</span>
							</div> <input type="checkbox" id="8" value="6"
							<%if (categoryIdsList != null && categoryIdsList.contains(6)) {%>
							checked <%}%> /> <span class="checkmark"></span>
						</label> <label for="9" class="type-item">
							<div>
								<i></i> <span>Bán đất</span>
							</div> <input type="checkbox" id="9" value="7"
							<%if (categoryIdsList != null && categoryIdsList.contains(7)) {%>
							checked <%}%> /> <span class="checkmark"></span>
						</label>
						<div class="separate"></div>
						<label for="10" class="type-item" id="check-type-of-farm">
							<div>
								<i class="fa-solid fa-tractor"></i> <span>Trang trại, khu
									nghỉ dưỡng</span>
							</div> <input type="checkbox" id="10" value="8"
							<%if (categoryIdsList != null && categoryIdsList.contains(8)) {%>
							checked <%}%> /> <span class="checkmark"></span>
						</label> <label for="11" class="type-item">
							<div>
								<i></i> <span>Condotel</span>
							</div> <input type="checkbox" id="11" value="9"
							<%if (categoryIdsList != null && categoryIdsList.contains(9)) {%>
							checked <%}%> /> <span class="checkmark"></span>
						</label>
						<div class="separate"></div>
						<label for="12" class="type-item">
							<div>
								<i class="fa-solid fa-warehouse"></i> <span>Kho, nhà
									xưởng</span>
							</div> <input type="checkbox" id="12" value="10"
							<%if (categoryIdsList != null && categoryIdsList.contains(10)) {%>
							checked <%}%> /> <span class="checkmark"></span>
						</label>
						<div class="separate"></div>
						<label for="13" class="type-item">
							<div>
								<i class="fa-solid fa-door-open"></i> <span>Bất động sản
									khác</span>
							</div> <input type="checkbox" id="13" value="11"
							<%if (categoryIdsList != null && categoryIdsList.contains(11)) {%>
							checked <%}%> /> <span class="checkmark"></span>
						</label>
					</div>

					<div class="list-search-select-footer">
						<div class="list-search-select__reset-button"
							id="reset-search-type">
							<i class="fa-solid fa-rotate"></i> <span>Đặt lại</span>
						</div>
						<div class="list-search-select__search-button"
							id="type-search-button">
							<i class="fa-solid fa-magnifying-glass"></i> <span>Tìm
								kiếm</span>
						</div>
					</div>
				</div>
			</div>

			<div class="filter-wall"></div>
			<div class="search-select-container search-address">
				<div class="dropdown-toggle">
					<div class="search-select__item">
						<span>Khu vực & dự án</span> <i class="fa-solid fa-chevron-down"></i>
					</div>
					<p id="list-address">Tất cả</p>
				</div>
				<div class="dropdown-menu menu-address">
					<div class="menu-list">
						<div class="listing-search-button" id="button-choose-province">
							<div class="listing-search-title">Tỉnh/Thành</div>
							<div class="listing-search-current-text"></div>
							<i class="fa-solid fa-angle-right"></i> <i
								class="fa-solid fa-xmark"></i>
						</div>
						<div class="listing-search-button" id="button-choose-district">
							<div class="listing-search-title">Quận/Huyện</div>
							<div class="listing-search-current-text">Hà Nội</div>
							<i class="fa-solid fa-angle-right"></i> <i
								class="fa-solid fa-xmark"></i>
						</div>
						<div class="listing-search-button" id="button-choose-ward">
							<div class="listing-search-title">Phường/Xã</div>
							<div class="listing-search-current-text">Hà Nội</div>
							<i class="fa-solid fa-angle-right"></i> <i
								class="fa-solid fa-xmark"></i>
						</div>
					</div>
					<div class="list-search-select-footer">
						<div class="list-search-select__reset-button"
							id="reset-search-address">
							<i class="fa-solid fa-rotate"></i> <span>Đặt lại</span>
						</div>
						<div class="list-search-select__search-button">
							<i class="fa-solid fa-magnifying-glass"></i> <span>Tìm
								kiếm</span>
						</div>
					</div>
				</div>
				<div class="dropdown-menu" id="province-menu">
					<p class="menu-title">Chọn Tỉnh/Thành</p>
					<i class="fa-solid fa-xmark close-menu-button"
						id="close-province-menu"></i>
					<div class="menu-list list-provinces">
						<label provinceId="all"> <span>Tất cả Tỉnh/Thành</span>
						</label>
						<c:forEach var="p" items="${provinces}">
							<label provinceId="${p.provinceId}"> <span>${p.name}</span>
								<i class="fa-solid fa-angle-right"></i>
							</label>
						</c:forEach>
					</div>
				</div>
				<div class="dropdown-menu" id="district-menu">
					<p class="menu-title">Chọn Quận/Huyện</p>
					<i class="fa-solid fa-xmark close-menu-button"
						id="close-district-menu"></i>
					<div class="menu-list list-districts"></div>
				</div>
				<div class="dropdown-menu" id="ward-menu">
					<p class="menu-title">Chọn Phường/Xã</p>
					<i class="fa-solid fa-xmark close-menu-button" id="close-ward-menu"></i>
					<div class="menu-list list-wards"></div>
				</div>
			</div>

			<div class="filter-wall"></div>
			<div class="search-select-container search-price">
				<div class="dropdown-toggle">
					<div class="search-select__item">
						<span>Mức giá</span> <i class="fa-solid fa-chevron-down"></i>
					</div>
					<p id="list-price">Tất cả</p>
				</div>
				<%
				BigDecimal minPriceFloat = null;
				BigDecimal maxPriceFloat = null;
				String unit = (String) request.getAttribute("unit");
				BigInteger minPrice = BigInteger.valueOf(-1); // Initialize with -1
				BigInteger maxPrice = BigInteger.valueOf(-1); // Initialize with -1
				
				Object minPriceObj = request.getAttribute("minPrice");
				Object maxPriceObj = request.getAttribute("maxPrice");
				
				if (minPriceObj != null && maxPriceObj != null) {
				    if (minPriceObj instanceof Float && maxPriceObj instanceof Float) {
				        minPriceFloat = BigDecimal.valueOf((Float) minPriceObj);
				        maxPriceFloat = BigDecimal.valueOf((Float) maxPriceObj);
				        BigDecimal divisor = new BigDecimal("1000000"); // Divisor
				        minPrice = minPriceFloat.divide(divisor).toBigInteger(); // Divide and convert to BigInteger
				        maxPrice = maxPriceFloat.divide(divisor).toBigInteger(); // Divide and convert to BigInteger
				    }
				}
				%>


				<div class="dropdown-menu menu-price">
				    <div class="menu-list">
				        <div class="range-slider-container price-range-slider">
				            <div class="price-input">
				                <div class="field">
				                    <input type="number" class="input-min"
				                        value="<%= (minPriceFloat == null || minPriceFloat.intValue() < 0) ? "Từ" : minPrice %>"
				                        placeholder="Từ" />
				                </div>
				                <i class="fa-solid fa-arrow-right"></i>
				                <div class="field">
				                    <input type="number" class="input-max"
				                        value="<%= (maxPriceFloat == null || maxPriceFloat.intValue() < 0) ? "Đến" : maxPrice %>"
				                        placeholder="Đến" />
				                </div>
				            </div>
				            <div class="slider">
				                <div class="progress"></div>
				            </div>
				            <div class="range-input">
				                <input type="range" class="range-min" min="0" max="59900"
				                    value="<%= (minPriceFloat == null || minPriceFloat.intValue() < 0) ? 0 : minPrice %>"
				                    step="100" /> 
				                <input type="range" class="range-max" min="100" max="60000"
				                    value="<%= (maxPriceFloat == null || maxPriceFloat.intValue() < 0) ? 60000 : maxPrice %>"
				                    step="100" />
				            </div>
				        </div>
				        <div class="separate"></div>
				        <label value="all"> <span class="<%= (minPriceFloat == null && maxPriceFloat == null && unit != null && !unit.equals("thoa-thuan")) ? "active" : "" %>">Tất cả mức giá</span>
				        </label>
				        <label> <span class="<%= (minPriceFloat != null && maxPriceFloat != null && minPrice.intValue() == 0 && maxPrice.intValue() == 500) ? "active" : "" %>">Dưới 500 triệu</span>
				        </label>
				        <label> <span class="<%= (minPriceFloat != null && maxPriceFloat != null && minPrice.intValue() == 500 && maxPrice.intValue() == 800) ? "active" : "" %>">500 - 800 triệu</span>
				        </label>
				        <label> <span class="<%= (minPriceFloat != null && maxPriceFloat != null && minPrice.intValue() == 800 && maxPrice.intValue() == 1000) ? "active" : "" %>">800 triệu - 1 tỷ</span>
				        </label>
				        <label> <span class="<%= (minPriceFloat != null && maxPriceFloat != null && minPrice.intValue() == 1000 && maxPrice.intValue() == 2000) ? "active" : "" %>">1 - 2 tỷ</span>
				        </label>
				        <label> <span class="<%= (minPriceFloat != null && maxPriceFloat != null && minPrice.intValue() == 2000 && maxPrice.intValue() == 3000) ? "active" : "" %>">2 - 3 tỷ</span>
				        </label>
				        <label> <span class="<%= (minPriceFloat != null && maxPriceFloat != null && minPrice.intValue() == 3000 && maxPrice.intValue() == 5000) ? "active" : "" %>">3 - 5 tỷ</span>
				        </label>
				        <label> <span class="<%= (minPriceFloat != null && maxPriceFloat != null && minPrice.intValue() == 5000 && maxPrice.intValue() == 7000) ? "active" : "" %>">5 - 7 tỷ</span>
				        </label>
				        <label> <span class="<%= (minPriceFloat != null && maxPriceFloat != null && minPrice.intValue() == 7000 && maxPrice.intValue() == 10000) ? "active" : "" %>">7 - 10 tỷ</span>
				        </label>
				        <label> <span class="<%= (minPriceFloat != null && maxPriceFloat != null && minPrice.intValue() == 10000 && maxPrice.intValue() == 20000) ? "active" : "" %>">10 - 20 tỷ</span>
				        </label>
				        <label> <span class="<%= (minPriceFloat != null && maxPriceFloat != null && minPrice.intValue() == 20000 && maxPrice.intValue() == 30000) ? "active" : "" %>">20 - 30 tỷ</span>
				        </label>
				        <label> <span class="<%= (minPriceFloat != null && maxPriceFloat != null && minPrice.intValue() == 30000 && maxPrice.intValue() == 40000) ? "active" : "" %>">30 - 40 tỷ</span>
				        </label>
				        <label> <span class="<%= (minPriceFloat != null && maxPriceFloat != null && minPrice.intValue() == 40000 && maxPrice.intValue() == 60000) ? "active" : "" %>">40 - 60 tỷ</span>
				        </label>
				        <label> <span class="<%= (minPriceFloat != null && maxPriceFloat != null && minPrice.intValue() == 60000 && maxPrice.intValue() == 600000) ? "active" : "" %>">Trên 60 tỷ</span>
				        </label>
				        <label> <span class="<%= (unit != null && unit.equals("thoa-thuan")) ? "active" : "" %>">Thỏa thuận</span>
				        </label>
				    </div>
				    <div class="list-search-select-footer">
				        <div class="list-search-select__reset-button" id="reset-search-price">
				            <i class="fa-solid fa-rotate"></i> <span>Đặt lại</span>
				        </div>
				        <div class="list-search-select__search-button">
				            <i class="fa-solid fa-magnifying-glass"></i> <span>Tìm kiếm</span>
				        </div>
				    </div>
				</div>
			</div>

			<div class="filter-wall"></div>
			<div class="search-select-container search-area">
				<div class="dropdown-toggle">
					<div class="search-select__item">
						<span>Diện tích</span> <i class="fa-solid fa-chevron-down"></i>
					</div>
					<p id="list-area">Tất cả</p>
				</div>
				<%
				Float minAreaFloat = (Float) request.getAttribute("minArea");
				Float maxAreaFloat = (Float) request.getAttribute("maxArea");
				int minArea = -1;
				int maxArea = -1;
				if (minAreaFloat != null && maxAreaFloat != null) {
					minArea = (int) Math.round(minAreaFloat);
					maxArea = (int) Math.round(maxAreaFloat);
				}
				%>
				<div class="dropdown-menu menu-area">
					<div class="menu-list">
						<div class="range-slider-container area-range-slider">
							<div class="area-input">
								<div class="field">
									<input type="number" class="input-min"
										value="<%=(minAreaFloat == null || minArea < 0) ? "Từ" : minArea%>"
										placeholder="Từ" />
								</div>
								<i class="fa-solid fa-arrow-right"></i>
								<div class="field">
									<input type="number" class="input-max"
										value="<%=(maxAreaFloat == null || maxArea < 0) ? "Đến" : maxArea%>"
										placeholder="Đến" />
								</div>
							</div>
							<div class="slider">
								<div class="progress"></div>
							</div>
							<div class="range-input">
								<input type="range" class="range-min" min="0" max="455"
									value="<%=(minAreaFloat == null || minArea < 0) ? 0 : minArea%>"
									step="1" /> <input type="range" class="range-max" min="5"
									max="500"
									value="<%=(maxAreaFloat == null || maxArea < 0) ? 500 : maxArea%>"
									step="1" />
							</div>
						</div>

						<div class="separate"></div>
						<label> <span
							<%if (minAreaFloat == null && maxAreaFloat == null) {%>
							class="active" <%}%>>Tất cả diện tích</span>
						</label> <label> <span
							<%if (minAreaFloat != null && maxAreaFloat != null && minArea == 0 && maxArea == 30) {%>
							class="active" <%}%>>Dưới 30 m²</span>
						</label> <label> <span
							<%if (minAreaFloat != null && maxAreaFloat != null && minArea == 30 && maxArea == 50) {%>
							class="active" <%}%>>30 - 50 m²</span>
						</label> <label> <span
							<%if (minAreaFloat != null && maxAreaFloat != null && minArea == 50 && maxArea == 100) {%>
							class="active" <%}%>>50 - 100 m²</span>
						</label> <label> <span
							<%if (minAreaFloat != null && maxAreaFloat != null && minArea == 100 && maxArea == 150) {%>
							class="active" <%}%>>100 - 150 m²</span>
						</label> <label> <span
							<%if (minAreaFloat != null && maxAreaFloat != null && minArea == 150 && maxArea == 200) {%>
							class="active" <%}%>>150 - 200 m²</span>
						</label> <label> <span
							<%if (minAreaFloat != null && maxAreaFloat != null && minArea == 200 && maxArea == 250) {%>
							class="active" <%}%>>200 - 250 m²</span>
						</label> <label> <span
							<%if (minAreaFloat != null && maxAreaFloat != null && minArea == 250 && maxArea == 300) {%>
							class="active" <%}%>>250 - 300 m²</span>
						</label> <label> <span
							<%if (minAreaFloat != null && maxAreaFloat != null && minArea == 300 && maxArea == 500) {%>
							class="active" <%}%>>300 - 500 m²</span>
						</label> <label> <span
							<%if (minAreaFloat != null && maxAreaFloat != null && minArea == 500 && maxArea == 10000) {%>
							class="active" <%}%>>Trên 500 m²</span>
						</label>
					</div>
					<div class="list-search-select-footer">
						<div class="list-search-select__reset-button"
							id="reset-search-area">
							<i class="fa-solid fa-rotate"></i> <span>Đặt lại</span>
						</div>
						<div class="list-search-select__search-button">
							<i class="fa-solid fa-magnifying-glass"></i> <span>Tìm
								kiếm</span>
						</div>
					</div>
				</div>
			</div>

			<div class="filter-wall"></div>
			<div class="search-select-container search-more">
				<span class="amount-search-more" style="display: none;"></span>
				<div class="dropdown-toggle">
					<div class="search-select__item">
						<span>Lọc thêm</span> <i class="fa-solid fa-sliders"></i>
					</div>
				</div>
				<div class="dropdown-menu menu-more">
					<div class="menu-list">
						<div class="menu-item">
							<p class="item__title">Số phòng ngủ</p>
							<ul class="list__items number-of-bedrooms">
								<li class="item item-1">1</li>
								<li class="item item-2">2</li>
								<li class="item item-3">3</li>
								<li class="item item-4">4</li>
								<li class="item item-5">5</li>
							</ul>
						</div>
						<div class="menu-item">
							<p class="item__title">Số phòng vệ sinh/phòng tắm</p>
							<ul class="list__items number-of-toilets">
								<li class="item item-1">1</li>
								<li class="item item-2">2</li>
								<li class="item item-3">3</li>
								<li class="item item-4">4</li>
								<li class="item item-5">5</li>
							</ul>
						</div>
						<div class="menu-item">
							<p class="item__title">Hướng nhà</p>
							<ul class="list__items directions">
								<li class="item item-Đông">Đông</li>
								<li class="item item-Tây">Tây</li>
								<li class="item item-Nam">Nam</li>
								<li class="item item-Bắc">Bắc</li>
								<li class="item item-Đông-Bắc">Đông-Bắc</li>
								<li class="item item-Tây-Bắc">Tây-Bắc</li>
								<li class="item item-Tây-Nam">Tây-Nam</li>
								<li class="item item-Đông-Nam">Đông-Nam</li>
							</ul>
						</div>
					</div>
					<div class="list-search-select-footer">
						<div class="list-search-select__reset-button"
							id="reset-search-more">
							<i class="fa-solid fa-rotate"></i> <span>Đặt lại</span>
						</div>
						<div class="list-search-select__search-button">
							<i class="fa-solid fa-magnifying-glass"></i> <span>Tìm
								kiếm</span>
						</div>
					</div>
				</div>
			</div>

			<div class="filter-wall"></div>
			<div class="search-select-container" id="reset-all-button">
				<div class="dropdown-toggle">
					<div class="search-select__item">
						<span>Đặt lại</span> <i class="fa-solid fa-rotate"></i>
					</div>
				</div>
			</div>
		</div>
	</form>
</header>

<script type="text/javascript">
$(document).ready(function() {
	$("")
	
	$(".user-option-container").on("click", () => {
	    var modelContainer = $(".user-option-container .model-container");
	    
	    // Kiểm tra nếu hiển thị là block thì chuyển thành none, ngược lại chuyển thành block
	    if (modelContainer.css("display") === "block") {
	        modelContainer.css("display", "none");
	    } else {
	        modelContainer.css("display", "block");
	    }
	});
	
	// HANDLE LOGOUT
	$(".logout").on("click", () => {
		$.ajax({
			type: 'GET',
			url: '${pageContext.servletContext.contextPath}/logout.html',
			dataType: 'text',
			success: function(data) {
				window.location.href = '${pageContext.servletContext.contextPath}/trang-chu.html'
			},
			error: function(xhr, status, error) {
				window.location.href = '${pageContext.servletContext.contextPath}/trang-chu.html'
			}
		});
	})

	
	// PRICE RANGE SLIDER
	const priceRangeInput = document.querySelectorAll(".price-range-slider .range-input input"),
		priceInput = document.querySelectorAll(".price-range-slider .price-input input"),
		priceRange = document.querySelector(".price-range-slider .slider .progress");
	let priceGap = 100;

	function updatePriceSlider() {
		let minVal = parseInt(priceRangeInput[0].value),
			maxVal = parseInt(priceRangeInput[1].value);

		priceInput[0].value = minVal;
		priceInput[1].value = maxVal;
		priceRange.style.left = (minVal / priceRangeInput[0].max) * 100 + "%";
		priceRange.style.right = 100 - (maxVal / priceRangeInput[1].max) * 100 + "%";
	}

	function updateListPrice(minVal, maxVal) {
		const listPrice = document.getElementById("list-price");

		if (minVal === 0 && maxVal === 60000) {
			listPrice.textContent = "≤ 60 tỷ";
		} else if (minVal === 0 && maxVal < 60000) {
			if (maxVal < 1000) {
				listPrice.textContent = "≤ " + maxVal + " triệu";
			} else {
				listPrice.textContent = "≤ " + maxVal / 1000 + " tỷ";
			}
		} else {
			if (minVal < 1000 && maxVal < 1000) {
				listPrice.textContent = minVal + " - " + maxVal + " triệu";
			} else if (minVal < 1000 && maxVal >= 1000) {
				listPrice.textContent = minVal + " triệu" + " - " + maxVal / 1000 + " tỷ";
			} else {
				listPrice.textContent = minVal / 1000 + " - " + maxVal / 1000 + " tỷ";
			}
		}
	}

	priceInput.forEach((input) => {
		input.addEventListener("input", (e) => {
			let minPrice = parseInt(priceInput[0].value),
				maxPrice = parseInt(priceInput[1].value);

			if (maxPrice - minPrice >= priceGap && maxPrice <= priceRangeInput[1].max) {
				priceRangeInput[0].value = minPrice;
				priceRangeInput[1].value = maxPrice;
				updatePriceSlider();
				updateListPrice(minPrice, maxPrice);
			}
		});
	});

	priceInput.forEach((input) => {
		input.addEventListener("change", (e) => {
			let minPrice = parseInt(priceInput[0].value),
				maxPrice = parseInt(priceInput[1].value);

			if (maxPrice - minPrice >= priceGap && maxPrice <= priceRangeInput[1].max) {
				priceRangeInput[0].value = minPrice;
				priceRangeInput[1].value = maxPrice;
				updatePriceSlider();
				updateListPrice(minPrice, maxPrice);
			}
		});
	});

	priceRangeInput.forEach((input) => {
		input.addEventListener("input", (e) => {
			let minVal = parseInt(priceRangeInput[0].value),
				maxVal = parseInt(priceRangeInput[1].value);

			if (maxVal - minVal < priceGap) {
				if (e.target.className === "range-min") {
					priceRangeInput[0].value = maxVal - priceGap;
				} else {
					priceRangeInput[1].value = minVal + priceGap;
				}
			} else {
				updatePriceSlider();
				updateListPrice(minVal, maxVal);
			}
		});
	});

	document.getElementById("reset-search-price").addEventListener("click", () => {
		let minVal = 0,
			maxVal = 60000;

		priceInput[0].value = minVal;
		priceInput[1].value = maxVal;
		priceRange.style.left = (minVal / priceRangeInput[0].max) * 100 + "%";
		priceRange.style.right = 100 - (maxVal / priceRangeInput[1].max) * 100 + "%";

		updateListPrice(minVal, maxVal);
	});

	window.addEventListener('load', () => {
		<% if(minPriceFloat != null && maxPriceFloat != null) { %>
			let minVal,
				maxVal;

			minVal = priceInput[0].value;
			maxVal = priceInput[1].value;
			priceRange.style.left = (minVal / priceRangeInput[0].max) * 100 + "%";
			priceRange.style.right = 100 - (maxVal / priceRangeInput[1].max) * 100 + "%";

			updateListPrice(minVal, maxVal);
		<% } %>
        });

	// AREA RANGE SLIDER
	const areaRangeInput = document.querySelectorAll(".area-range-slider .range-input input"),
		areaInput = document.querySelectorAll(".area-range-slider .area-input input"),
		areaRange = document.querySelector(".area-range-slider .slider .progress");
	let areaPriceGap = 5;

	function updateAreaSlider() {
		let minVal = parseInt(areaRangeInput[0].value),
			maxVal = parseInt(areaRangeInput[1].value);

		areaInput[0].value = minVal;
		areaInput[1].value = maxVal;
		areaRange.style.left = (minVal / areaRangeInput[0].max) * 100 + "%";
		areaRange.style.right = 100 - (maxVal / areaRangeInput[1].max) * 100 + "%";
	}

	function updateListArea(minVal, maxVal) {
		const listArea = document.getElementById("list-area");

		if (minVal === 0 && maxVal <= 500) {
			listArea.textContent = "≤ " + maxVal + " m²";
		} else if (minVal > 0 && maxVal <= 500) {
			listArea.textContent = minVal + " - " + maxVal + " m²";
		}
	}

	areaInput.forEach((input) => {
		input.addEventListener("input", (e) => {
			let minVal = parseInt(areaInput[0].value),
				maxVal = parseInt(areaInput[1].value);

			if (maxVal - minVal >= areaPriceGap && maxVal <= areaRangeInput[1].max) {
				areaRangeInput[0].value = minVal;
				areaRangeInput[1].value = maxVal;
				updateAreaSlider();
				updateListArea(minVal, maxVal);
			}
		});
	});

	areaRangeInput.forEach((input) => {
		input.addEventListener("input", (e) => {
			let minVal = parseInt(areaRangeInput[0].value),
				maxVal = parseInt(areaRangeInput[1].value);

			if (maxVal - minVal < areaPriceGap) {
				if (e.target.className === "range-min") {
					areaRangeInput[0].value = maxVal - areaPriceGap;
				} else {
					areaRangeInput[1].value = minVal + areaPriceGap;
				}
			} else {
				updateAreaSlider();
				updateListArea(minVal, maxVal);
			}
		});
	});

	document.getElementById("reset-search-area").addEventListener("click", () => {
			let minVal = 0,
				maxVal = 500;

			areaInput[0].value = minVal;
			areaInput[1].value = maxVal;
			areaRange.style.left = (minVal / areaRangeInput[0].max) * 100 + "%";
			areaRange.style.right = 100 - (maxVal / areaRangeInput[1].max) * 100 + "%";

			updateListArea(minVal, maxVal);
      });

	window.addEventListener('load', () => {
  	  <%if (minAreaFloat != null && maxAreaFloat != null) {%>
		let minVal,
			maxVal;

		minVal = areaInput[0].value;
		maxVal = areaInput[1].value;
		areaRange.style.left = (minVal / areaRangeInput[0].max) * 100 + "%";
		areaRange.style.right = 100 - (maxVal / areaRangeInput[1].max) * 100 + "%";

		updateListArea(minVal, maxVal);
       <%}%>
	});

	var typeAll = document.getElementById("check-all");
	var type1 = document.getElementById("1");
	var type2 = document.getElementById("2");
	var type3 = document.getElementById("3");
	var type4 = document.getElementById("4");
	var type5 = document.getElementById("5");
	var type6 = document.getElementById("6");
	var type7 = document.getElementById("7");
	var type8 = document.getElementById("8");
	var type9 = document.getElementById("9");
	var type10 = document.getElementById("10");
	var type11 = document.getElementById("11");
	var type12 = document.getElementById("12");
	var type13 = document.getElementById("13");

	document.getElementById("all").addEventListener("click", () => {
		if (typeAll.checked) {
			type1.checked = true;
			type2.checked = true;
			type3.checked = true;
			type4.checked = true;
			type5.checked = true;
			type6.checked = true;
			type7.checked = true;
			type8.checked = true;
			type9.checked = true;
			type10.checked = true;
			type11.checked = true;
			type12.checked = true;
			type13.checked = true;
		} else {
			type1.checked = false;
			type2.checked = false;
			type3.checked = false;
			type4.checked = false;
			type5.checked = false;
			type6.checked = false;
			type7.checked = false;
			type8.checked = false;
			type9.checked = false;
			type10.checked = false;
			type11.checked = false;
			type12.checked = false;
			type13.checked = false;
		}
	});

	document.getElementById("check-type-of-house").addEventListener("click", () => {
		if (type2.checked) {
			type3.checked = true;
			type4.checked = true;
			type5.checked = true;
			type6.checked = true;
		} else {
			type3.checked = false;
			type4.checked = false;
			type5.checked = false;
			type6.checked = false;
		}
	});

	document.getElementById("check-type-of-land").addEventListener("click", () => {
		if (type7.checked) {
			type8.checked = true;
			type9.checked = true;
		} else {
			type8.checked = false;
			type9.checked = false;
		}
	});

	document.getElementById("check-type-of-farm").addEventListener("click", () => {
		if (type10.checked) {
			type11.checked = true;
		} else {
			type11.checked = false;
		}
	});

	document.getElementById("reset-search-type").addEventListener("click", () => {
		typeAll.checked = false;
		type1.checked = false;
		type2.checked = false;
		type3.checked = false;
		type4.checked = false;
		type5.checked = false;
		type6.checked = false;
		type7.checked = false;
		type8.checked = false;
		type9.checked = false;
		type10.checked = false;
		type11.checked = false;
		type12.checked = false;
		type13.checked = false;
	});

	let selectedTypes = [];

	function updateListType() {
		const listType = document.getElementById("list-type");

		listType.textContent = "";

		if (selectedTypes.length === 0) {
			listType.textContent = "Tất cả";
		} else {
			for (let i = 0; i < selectedTypes.length; i++) {
				if (selectedTypes[i].length > 0) {
					listType.textContent += selectedTypes[i];

					if (i < selectedTypes.length - 1 && selectedTypes.length > 1) {
						listType.textContent += ", ";
					}
				}
			}
		}
	}

	function checkSelectedTypes() {
		if (typeAll.checked) {
			selectedTypes = [
				"Bất động sản khác",
				"Kho, nhà xưởng",
				"Trang trại, khu nghỉ dưỡng",
				"Các loại đất bán",
				"Các loại nhà bán",
				"Căn hộ chung cư",
			];
		} else if (
			!typeAll.checked &&
			!type1.checked &&
			!type2.checked &&
			!type3.checked &&
			!type4.checked &&
			!type5.checked &&
			!type6.checked &&
			!type7.checked &&
			!type8.checked &&
			!type9.checked &&
			!type10.checked &&
			!type11.checked &&
			!type12.checked &&
			!type13.checked
		) {
			selectedTypes = [];
		} else {
			selectedTypes = [
				type1.checked ? "Căn hộ chung cư" : "",
				type2.checked ? "Các loại nhà bán" : "",
				!type2.checked && type3.checked ? "Nhà riêng" : "",
				!type2.checked && type4.checked ? "Nhà biệt thự, liền kề" : "",
				!type2.checked && type5.checked ? "Nhà mặt phố" : "",
				!type2.checked && type6.checked ? "Shophouse, nhà phố thương mại" : "",
				type7.checked ? "Các loại đất bán" : "",
				!type7.checked && type8.checked ? "Đất nền dự án" : "",
				!type7.checked && type9.checked ? "Bán đất" : "",
				type10.checked ? "Trang trại, khu nghỉ dưỡng" : "",
				!type10.checked && type11.checked ? "Condotel" : "",
				type12.checked ? "Kho, nhà xưởng" : "",
				type13.checked ? "Bất động sản khác" : "",
			];
		}
	}

	document.querySelectorAll(".menu-type .menu-list label").forEach((e) => {
		e.addEventListener("change", () => {
			const labelContent = e.querySelector("span").innerText;
			const typeId = e.querySelector("input").id;

			if (
				!type1.checked ||
				!type2.checked ||
				!type3.checked ||
				!type4.checked ||
				!type5.checked ||
				!type6.checked ||
				!type7.checked ||
				!type8.checked ||
				!type9.checked ||
				!type10.checked ||
				!type11.checked ||
				!type12.checked ||
				!type13.checked
			) {
				typeAll.checked = false;
			} else {
				typeAll.checked = true;
			}

			if (!type3.checked || !type4.checked || !type5.checked || !type6.checked) {
				type2.checked = false;
			} else {
				type2.checked = true;
			}

			if (!type8.checked || !type9.checked) {
				type7.checked = false;
			} else {
				type7.checked = true;
			}

			if (!type11.checked) {
				type10.checked = false;
			}

			checkSelectedTypes();

			// Cập nhật lại nội dung của #list-type
			updateListType();
		});
	});


	// FILTER MORE
	$(".list__items .item").click((event) => {
	    $(event.target).toggleClass("active");
	
	    var amountSearchMore = 0;
	
	    $(".list__items .item").each(function() {
	        if ($(this).hasClass("active")) {
	            amountSearchMore++;
	        }
	    });
	
	    if (amountSearchMore > 0) {
	        $(".amount-search-more").css("display", "block").text(amountSearchMore);
	    } else {
	        $(".amount-search-more").css("display", "none");
	    }
	});
	
	$("#reset-search-more").on("click", () => {
		$(".list__items.number-of-bedrooms .item").removeClass("active")
		$(".list__items.number-of-toilets .item").removeClass("active")
		$(".list__items.directions .item").removeClass("active")
		$(".amount-search-more").css("display", "none")
	})

	// HANLE SEARCH BY ADDRESS
	let provinceId = null;
	let districtId = null;
	let wardId = null;

	let flagDistrict = false;
	let flagWard = false;
	
	const listAddress = $("#list-address");

	$('.list-provinces').on('click', 'label', function() {
		$("#province-menu").css("display", "none");
		
		provinceId = $(this).attr('provinceId');

		if (provinceId === "all") {
			$("#button-choose-province").removeClass("has-value");
			listAddress.text("Tất cả");
		} else {
			$("#button-choose-province").addClass("has-value");
			$("#button-choose-district").removeClass("has-value");
			$("#button-choose-ward").removeClass("has-value");

			districtId = null;
			wardId = null;
			
			$("#button-choose-province .listing-search-current-text").text($(this).text());
			listAddress.text($(this).text());
			

			$.ajax({
				type: 'GET',
				url: '${pageContext.servletContext.contextPath}/getDistrictsByProvince.html',
				data: { provinceId: provinceId },
				dataType: 'text',
				success: function(data) {
					var lines = data.split('\n');
					$.each(lines, function(index, line) {
						if (index < lines.length - 1) {
							var parts = line.split(':');
							$('.list-districts').append(
								"<label districtId='" + parts[0] + "'>" +
								"<span>" + parts[1] + "</span>" +
								"<i class='fa-solid fa-angle-right'></i>" +
								"</label>"
							);
						}
					});
					flagDistrict = true;
				},
				error: function(xhr, status, error) {
					console.error("Error occurred:", error);
				}
			});
		}
	});


	$('.list-districts').on('click', 'label', function() {
		$("#district-menu").css("display", "none");
		
		districtId = $(this).attr('districtId');

		if (districtId === null) {
			$("#button-choose-district").removeClass("has-value");
			listAddress.text($("#button-choose-province .listing-search-current-text").text());
		} else {
			$("#button-choose-district").addClass("has-value");
			$("#button-choose-ward").removeClass("has-value");
			
			wardId = null;
			
			$("#button-choose-district .listing-search-current-text").text($(this).text());
			listAddress.text($("#button-choose-province .listing-search-current-text").text() + ", " + $(this).text());

			$.ajax({
				type: 'GET',
				url: '${pageContext.servletContext.contextPath}/getWardsByDistrict.html',
				data: { districtId: districtId },
				dataType: 'text',
				success: function(data) {
					var lines = data.split('\n');
					$.each(lines, function(index, line) {
						if (index < lines.length - 1) {
							var parts = line.split(':');
							$('.list-wards').append(
								"<label wardId='" + parts[0] + "'>" +
								"<span>" + parts[1] + "</span>" +
								"<i class='fa-solid fa-angle-right'></i>" +
								"</label>"
							);
						}
					});
					flagWard = true;
				},
				error: function(xhr, status, error) {
					console.error("Error occurred:", error);
				}
			});
		}
	});

	$('.list-wards').on('click', 'label', function() {
		$("#ward-menu").css("display", "none");
		
		wardId = $(this).attr('wardId');

		if (wardId === null) {
			$("#button-choose-ward").removeClass("has-value");
			listAddress.text($("#button-choose-province .listing-search-current-text").text() + ", " + $("#button-choose-district .listing-search-current-text").text());
		} else {
			$("#button-choose-ward").addClass("has-value");
			$("#button-choose-ward .listing-search-current-text").text($(this).text());
			listAddress.text($("#button-choose-province .listing-search-current-text").text() + ", " + $("#button-choose-district .listing-search-current-text").text() + ", " + $(this).text());
		}
	});
	

	$("#button-choose-province").on("click", () => {
		$("#province-menu").css("display", "block");
	});

	$("#close-province-menu").on("click", () => {
		$("#province-menu").css("display", "none");
	});
	
	$("#button-choose-province .fa-xmark").on("click", (event) => {
		event.stopPropagation();
		
		 provinceId = null;
		 districtId = null;
		 wardId = null;
		 
		 $("#button-choose-province").removeClass("has-value");
		 $("#button-choose-district").removeClass("has-value");
		 $("#button-choose-ward").removeClass("has-value");
		
		 $("#button-choose-province .listing-search-current-text").text("");
		 $("#button-choose-district .listing-search-current-text").text("");
		 $("#button-choose-ward .listing-search-current-text").text("");
		 
		 listAddress.text("Toàn quốc");
	})

	$("#button-choose-district").on("click", () => {
		if (provinceId === "all" || provinceId === null || !flagDistrict) {
			console.log("Chưa chọn tỉnh thành")
		} else {
			$("#district-menu").css("display", "block");
		}
	});

	$("#close-district-menu").on("click", () => {
		$("#district-menu").css("display", "none");
	});
	
	$("#button-choose-district .fa-xmark").on("click", (event) => {
		event.stopPropagation();
		
		 $("#district-menu").css("display", "none"); 
		
		 districtId = null;
		 wardId = null;
		 
		 $("#button-choose-district").removeClass("has-value");
		 $("#button-choose-ward").removeClass("has-value");
		
		 $("#button-choose-district .listing-search-current-text").text("");
		 $("#button-choose-ward .listing-search-current-text").text("");
		 
		 listAddress.text($("#button-choose-province .listing-search-current-text").text());
	})

	$("#button-choose-ward").on("click", () => {
		if (districtId === null || !flagWard) {
			console.log("Chưa chọn quận huyện")
		} else {
			$("#ward-menu").css("display", "block");
		}
	});

	$("#close-ward-menu").on("click", () => {
		$("#ward-menu").css("display", "none");
	})
	
	$("#button-choose-ward .fa-xmark").on("click", (event) => {
		event.stopPropagation();
		
		 $("#ward-menu").css("display", "none"); 
		
		 wardId = null;
		 
		 $("#button-choose-ward").removeClass("has-value");
		
		 $("#button-choose-ward .listing-search-current-text").text("");
		 
		 listAddress.text($("#button-choose-province .listing-search-current-text").text() + ", " + $("#button-choose-district .listing-search-current-text").text());
	})
	
	$("#reset-search-address").on("click", () => {
		 provinceId = null;
		 districtId = null;
		 wardId = null;
		 
		 $("#button-choose-province").removeClass("has-value");
		 $("#button-choose-district").removeClass("has-value");
		 $("#button-choose-ward").removeClass("has-value");
		
		 $("#button-choose-province .listing-search-current-text").text("");
		 $("#button-choose-district .listing-search-current-text").text("");
		 $("#button-choose-ward .listing-search-current-text").text("");
		 
		 listAddress.text("Toàn quốc");
	})
	
	// HANDLE SEARCH BY SEARCH INPUT
	let searchInput = $(".search-bar__input input");
	let searchInputButton = $(".search-bar__input .fa-magnifying-glass");
	
	// HANDLE SEARCH
	$(searchInputButton).on("click", handleSearch);
	$(searchInput).on("keyup", function(event) {
	    if (event.which === 13) { // Enter key code
	        event.preventDefault(); // Prevent default form submission if necessary
	        handleSearch();
	    }
	});
	
	function handleSearch() {
	    let listCategoryId = [];
	    if (typeAll.checked) {
	        listCategoryId.push(12, 13, 14, 15, 16, 17, 18, 19, 20, 21);
	    } else {
	        if (type1.checked) listCategoryId.push(12);
	        if (type2.checked) listCategoryId.push(13);
	        if (type3.checked) listCategoryId.push(14);
	        if (type4.checked) listCategoryId.push(15);
	        if (type5.checked) listCategoryId.push(16);
	        if (type6.checked) listCategoryId.push(17);
	        if (type7.checked) listCategoryId.push(18);
	        if (type8.checked) listCategoryId.push(19);
	        if (type9.checked) listCategoryId.push(20);
	        if (type10.checked) listCategoryId.push(21);
	    }
	
	    let listNumberOfBedrooms = [];
	    $(".list__items.number-of-bedrooms .item.active").each((index, element) => {
	        listNumberOfBedrooms.push(parseInt($(element).text()));
	    });
	
	    let listNumberOfToilets = [];
	    $(".list__items.number-of-toilets .item.active").each((index, element) => {
	        listNumberOfToilets.push(parseInt($(element).text()));
	    });
	
	    let listDirections = [];
	    $(".list__items.directions .item.active").each((index, element) => {
	        listDirections.push($(element).text());
	    });
	
	    var price = document.querySelectorAll(".price-range-slider .price-input input");
	    let minPrice;
	    let maxPrice;
	
	    if (price[0].value === "" && price[1].value === "") {
	        minPrice = -1;
	        maxPrice = -1;
	    } else {
	        minPrice = price[0].value * 1000000;
	        maxPrice = price[1].value * 1000000;
	    }
	
	    var area = document.querySelectorAll(".area-range-slider .area-input input");
	    let minArea;
	    let maxArea;
	
	    if (area[0].value === "" && area[1].value === "") {
	        minArea = -1;
	        maxArea = -1;
	    } else {
	        minArea = area[0].value;
	        maxArea = area[1].value;
	    }
	
	    let searchInputVal = searchInput.val();
	
	    let url = "${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html";
	
	    let hasParameters = false;
	
	    if (listCategoryId.length > 0) {
	        url += hasParameters ? "&" : "?";
	        url += "categoryIds=" + listCategoryId.join(",");
	        hasParameters = true;
	    }
	
	    if (minPrice >= 0 && maxPrice >= 0) {
	        url += hasParameters ? "&" : "?";
	        url += "minPrice=" + minPrice + "&maxPrice=" + maxPrice;
	        hasParameters = true;
	    }
	
	    if (minArea >= 0 && maxArea >= 0) {
	        url += hasParameters ? "&" : "?";
	        url += "minArea=" + minArea + "&maxArea=" + maxArea;
	        hasParameters = true;
	    }
	
	    if (listNumberOfBedrooms.length > 0) {
	        url += hasParameters ? "&" : "?";
	        url += "numberOfBedrooms=" + listNumberOfBedrooms.join(",");
	        hasParameters = true;
	    }
	
	    if (listNumberOfToilets.length > 0) {
	        url += hasParameters ? "&" : "?";
	        url += "numberOfToilets=" + listNumberOfToilets.join(",");
	        hasParameters = true;
	    }
	
	    if (listDirections.length > 0) {
	        url += hasParameters ? "&" : "?";
	        url += "directions=" + listDirections.join(",");
	        hasParameters = true;
	    }
	
	    if (typeof provinceId !== 'undefined' && provinceId !== null) {
	        url += hasParameters ? "&" : "?";
	        url += "provinceId=" + provinceId;
	        hasParameters = true;
	    }
	
	    if (typeof districtId !== 'undefined' && districtId !== null) {
	        url += hasParameters ? "&" : "?";
	        url += "districtId=" + districtId;
	        hasParameters = true;
	    }
	
	    if (typeof wardId !== 'undefined' && wardId !== null) {
	        url += hasParameters ? "&" : "?";
	        url += "wardId=" + wardId;
	        hasParameters = true;
	    }
	
	    if (searchInputVal !== "") {
	        url += hasParameters ? "&" : "?";
	        url += "searchInput=" + searchInputVal;
	    }
	
	    window.location.href = url;
	}


	$("#reset-all-button").click(() => {
		let url;
		url = "${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html";
		window.location.href = url;
	})

	$(".menu-price label").click((e) => {
		let listCategoryId = [];
	    if (typeAll.checked) {
			listCategoryId.push(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11);
		} else {
			if (type1.checked) {
				listCategoryId.push(1);
			}
			if (type3.checked) {
				listCategoryId.push(2);
			}
			if (type4.checked) {
				listCategoryId.push(3);
			}
			if (type5.checked) {
				listCategoryId.push(4);
			}
			if (type6.checked) {
				listCategoryId.push(5);
			}
			if (type8.checked) {
				listCategoryId.push(6);
			}
			if (type9.checked) {
				listCategoryId.push(7);
			}
			if (type10.checked) {
				listCategoryId.push(8);
			}
			if (type11.checked) {
				listCategoryId.push(9);
			}
			if (type12.checked) {
				listCategoryId.push(10);
			}
			if (type13.checked) {
				listCategoryId.push(11);
			}
		}

	    let listNumberOfBedrooms = [];
	    $(".list__items.number-of-bedrooms .item.active").each((index, element) => {
	        listNumberOfBedrooms.push(parseInt($(element).text()));
	    });
	
	    let listNumberOfToilets = [];
	    $(".list__items.number-of-toilets .item.active").each((index, element) => {
	        listNumberOfToilets.push(parseInt($(element).text()));
	    });
	    
	    let listDirections = [];
	    $(".list__items.directions .item.active").each((index, element) => {
	    	listDirections.push($(element).text());
	    });

		let minPrice;
		let maxPrice;
		let unit;

		if (e.target.textContent.trim() === "Tất cả mức giá") {
			minPrice = -1;
			maxPrice = -1;
		} else if (e.target.textContent.trim() === "Dưới 500 triệu") {
			minPrice = 0;
			maxPrice = 500000000;
		} else if (e.target.textContent.trim() === "500 - 800 triệu") {
			minPrice = 500000000;
			maxPrice = 800000000;
		} else if (e.target.textContent.trim() === "800 triệu - 1 tỷ") {
			minPrice = 800000000;
			maxPrice = 1000000000;
		} else if (e.target.textContent.trim() === "1 - 2 tỷ") {
			minPrice = 1000000000;
			maxPrice = 2000000000;
		} else if (e.target.textContent.trim() === "2 - 3 tỷ") {
			minPrice = 2000000000;
			maxPrice = 3000000000;
		} else if (e.target.textContent.trim() === "3 - 5 tỷ") {
			minPrice = 3000000000;
			maxPrice = 5000000000;
		} else if (e.target.textContent.trim() === "5 - 7 tỷ") {
			minPrice = 5000000000;
			maxPrice = 7000000000;
		} else if (e.target.textContent.trim() === "7 - 10 tỷ") {
			minPrice = 7000000000;
			maxPrice = 10000000000;
		} else if (e.target.textContent.trim() === "10 - 20 tỷ") {
			minPrice = 10000000000;
			maxPrice = 20000000000;
		} else if (e.target.textContent.trim() === "20 - 30 tỷ") {
			minPrice = 20000000000;
			maxPrice = 30000000000;
		} else if (e.target.textContent.trim() === "30 - 40 tỷ") {
			minPrice = 30000000000;
			maxPrice = 40000000000;
		} else if (e.target.textContent.trim() === "40 - 60 tỷ") {
			minPrice = 40000000000;
			maxPrice = 60000000000;
		} else if (e.target.textContent.trim() === "Trên 60 tỷ") {
			minPrice = 60000000000;
			maxPrice = 600000000000;
		} else if (e.target.textContent.trim() === "Thỏa thuận") {
			unit = "thoa-thuan";
		}
		
		var area = document.querySelectorAll(".area-range-slider .area-input input")
		let minArea;
	    let maxArea;
	    
	    if(area[0].value==="" && area[1].value==="") {
	    	minArea = -1;
	    	maxArea = -1;
	    } else {
	    	minArea = area[0].value;
	        maxArea = area[1].value;
	    }

	    let searchInput = $(".search-bar__input input").val();

	    let url = "${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html";
		
	    let hasParameters = false;
	
	    if (listCategoryId.length > 0) {
	        url += hasParameters ? "&" : "?";
	        url += "categoryIds=" + listCategoryId.join(",");
	        hasParameters = true;
	    }
	
	    if (minPrice >= 0 && maxPrice >= 0) {
	        url += hasParameters ? "&" : "?";
	        url += "minPrice=" + minPrice + "&maxPrice=" + maxPrice;
	        hasParameters = true;
	    }
	    
	    if (unit === "thoa-thuan") {
	    	url += hasParameters ? "&" : "?";
			url += "unit=thoa-thuan"
		    hasParameters = true;
		}
	
	    if (minArea >= 0 && maxArea >= 0) {
	        url += hasParameters ? "&" : "?";
	        url += "minArea=" + minArea + "&maxArea=" + maxArea;
	        hasParameters = true;
	    }
	
	    if (listNumberOfBedrooms.length > 0) {
	        url += hasParameters ? "&" : "?";
	        url += "numberOfBedrooms=" + listNumberOfBedrooms.join(",");
	        hasParameters = true;
	    }
	
	    if (listNumberOfToilets.length > 0) {
	        url += hasParameters ? "&" : "?";
	        url += "numberOfToilets=" + listNumberOfToilets.join(",");
	        hasParameters = true;
	    }
	    
	    if (listDirections.length > 0) {
	        url += hasParameters ? "&" : "?";
	        url += "directions=" + listDirections.join(",");
	        hasParameters = true;
	    }
	    
	    if(provinceId !== null) {
	        url += hasParameters ? "&" : "?";
	        url += "provinceId=" + provinceId;
	        hasParameters = true;
	    }
	    
	    if(districtId !== null) {
	        url += hasParameters ? "&" : "?";
	        url += "districtId=" + districtId;
	        hasParameters = true;
	    }
	    
	    if(wardId !== null) {
	        url += hasParameters ? "&" : "?";
	        url += "wardId=" + wardId;
	        hasParameters = true;
	    }
	    
	    if(searchInput !== "") {
	        url += hasParameters ? "&" : "?";
	        url += "searchInput=" + searchInput;
	    }
	
	    window.location.href = url;
		
	});

	$(".menu-area label").click((e) => {
		let listCategoryId = [];
	    if (typeAll.checked) {
			listCategoryId.push(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11);
		} else {
			if (type1.checked) {
				listCategoryId.push(1);
			}
			if (type3.checked) {
				listCategoryId.push(2);
			}
			if (type4.checked) {
				listCategoryId.push(3);
			}
			if (type5.checked) {
				listCategoryId.push(4);
			}
			if (type6.checked) {
				listCategoryId.push(5);
			}
			if (type8.checked) {
				listCategoryId.push(6);
			}
			if (type9.checked) {
				listCategoryId.push(7);
			}
			if (type10.checked) {
				listCategoryId.push(8);
			}
			if (type11.checked) {
				listCategoryId.push(9);
			}
			if (type12.checked) {
				listCategoryId.push(10);
			}
			if (type13.checked) {
				listCategoryId.push(11);
			}
		}

	    let listNumberOfBedrooms = [];
	    $(".list__items.number-of-bedrooms .item.active").each((index, element) => {
	        listNumberOfBedrooms.push(parseInt($(element).text()));
	    });
	
	    let listNumberOfToilets = [];
	    $(".list__items.number-of-toilets .item.active").each((index, element) => {
	        listNumberOfToilets.push(parseInt($(element).text()));
	    });
	    
	    let listDirections = [];
	    $(".list__items.directions .item.active").each((index, element) => {
	    	listDirections.push($(element).text());
	    });
		
	    var price = document.querySelectorAll(".price-range-slider .price-input input")
	    let minPrice;
	    let maxPrice;
	    
	    if(price[0].value==="" && price[1].value==="") {
	    	minPrice = -1;
	    	maxPrice = -1;
	    } else {
	        minPrice = price[0].value * 1000000;
	        maxPrice = price[1].value * 1000000;
	    }

		let minArea;
		let maxArea;

		if (e.target.textContent.trim() === "Tất cả diện tích") {
			minArea = -1;
			maxPrice = -1;
		} else if (e.target.textContent.trim() === "Dưới 30 m²") {
			minArea = 0;
			maxArea = 30;
		} else if (e.target.textContent.trim() === "30 - 50 m²") {
			minArea = 30;
			maxArea = 50;
		} else if (e.target.textContent.trim() === "50 - 100 m²") {
			minArea = 50;
			maxArea = 100;
		} else if (e.target.textContent.trim() === "100 - 150 m²") {
			minArea = 100;
			maxArea = 150;
		} else if (e.target.textContent.trim() === "150 - 200 m²") {
			minArea = 150;
			maxArea = 200;
		} else if (e.target.textContent.trim() === "200 - 250 m²") {
			minArea = 200;
			maxArea = 250;
		} else if (e.target.textContent.trim() === "250 - 300 m²") {
			minArea = 250;
			maxArea = 300;
		} else if (e.target.textContent.trim() === "300 - 500 m²") {
			minArea = 300;
			maxArea = 500;
		} else if (e.target.textContent.trim() === "Trên 500 m²") {
			minArea = 500;
			maxArea = 10000;
		}

	    let searchInput = $(".search-bar__input input").val();

	    let url = "${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html";
		
	    let hasParameters = false;
	
	    if (listCategoryId.length > 0) {
	        url += hasParameters ? "&" : "?";
	        url += "categoryIds=" + listCategoryId.join(",");
	        hasParameters = true;
	    }
	
	    if (minPrice >= 0 && maxPrice >= 0) {
	        url += hasParameters ? "&" : "?";
	        url += "minPrice=" + minPrice + "&maxPrice=" + maxPrice;
	        hasParameters = true;
	    }
	
	    if (minArea >= 0 && maxArea >= 0) {
	        url += hasParameters ? "&" : "?";
	        url += "minArea=" + minArea + "&maxArea=" + maxArea;
	        hasParameters = true;
	    }
	
	    if (listNumberOfBedrooms.length > 0) {
	        url += hasParameters ? "&" : "?";
	        url += "numberOfBedrooms=" + listNumberOfBedrooms.join(",");
	        hasParameters = true;
	    }
	
	    if (listNumberOfToilets.length > 0) {
	        url += hasParameters ? "&" : "?";
	        url += "numberOfToilets=" + listNumberOfToilets.join(",");
	        hasParameters = true;
	    }
	    
	    if (listDirections.length > 0) {
	        url += hasParameters ? "&" : "?";
	        url += "directions=" + listDirections.join(",");
	        hasParameters = true;
	    }
	    
	    if(provinceId !== null) {
	        url += hasParameters ? "&" : "?";
	        url += "provinceId=" + provinceId;
	        hasParameters = true;
	    }
	    
	    if(districtId !== null) {
	        url += hasParameters ? "&" : "?";
	        url += "districtId=" + districtId;
	        hasParameters = true;
	    }
	    
	    if(wardId !== null) {
	        url += hasParameters ? "&" : "?";
	        url += "wardId=" + wardId;
	        hasParameters = true;
	    }
	    
	    if(searchInput !== "") {
	        url += hasParameters ? "&" : "?";
	        url += "searchInput=" + searchInput;
	    }
	
	    window.location.href = url;
	});
	
	// Call the function when the page is loaded
	window.addEventListener('load', () => {
		if (typeAll.checked) {
			type1.checked = true;
			type2.checked = true;
			type3.checked = true;
			type4.checked = true;
			type5.checked = true;
			type6.checked = true;
			type7.checked = true;
			type8.checked = true;
			type9.checked = true;
			type10.checked = true;
			type11.checked = true;
			type12.checked = true;
			type13.checked = true;
		}

		if (type2.checked) {
			type3.checked = true;
			type4.checked = true;
			type5.checked = true;
			type6.checked = true;
		}

		if (type7.checked) {
			type8.checked = true;
			type9.checked = true;
		}

		if (type10.checked) {
			type11.checked = true;
		}

		checkSelectedTypes();
		updateListType();
		
		let currentURL = decodeURIComponent(window.location.href);
		let firstQuestionMarkIndex = currentURL.indexOf("?");

		if (firstQuestionMarkIndex !== -1) {
		    let queryString = currentURL.substring(firstQuestionMarkIndex + 1);
		    let pairs = queryString.split("&");
		    
		    // Tạo đối tượng rỗng để lưu trữ kết quả
		    const result = {};

		    // Duyệt qua mỗi cặp key=value và thêm vào đối tượng kết quả
		    pairs.forEach(pair => {
		        const [key, value] = pair.split("=");
		        if (key && value) {
	                result[key] = decodeURIComponent(value);
		        }
		    });

		    let keyWord = "";
		    if (result['searchInput'] === "" || result['searchInput'] === undefined) {
		        keyWord = "";
		    } else {
		        keyWord = result['searchInput'];
		    }

		    document.querySelector(".search-bar__input input").value = keyWord;
		    
		    let amountSearchMore = 0;
		    if (result['numberOfBedrooms'] !== undefined) {
		        let listBedroom = result['numberOfBedrooms'].split(",").map(Number);
		        amountSearchMore += 1;
		        for (let i = 0; i < listBedroom.length; i++) {		            
		            $(".list__items.number-of-bedrooms .item.item-"+listBedroom[i]).addClass("active");
		        }
		    }

		    if (result['numberOfToilets'] !== undefined) {
		        let listToilet = result['numberOfToilets'].split(",").map(Number);
		        amountSearchMore += 1;
		        for (let i = 0; i < listToilet.length; i++) {		            
		            $(".list__items.number-of-toilets .item.item-"+listToilet[i]).addClass("active");
		        }
		    }
		    
		    if (result['directions'] !== undefined) {
		        let listDirection = result['directions'].split(",").map(String);
		        amountSearchMore += 1;
		        for (let i = 0; i < listDirection.length; i++) {    
		            $(".list__items.directions .item.item-" + listDirection[i].trim()).addClass("active");
		        }
		    }
		    
		    if(amountSearchMore > 0) {
		    	$(".amount-search-more").css("display", "block").text(amountSearchMore)
		    }
		    		    
		    if(result['provinceId'] !== undefined) {
		    	provinceId = result['provinceId']
		    	
		    	$.ajax({
					type: 'GET',
					url: '${pageContext.servletContext.contextPath}/getProvinceById.html',
					data: { provinceId: result['provinceId'] },
					dataType: 'text',
					success: function(data) {
						$("#button-choose-province").addClass("has-value");						
						$("#button-choose-province .listing-search-current-text").text(data);
						listAddress.text($("#button-choose-province .listing-search-current-text").text() + ", " + $("#button-choose-district .listing-search-current-text").text() + ", " + $("#button-choose-ward .listing-search-current-text").text());
					},
					error: function(xhr, status, error) {
						console.error("Error occurred:", error);
					}
				});
		    }
		    
		    if(result['districtId'] !== undefined) {
		    	districtId = result['districtId']
		    	
		    	$.ajax({
					type: 'GET',
					url: '${pageContext.servletContext.contextPath}/getDistrictById.html',
					data: { districtId: result['districtId'] },
					dataType: 'text',
					success: function(data) {
						$("#button-choose-district").addClass("has-value");						
						$("#button-choose-district .listing-search-current-text").text(data);
					},
					error: function(xhr, status, error) {
						console.error("Error occurred:", error);
					}
				});
		    }
		    
		    if(result['wardId'] !== undefined) {
		    	wardId = result['wardId']
		    	
		    	$.ajax({
					type: 'GET',
					url: '${pageContext.servletContext.contextPath}/getWardById.html',
					data: { wardId: result['wardId'] },
					dataType: 'text',
					success: function(data) {
						$("#button-choose-ward").addClass("has-value");						
						$("#button-choose-ward .listing-search-current-text").text(data);
					},
					error: function(xhr, status, error) {
						console.error("Error occurred:", error);
					}
				});
		    }
		    
		    if (result['categoryIds'] !== undefined) {
		    	let listCategory = result['categoryIds'].split(",").map(Number);
		        for (let i = 0; i < listCategory.length; i++) {
	                $("[data-category-id='" + listCategory[i] + "']").css('color', 'rgb(228, 54, 54)');
	                break;
		        }
		    }
		    		   
		}

	});
});
</script>