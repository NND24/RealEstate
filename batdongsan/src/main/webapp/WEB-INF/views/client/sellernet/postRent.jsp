<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Website số 1 về bất động sản</title>
<link rel="stylesheet" href="../css/client/index.css" type="text/css">
<link rel="stylesheet" href="../css/client/header.css" type="text/css">
<link rel="stylesheet" href="../css/client/sellernet.css" type="text/css">
<link rel="stylesheet" href="../css/client/post.css" type="text/css">
<%@ include file="../../../../links/links.jsp"%>
<base href="${pageContext.servletContext.contextPath}/">
</head>
<body>
	<%@ include file="../../../components/header.jsp"%>
	<div class='sellernet'>
		<%@ include file="../../../components/sellernetSidebar.jsp"%>

		<!-- Post -->
		<div class='post'>
			<form:form action="sellernet/insert.html" modelAttribute="realEstate" method="POST" enctype="multipart/form-data">


				<div class='input-wrapper'>

					<h3>Thông tin cơ bản</h3>

					<ul class='nav nav-tabs'>
						<li>
							<a href='${pageContext.servletContext.contextPath}/sellernet/dang-tin/ban.html'>
								Bán 
							</a>
						</li>
						<li class='active'>
							<a href='${pageContext.servletContext.contextPath}/sellernet/dang-tin/chothue.html'> Cho thuê </a>
						</li>
					</ul>

					<div class='tab-content'>
						<div id='menu1' class='tab-pane fade in active'>
							<div class='form-item'>
								<p>
									Loại bất động sản <span>*</span>
								</p>
								<form:select path='type' items='${categoriesRent}' itemLabel='name' itemValue='categoryId' />
							</div>
						</div>
					</div>

					<div class='address-container'>
						<div class='form-item'>
							<p>
								Tỉnh, thành phố <span>*</span>
							</p>
							<form:select path='provinceId' id="provinceId" items='${provinces}' itemLabel='name' itemValue='provinceId' />
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
								placeholder='Bạn có thể bổ sung hẻm, nghách, ngõ...' id="detail-address" />
						</div>
					</div>
				</div>

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
							<select path='unit'>
								<option value=''>VND</option>
								<option value=''>Giá / m²</option>
								<option value=''>Thỏa thuận</option>
							</select>
						</div>
					</div>

					<div class='form-item'>
						<p>Nội thất</p>
						<select path='interior'>
							<option value=''>---Nội thất---</option>
							<option value='Đầy đủ'>Đầy đủ</option>
							<option value='Cơ bản'>Cơ bản</option>
							<option value='Không nột thất'>Không nột thất</option>
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
						<label htmlFor='file-input' onclick="document.getElementById('image').click()"> 
						<svg width='80' height='80'
								viewBox='0 0 130 130' fill='none'
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
						</label> 
						<input type='file' id='image' name='image' multiple onchange="image_select()" class="d-none" style="display: none;" />
						
						  
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
	
	$(document).ready(function() {
		ClassicEditor
        .create( document.querySelector( '#editor' ) )
        .catch( error => {
            console.error( error );
        } );
			
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