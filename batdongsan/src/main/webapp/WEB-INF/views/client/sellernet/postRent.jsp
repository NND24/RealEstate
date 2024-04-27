<%@page import="batdongsan.models.ProvincesModel"%>
<%@page import="java.util.List"%>
<%@page import="batdongsan.models.CategoryModel"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Website số 1 về bất động sản</title>
<link rel="stylesheet" href="../../css/client/index.css" type="text/css">
<link rel="stylesheet" href="../../css/client/header.css"
	type="text/css">
<link rel="stylesheet" href="../../css/client/sellernet.css"
	type="text/css">
<link rel="stylesheet" href="../../css/client/post.css?version=51"
	type="text/css">
<%@ include file="../../../../links/links.jsp"%>


<base href="${pageContext.servletContext.contextPath}/">
</head>
<body>
	<%@ include file="../../../components/header.jsp"%>
	<div class='sellernet'>
		<%@ include file="../../../components/sellernetSidebar.jsp"%>

		<!-- Post -->
		<div class='post'>
			<form:form action="sellernet/addNewRealEstate.html" modelAttribute="realEstate"
				method="POST" enctype="multipart/form-data">


				<div class='input-wrapper'>

					<h3>Thông tin cơ bản</h3>

					<ul class='nav nav-tabs'>
						<li><a
							href='${pageContext.servletContext.contextPath}/sellernet/dang-tin/ban.html'>
								Bán </a></li>
						<li class='active'><a
							href='${pageContext.servletContext.contextPath}/sellernet/dang-tin/cho-thue.html'>
								Cho thuê </a></li>
					</ul>

					<div class='tab-content'>
						<div id='menu1' class='tab-pane fade in active'>
							<div class='form-item'>
								<p>
									Loại bất động sản <span>*</span>
								</p>
								<%
								List<CategoryModel> categories = (List<CategoryModel>) request.getAttribute("categories");
								%>
								<select name="categoryId">
									<%
									for (CategoryModel cat : categories) {
									%>
									<option value="<%=cat.getCategoryId()%>"><%=cat.getName()%></option>
									<%
									}
									%>
								</select>
							</div>
						</div>
					</div>

					<div class='address-container'>
						<div class='form-item'>
							<p>
								Tỉnh, thành phố <span>*</span>
							</p>
							<%
							List<ProvincesModel> provinces = (List<ProvincesModel>) request.getAttribute("provinces");
							%>
							<select name="provinceId" id="provinceId">
								<%
								for (ProvincesModel pro : provinces) {
								%>
								<option value="<%=pro.getProvinceId()%>"><%=pro.getName()%></option>
								<%
								}
								%>
							</select>
						</div>

						<div class='form-item'>
							<p>
								Quận, huyện <span>*</span>
							</p>
							<select name='districtId' id="districtId">
								<option>---Quận, huyện---</option>
							</select>
						</div>
					</div>

					<div class='address-container'>
						<div class='form-item'>
							<p>
								Phường, xã <span>*</span>
							</p>
							<select name='wardId' id="wardId">
								<option>---Phường, xã---</option>
							</select>
						</div>
						<div class='form-item'></div>
					</div>

					<div class='form-item'>
						<p>
							Địa chỉ hiển thị trên tin đăng <span>*</span>
						</p>
						<div class='input-container'>
							<form:input path='address'
								placeholder='Bạn có thể bổ sung hẻm, nghách, ngõ...'
								id="detail-address" />
						</div>
					</div>
				</div>

				<!-- Copy -->
				<div class='input-wrapper'>
					<h3>Thông tin bài viết</h3>
					<div class='form-item'>
						<p>
							Tiêu đề <span>*</span>
						</p>
						<form:textarea path='title' cols='30' rows='2'></form:textarea>
					</div>
					<div class='form-item'>
						<p>
							Mô tả <span>*</span>
						</p>
						<form:textarea id="editor" path='description' cols='30' rows='7'></form:textarea>

					</div>
				</div>

				<div class='input-wrapper'>
					<h3>Thông tin bất động sản</h3>

					<div class='form-item'>
						<p>
							Diện tích <span>*</span>
						</p>
						<div class='input-container'>
							<form:input path="area" placeholder="Nhập diện tích, VD: 80" />
							<span>m²</span>
						</div>
					</div>

					<div class='money-wrapper'>
						<div class='form-item'>
							<p>
								Mức giá <span>*</span>
							</p>
							<div class='input-container'>
								<form:input path="price" placeholder="Nhập giá, VD 12000000" />
							</div>
						</div>

						<div class='form-item'>
							<p>Đơn vị</p>
							<select name='unit'>
						        <option value='VND'>VND</option>
						        <option value='Giá / m²'>Giá / m²</option>
						        <option value='Thỏa thuận'>Thỏa thuận</option>
						    </select>
						</div>
					</div>

					<div class='form-item'>
						<p>Nội thất</p>
						<select name='interior'>
							<option value=''>---Nội thất---</option>
							<option value='Đầy đủ'>Đầy đủ</option>
							<option value='Cơ bản'>Cơ bản</option>
							<option value='Không nột thất'>Không nội thất</option>
						</select>
					</div>

					<div class='form-item'>
						<p>Số phòng ngủ</p>
						<div class='input-container'>
							<form:input path="numberOfBedrooms"
								placeholder="Nhập số phòng, VD: 2" />
							<span>phòng</span>
						</div>
					</div>
					<div class='form-item'>
						<p>Số phòng tắm, vệ sinh</p>
						<div class='input-container'>
							<form:input path="numberOfToilets"
								placeholder="Nhập số phòng, VD: 2" />
							<span>phòng</span>
						</div>
					</div>
					<div class='form-item'>
						<p>Hướng nhà</p>
						<select name='direction'>
							<option value=''>---Hướng nhà---</option>
							<option value='Bắc'>Bắc</option>
							<option value='Đông Bắc'>Đông Bắc</option>
							<option value='Đông'>Đông</option>
							<option value='Đông Nam'>Đông Nam</option>
							<option value='Nam'>Nam</option>
							<option value='Tây Nam'>Tây Nam</option>
							<option value='Tây'>Tây</option>
							<option value='Tây Bắc'>Tây Bắc</option>
						</select>
					</div>
				</div>

				<div class='input-wrapper'>
					<h3>Hình ảnh & Video</h3>
					<ul>
						<li>Đăng tối thiểu 4 ảnh</li>
						<li>Đăng tối đa 24 ảnh với tất cả các loại tin</li>
						<li>Hãy dùng ảnh thật, không trùng, không chèn SĐT</li>
						<li>Mỗi ảnh kích thước tối thiểu 100x100 px, tối đa 15 MB</li>
					</ul>
					<div class='input-image-wrapper'>
						<label htmlFor='file-input'
							onclick="document.getElementById('image').click()"> <svg
								width='80' height='80' viewBox='0 0 130 130' fill='none'
								xmlns='http://www.w3.org/2000/svg'>
                  <path
									d='M118.42 75.84C118.43 83.2392 116.894 90.5589 113.91 97.33H16.09C12.8944 90.0546 11.3622 82.1579 11.6049 74.2154C11.8477 66.2728 13.8593 58.4844 17.4932 51.4177C21.1271 44.3511 26.2918 38.1841 32.6109 33.3662C38.93 28.5483 46.2443 25.2008 54.0209 23.5676C61.7976 21.9345 69.8406 22.0568 77.564 23.9257C85.2873 25.7946 92.4965 29.363 98.6661 34.3709C104.836 39.3787 109.81 45.6999 113.228 52.8739C116.645 60.0478 118.419 67.8937 118.42 75.84Z'
									fill='#F2F2F2'></path>
                  <path d='M5.54 97.33H126.37' stroke='#63666A'
									strokeWidth='1' strokeMiterlimit='10' strokeLinecap='round'></path>
                  <path
									d='M97 97.33H49.91V34.65C49.91 34.3848 50.0154 34.1305 50.2029 33.9429C50.3904 33.7554 50.6448 33.65 50.91 33.65H84.18C84.6167 33.6541 85.0483 33.7445 85.4499 33.9162C85.8515 34.0878 86.2152 34.3372 86.52 34.65L96.02 44.15C96.3321 44.4533 96.5811 44.8153 96.7527 45.2151C96.9243 45.615 97.0152 46.0449 97.02 46.48L97 97.33Z'
									fill='#D7D7D7' stroke='#63666A' strokeWidth='1'
									strokeLinecap='round' strokeLinejoin='round'></path>
                  <path
									d='M59.09 105.64H42.09C41.8248 105.64 41.5704 105.535 41.3829 105.347C41.1954 105.16 41.09 104.905 41.09 104.64V41.79C41.09 41.5248 41.1954 41.2705 41.3829 41.0829C41.5704 40.8954 41.8248 40.79 42.09 40.79H77.33L89 52.42V104.62C89 104.885 88.8946 105.14 88.7071 105.327C88.5196 105.515 88.2652 105.62 88 105.62H74.86'
									fill='white'></path>
                  <path
									d='M59.09 105.64H42.09C41.8248 105.64 41.5704 105.535 41.3829 105.347C41.1954 105.16 41.09 104.905 41.09 104.64V41.79C41.09 41.5248 41.1954 41.2705 41.3829 41.0829C41.5704 40.8954 41.8248 40.79 42.09 40.79H77.33L89 52.42V104.62C89 104.885 88.8946 105.14 88.7071 105.327C88.5196 105.515 88.2652 105.62 88 105.62H74.86'
									stroke='#63666A' strokeWidth='1' strokeMiterlimit='10'
									strokeLinecap='round'></path>
                  <path d='M88.97 52.42H77.33V40.77L88.97 52.42Z'
									fill='#D7D7D7' stroke='#63666A' strokeWidth='1'
									strokeLinecap='round' strokeLinejoin='round'></path>
                  <path d='M27.32 65.49V70.6' stroke='#D7D7D7'
									strokeWidth='1' strokeLinecap='round' strokeLinejoin='round'></path>
                  <path d='M29.88 68.04H24.76' stroke='#D7D7D7'
									strokeWidth='1' strokeLinecap='round' strokeLinejoin='round'></path>
                  <path d='M110.49 32.5601V39.9901' stroke='#D7D7D7'
									strokeWidth='1' strokeLinecap='round' strokeLinejoin='round'></path>
                  <path d='M114.2 36.27H106.77' stroke='#D7D7D7'
									strokeWidth='1' strokeLinecap='round' strokeLinejoin='round'></path>
                  <path d='M34.07 14.58V25.59' stroke='#D7D7D7'
									strokeWidth='1' strokeLinecap='round' strokeLinejoin='round'></path>
                  <path d='M39.57 20.08H28.57' stroke='#D7D7D7'
									strokeWidth='1.5' strokeLinecap='round' strokeLinejoin='round'></path>
                  <path d='M67 115.86V67.12' stroke='#63666A'
									strokeWidth='1' strokeMiterlimit='10' strokeLinecap='round'></path>
                  <path d='M55.5 78.61L67 67.12L78.5 78.61' fill='white'></path>
                  <path d='M55.5 78.61L67 67.12L78.5 78.61'
									stroke='#63666A' strokeWidth='1' strokeMiterlimit='10'></path>
                </svg>
							<p>Bấm để chọn ảnh cần tải lên</p>
						</label> <input type='file' id='image' name='image' multiple
							onchange="image_select()" class="d-none" style="display: none;" />


						<div class='img-container' id="container">
							<!--		<div class='img-wrapper'>
									<img src="images/FB_IMG_1666110816291.jpg" alt='' /> 
									<i class='fa-solid fa-xmark' onclick="delete_image(`+images.indexOf(i)+`)"></i>
								</div> -->
						</div>

					</div>

				</div>

				<div class='input-wrapper'>
					<h3>Thông tin liên hệ</h3>
					<div class='contact-wrapper'>
						<div class='form-item'>
							<p>
								Tên liên hệ <span>*</span>
							</p>
							<div class='input-container'>
								<form:input path="contactName" placeholder="Nhập tên" />
							</div>
						</div>

						<div class='form-item'>
							<p>
								Số điện thoại <span>*</span>
							</p>
							<div class='input-container'>
								<form:input path="phoneNumber" placeholder="Nhập số điện thoại" />
							</div>
						</div>
					</div>

					<div class='form-item'>
						<p>Email</p>
						<div class='input-container'>
							<form:input path="email" placeholder="Nhập email" />
						</div>
					</div>
				</div>

				<div class='input-wrapper'>
					<h3>Cấu hình tin đăng</h3>

					<div class="setting-wrapper">
						<p>Chọn loại tin đăng</p>
						<div class="types-wrapper">
							<div class="type-container normal active">
								<h6>Tin thường</h6>
								<p>
									Từ <span>2.240</span> đ/ngày
								</p>
								<div>
									<i class="fa-regular fa-eye"></i> <span> x1</span>
								</div>
								<p>
									<span>lượt xem tin</span>
								</p>
								<div class="choose-btn">Đã chọn</div>
							</div>

							<div class="type-container silver">
								<h6>VIP Bạc</h6>
								<p>
									Từ <span>49.140</span> đ/ngày
								</p>
								<div>
									<i class="fa-regular fa-eye"></i> <span> x11</span>
								</div>
								<p>
									<span>lượt xem tin</span>
								</p>
								<div class="choose-btn">Chọn</div>
							</div>

							<div class="type-container gold">
								<h6>VIP Vàng</h6>
								<p>
									Từ <span>106.380</span> đ/ngày
								</p>
								<div>
									<i class="fa-regular fa-eye"></i> <span> x18</span>
								</div>
								<p>
									<span>lượt xem tin</span>
								</p>
								<div class="choose-btn">Chọn</div>
							</div>

							<div class="type-container diamond">
								<h6>VIP Kim Cương</h6>
								<p>
									Từ <span>270.000</span> đ/ngày
								</p>
								<div>
									<i class="fa-regular fa-eye"></i> <span> x90</span>
								</div>
								<p>
									<span>lượt xem tin</span>
								</p>
								<div class="choose-btn">Chọn</div>
							</div>
						</div>
					</div>
					
					<hr />

					<div class="setting-wrapper">
						<p>Chọn thời gian đăng tin</p>
						
						<div class='form-item'>
							<p>Số ngày đăng</p>
							<div class="dates-wrapper">
								<div class="date-container active">
									<h6>10 ngày</h6>
									<p>2800 đ/ngày</p>
								</div>
								<div class="date-container">
									<h6>15 ngày</h6>
									<p>2520 đ/ngày</p>
								</div>
								<div class="date-container">
									<h6>30 ngày</h6>
									<p>2240 đ/ngày</p>
								</div>
							</div>
						</div>
						
						<div class='contact-wrapper'>
							<div class='form-item'>
								<p>Ngày bắt đầu</p>
								<div class='input-container'>
									<input type="date" id="submittedDate" />
								</div>
							</div>

							<div class='form-item'>
								<p>Ngày kết thúc</p>
								<div class='input-container'>
									<input type="date" id="expirationDate" readonly />
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<div class='input-wrapper'>
					<h3>THANH TOÁN</h3>

					<div class="section-wrapper">
						<span>Loại tin</span>
						<input name="typePost" value="Tin thường" readonly />
					</div>
					<div class="section-wrapper">
						<span>Đơn giá / ngày</span>
						<div>	
							<input name="pricePerDay" value="2800" readonly /> đ
						</div>	
					</div>
					<div class="section-wrapper">
						<span>Thời gian đăng tin</span>
						<input name="amountDate" value="10 ngày" readonly />
					</div>
					<div class="section-wrapper">
						<span>Ngày bắt đầu</span>
						<input name="submittedDate" type="date" readonly style="transform: translateX(20px);" />
					</div>
					<div class="section-wrapper">
						<span>Ngày kết thúc</span>
						<input name="expirationDate" type="date" readonly style="transform: translateX(20px);" />
					</div>
					<hr />
					<div class="section-wrapper">
						<span>Phí đăng tin</span>
						<div>						
							<input name="fee"  value="28000" readonly /> đ
						</div>
					</div>
					<hr />
					<div class="section-wrapper">
						<span>Tổng tiền</span>
						<div>
							<input name="totalMoney" value="28000" readonly /> đ
						</div>
					</div>
				</div>

				<div class='button-wrapper'>
					<div></div>
					<button class='continue-button'>
						<span>Tiếp tục</span> <i class='fa-solid fa-angle-right'></i>
					</button>
				</div>
			</form:form>
		</div>
	</div>

	<script type="text/javascript">
	var images = [];
	function image_select() {
		var image = document.getElementById("image").files;
		 for (var i = 0; i < image.length; i++) {
			 if(check_duplicate(image[i].name)) {
				images.push({
					"name": image[i].name,
					"url": URL.createObjectURL(image[i]),
					"file": image[i],
				})
		 	}
		}
		document.getElementById("container").innerHTML = image_show();
	}
	function image_show() {
		var image = "";
		images.forEach((i) => {
			image += `
				<div class='img-wrapper'>
					<img src="`+i.url+`" alt='' /> 
					<i class='fa-solid fa-xmark' onclick="delete_image(`+images.indexOf(i)+`)"></i>
				</div>
			`
		})
		return image;
	}
	function delete_image(e) {
		images.splice(e, 1);
		document.getElementById("container").innerHTML = image_show();
	}
	function check_duplicate(name) {
		var image = true;
		if(images.length > 0) {
			for(e = 0; e < images.length; e++) {
				if(images[e].name == name) {
					image = false;
					break;
				}
			}
		}
		return image
	}
	//
	$(document).ready(function() {
		ClassicEditor
        .create( document.querySelector( '#editor' ) )
        .catch( error => {
            console.error( error );
        } );
		
		var currentDate = new Date();

		var submittedDate = currentDate.toISOString().split('T')[0];
		$('#submittedDate').val(submittedDate);
		$('input[name="submittedDate"]').val(submittedDate);

		// Tạo một đối tượng Date mới từ ngày hiện tại cộng thêm 10 ngày
		var next10day = new Date(currentDate);
		next10day.setDate(next10day.getDate() + 10);

		// Định dạng thành chuỗi YYYY-MM-DD
		var expirationDate = next10day.toISOString().split('T')[0];
		$('#expirationDate').val(expirationDate);
		$('input[name="expirationDate"]').val(expirationDate);
		
		

		
		$(".type-container").on("click", function() {
		    $(".type-container").removeClass("active");
		    $(".type-container .choose-btn").text("Chọn"); 
		    
		    $(this).addClass("active");
		    $(this).find(".choose-btn").text("Đã chọn"); 
		    
		    var getDate = $('#submittedDate').val()
			
			var next7day = new Date(getDate);
			next7day.setDate(next7day.getDate() + 7);
			
			var next10day = new Date(getDate);
			next10day.setDate(next10day.getDate() + 10);
			
			var next15day = new Date(getDate);
			next15day.setDate(next15day.getDate() + 15);
			
			var next30day = new Date(getDate);
			next30day.setDate(next30day.getDate() + 30);

	    	if ($(this).hasClass("normal")) {
		    	$(".dates-wrapper").html(
					`
					<div class="date-container active">
						<h6>10 ngày</h6>
						<p>2800 đ/ngày</p>
					</div>
					<div class="date-container">
						<h6>15 ngày</h6>
						<p>2520 đ/ngày</p>
					</div>
					<div class="date-container">
						<h6>30 ngày</h6>
						<p>2240 đ/ngày</p>
					</div>
					`
		    	)
		    	
		    	var expirationDate = next10day.toISOString().split('T')[0];
				$('#expirationDate').val(expirationDate);
				$('input[name="expirationDate"]').val(expirationDate);
		    }
	    	if ($(this).hasClass("silver")) {
	    		$(".dates-wrapper").html(
						`
						<div class="date-container active">
							<h6>7 ngày</h6>
							<p>54600 đ/ngày</p>
						</div>
						<div class="date-container">
							<h6>10 ngày</h6>
							<p>51870 đ/ngày</p>
						</div>
						<div class="date-container">
							<h6>15 ngày</h6>
							<p>49140 đ/ngày</p>
						</div>
						`
			    	)
			    	
			    var expirationDate = next7day.toISOString().split('T')[0];
				$('#expirationDate').val(expirationDate);
				$('input[name="expirationDate"]').val(expirationDate);
		    }
	    	if ($(this).hasClass("gold")) {
	    		$(".dates-wrapper").html(
						`
						<div class="date-container active">
							<h6>7 ngày</h6>
							<p>118200 đ/ngày</p>
						</div>
						<div class="date-container">
							<h6>10 ngày</h6>
							<p>122290 đ/ngày</p>
						</div>
						<div class="date-container">
							<h6>15 ngày</h6>
							<p>106380 đ/ngày</p>
						</div>
						`
			    	)
			    	
				    var expirationDate = next7day.toISOString().split('T')[0];
					$('#expirationDate').val(expirationDate);
					$('input[name="expirationDate"]').val(expirationDate);
		    }
	    	if ($(this).hasClass("diamond")) {
	    		$(".dates-wrapper").html(
						`
						<div class="date-container active">
							<h6>7 ngày</h6>
							<p>300000 đ/ngày</p>
						</div>
						<div class="date-container">
							<h6>10 ngày</h6>
							<p>285000 đ/ngày</p>
						</div>
						<div class="date-container">
							<h6>15 ngày</h6>
							<p>270000 đ/ngày</p>
						</div>
						`
			    	)
			    	
				    var expirationDate = next7day.toISOString().split('T')[0];
					$('#expirationDate').val(expirationDate);
					$('input[name="expirationDate"]').val(expirationDate);
		    }
		});
		
		$(".dates-wrapper").on("click", ".date-container", function() {
		    // Remove 'active' class from all date containers
		    $(".date-container").removeClass("active");

		    // Add 'active' class to the clicked date container
		    $(this).addClass("active");

		 // Get the selected date text
		    var selectedDate = $(this).find("h6").text();
		    var selectedMoney = $(".date-container.active").find("p").text();

		    var date = parseInt(selectedDate.replace(/[^\d.]/g, ''));
		    var moneyPerDay = parseInt(selectedMoney.replace(/[^\d.]/g, ''));

		    $("input[name='amountDate']").val(selectedDate); // Use .val() to set input value
		    $("input[name='pricePerDay']").val(moneyPerDay); // Use .val() to set input value
		    $("input[name='fee']").val(date * moneyPerDay); // Use .val() to set input value
		    $("input[name='totalMoney']").val(date * moneyPerDay); // Use .val() to set input value


		    // Calculate expiration date based on selected date
		    var getDate = $('#submittedDate').val();
		    var expirationDate;
		    var next7day = new Date(getDate);
		    next7day.setDate(next7day.getDate() + 7);
		    var next10day = new Date(getDate);
		    next10day.setDate(next10day.getDate() + 10);
		    var next15day = new Date(getDate);
		    next15day.setDate(next15day.getDate() + 15);
		    var next30day = new Date(getDate);
		    next30day.setDate(next30day.getDate() + 30);

		    switch(selectedDate) {
		        case "7 ngày":
		            expirationDate = next7day.toISOString().split('T')[0];
		            break;
		        case "10 ngày":
		            expirationDate = next10day.toISOString().split('T')[0];
		            break;
		        case "15 ngày":
		            expirationDate = next15day.toISOString().split('T')[0];
		            break;
		        case "30 ngày":
		            expirationDate = next30day.toISOString().split('T')[0];
		            break;
		    }

		    // Set expiration date value
		    $('#expirationDate').val(expirationDate);
		    $('input[name="expirationDate"]').val(expirationDate);
		});

		$('#submittedDate').on("change", () => {
			var selectedDate = $(".date-container.active").find("h6").text();
			
			var getDate = $('#submittedDate').val();
		    var expirationDate;
		    var next7day = new Date(getDate);
		    next7day.setDate(next7day.getDate() + 7);
		    var next10day = new Date(getDate);
		    next10day.setDate(next10day.getDate() + 10);
		    var next15day = new Date(getDate);
		    next15day.setDate(next15day.getDate() + 15);
		    var next30day = new Date(getDate);
		    next30day.setDate(next30day.getDate() + 30);

		    switch(selectedDate) {
		        case "7 ngày":
		            expirationDate = next7day.toISOString().split('T')[0];
		            break;
		        case "10 ngày":
		            expirationDate = next10day.toISOString().split('T')[0];
		            break;
		        case "15 ngày":
		            expirationDate = next15day.toISOString().split('T')[0];
		            break;
		        case "30 ngày":
		            expirationDate = next30day.toISOString().split('T')[0];
		            break;
		    }
			
			$('#expirationDate').val(expirationDate);
			$('input[name="expirationDate"]').val(expirationDate);
			 
			var newDate = new Date(getDate);
			var submittedDate = newDate.toISOString().split('T')[0];
			$('#submittedDate').val(submittedDate);
			$('input[name="submittedDate"]').val(submittedDate);
			
			
		})
		

		
		$('#provinceId').change(function() {
		    var provinceId = $(this).val();
		    $.ajax({
		        type: 'GET',
		        url: '${pageContext.servletContext.contextPath}/sellernet/getDistrictsByProvince.html',
		        data: { provinceId: provinceId },
		        dataType: 'text',
		        success: function(data) {
		            $('#districtId').empty();
		            $('#wardId').empty(); // Empty the wardId select element
		            $('#wardId').append('<option value="">---Phường, xã---</option>'); // Append the default option
		            $("#detail-address").val("");
		            var lines = data.split('\n');
		            $.each(lines, function(index, line) {
		                if (index < lines.length - 1) {
		                    var parts = line.split(':');
		                    $('#districtId').append('<option value="' + parts[0] + '">' + parts[1] + '</option>');
		                }
		            });
		        },
		        error: function(data) {
		            $('#districtId').empty();
		            $('#districtId').append('<option value="">Error occurred while fetching districts</option>');
		        }
		    });
		});

	    
	    $('#districtId').change(function() {
	        var districtId = $(this).val();
	        $.ajax({
	            type: 'GET',
	            url: '${pageContext.servletContext.contextPath}/sellernet/getWardsByDistrict.html',
	            data: { districtId: districtId },
	            dataType: 'text',
	            success: function(data) {
	                $('#wardId').empty();
	                var lines = data.split('\n');
	                $.each(lines, function(index, line) {
	                    if (index < lines.length - 1) {
	                        var parts = line.split(':');
	                        $('#wardId').append('<option value="' + parts[0] + '">' + parts[1] + '</option>');
	                    }
	                });
	            },
	            error: function(data) {
	                $('#wardId').empty();
	                $('#wardId').append('<option value="">Error occurred while fetching districts</option>');
	            }
	        });
	    });
	    
        $('#wardId').change(function() {
        	$("#detail-address").val("");
            var province = $("#provinceId").children("option:selected").text();
            var district = $("#districtId").children("option:selected").text();
            var ward = $(this).children("option:selected").text();

            if(district !== "---Quận, huyện---" && ward !== "---Phường, xã---") {
            	// Construct the address
	            var address = ward.trim() + ", " + district.trim() + ", " + province.trim();           
	            
	            // Update the detail-address element
	            $("#detail-address").val($("#detail-address").val() + address);
            }
        });

	});


	</script>
</body>
</html>