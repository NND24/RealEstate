<%@page import="java.util.List"%>
<%@page import="batdongsan.models.FavouriteModel"%>
<%@page import="java.util.Collection"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="batdongsan.models.HCMRealEstateModel"%>
<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Website số 1 về bất động sản</title>
<link rel="stylesheet" href="css/client/index.css" type="text/css">
<link rel="stylesheet" href="css/client/header.css?version=53"" type="text/css">
<link rel="stylesheet" href="css/client/detail.css?version=52" type="text/css">
<link rel="stylesheet" href="css/client/footer.css?version=51" type="text/css">
<%@ include file="../../../links/links.jsp"%>
</head>
<body>
	<%@ include file="../../components/header.jsp"%>
	<div class="detail">
		<div class='container '>
			<%
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
			HCMRealEstateModel realEstate = (HCMRealEstateModel) request.getAttribute("realEstate");
			if (realEstate != null) {
				String imageString = (String) realEstate.getImages();
				if (imageString != null && !imageString.isEmpty()) {
					imageString = imageString.substring(1, imageString.length() - 1);
					String[] imagePaths = imageString.split(",");
					
					 String submittedDate = sdf.format(realEstate.getSubmittedDate());
					 String expirationDate = sdf.format(realEstate.getExpirationDate());
			%>
			<div class='row'>

				<!-- Content -->
				<div class='detail-content col-lg-9'>

					<div class='swiper mySwiper2'>
						<div class='swiper-wrapper'>
							<%
							for (String imagePath : imagePaths) {
							%>
							<div class='swiper-slide'>
								<img src='images/<%=imagePath.trim()%>' />
							</div>
							<%
							}
							%>
						</div>
						<div class='swiper-button-next'></div>
						<div class='swiper-button-prev'></div>
						<div class='swiper-pagination'></div>
					</div>
					<div thumbsSlider='' class='swiper mySwiper'>
						<div class='swiper-wrapper'>
							<%
							for (String imagePath : imagePaths) {
							%>
							<div class='swiper-slide'>
								<img src='images/<%=imagePath.trim()%>' />
							</div>
							<%
							}
							%>
						</div>
					</div>

					<div class='breadcrumb'>
						<a href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html'><%if ("sell".equals(request.getAttribute("page"))) {%> Bán <%} else {%> Cho thuê <%}%></a> 
						<span> / </span> <a><%=realEstate.getTitle()%></a>
					</div>
					<h3 class='detail-content__title'><%=realEstate.getTitle()%></h3>
					<p class='detail-content__address'><%=realEstate.getAddress()%></p>
					<div class='short-info-container'>
						<div>
							<div class='short-info__item'>
								<span class='title'>Mức giá</span> 
								<span class='value'>
								<%
								if(!realEstate.getUnit().equals("Thỏa thuận")) {
									if(realEstate.getPrice() < 1000000000) {
									    out.print((int)(realEstate.getPrice() / 1000000) + " triệu");
									} else {
									    out.print(realEstate.getPrice() / 1000000000 + " tỷ");
									}
								
									if(realEstate.getUnit().equals("triệu")) {
									    out.print("");
									} else {
										out.print(" " + realEstate.getUnit());
									}
								} else {
									out.print(realEstate.getUnit());
								}
								%>
								</span>
							</div>
							<div class='short-info__item'>
								<span class='title'>Diện tích</span> <span class='value'><%=realEstate.getSize()%>
									m²</span>
							</div>
						</div>
						<div>
							<a href='' class='short-info__button'> <i
								class='fa-solid fa-share-nodes'></i>
							</a> <a href='' class='short-info__button'> <i
								class='fa-solid fa-triangle-exclamation'></i>
							</a> 
							<a class='short-info__button card-contact-button__favorite' value="<%=realEstate.getRealEstateId()%>">
								<%
									Collection<FavouriteModel> favourites = realEstate.getFavourite();
									boolean isLogined = false;
									if(user != null) {
									    for (FavouriteModel favourite : favourites) {
									    	if(user.getUserId() == favourite.getUser().getUserId()) {
									    		isLogined = true;
									    		break;
									    	}    
									    }
									}
									%> 
								<i class='fa-regular fa-heart'
										style="display: <%= isLogined ? "none" : "block"%>;"></i>
									<i class="fa-solid fa-heart"
										style="color: #e03c31;display: <%= isLogined ? "block" : "none"%>;"></i>
							</a>
						</div>
					</div>
					<div class='description-container'>
						<div class='section-title'>Thông tin mô tả</div>
						<div class='description-body'>
							<%=realEstate.getDescription()%>
						</div>
					</div>
					<div class='spec-container'>
						<div class='section-title'>Đặc điểm bất động sản</div>
						<div class='row'>
							<div class='spec-content-item col-lg-6'>
								<i class='fa-regular fa-square spec-content-item__icon'></i>
								<div class='spec-content-item__title'>Diện tích</div>
								<div class='spec-content-item__value'><%=realEstate.getSize()%> m²</div>
							</div>
							<div class='spec-content-item col-lg-6'>
								<i class='fa-solid fa-dong-sign spec-content-item__icon'></i>
								<div class='spec-content-item__title'>Mức giá</div>
								<div class='spec-content-item__value'>
								<%
								if(!realEstate.getUnit().equals("Thỏa thuận")) {
									if(realEstate.getPrice() < 1000000000) {
									    out.print((int)(realEstate.getPrice() / 1000000) + " triệu");
									} else {
									    out.print(realEstate.getPrice() / 1000000000 + " tỷ");
									}
								
									if(realEstate.getUnit().equals("triệu")) {
									    out.print("");
									} else {
										out.print(" " + realEstate.getUnit());
									}
								} else {
									out.print(realEstate.getUnit());
								}
								%>
								</div>
							</div>
							<%
							if(realEstate.getToilets() > 0) {
							%>
							<div class='spec-content-item col-lg-6'>
								<i class='fa-solid fa-bath spec-content-item__icon'></i>
								<div class='spec-content-item__title'>Số toilet</div>
								<div class='spec-content-item__value'><%=realEstate.getToilets()%> phòng</div>
							</div>
							<% } %>
							<%
							if(realEstate.getRooms() > 0) {
							%>
							<div class='spec-content-item col-lg-6'>
								<i class='fa-solid fa-couch spec-content-item__icon'></i>
								<div class='spec-content-item__title'>Số phòng ngủ</div>
								<div class='spec-content-item__value'><%=realEstate.getRooms()%> phòng</div>
							</div>
							<% } %>
						</div>
					</div>
			<!-- 	<div class='search-tag-container'>
						<div class='section-title'>Tìm kiếm theo từ khóa</div>
						<div class='search-tag-list'>
							<a href='' class='search-tag-item'> Thuê trọ phường 10 Tân
								Bình </a> <a href='' class='search-tag-item'> Thuê trọ Gò Cẩm
								Đệm Tân Bình </a> <a href='' class='search-tag-item'> Thuê trọ
								Tân Bình Hồ Chí Minh </a> <a href='' class='search-tag-item'>
								Thuê trọ Hồ Chí Minh </a> <a href='' class='search-tag-item'>
								Thuê căn hộ mini Hồ Chí Minh </a>
						</div>
					</div>  -->
					<div class='short-info-container'>
						<div>
							<div class='short-info__item'>
								<span class='title'>Ngày đăng</span> <span class='value'><%=submittedDate%></span>
							</div>
							<div class='short-info__item'>
								<span class='title'>Ngày hết hạn</span> <span class='value'><%=expirationDate%></span>
							</div>
							<div class='short-info__item'>
								<span class='title'>Loại tin</span> <span class='value'><%= realEstate.getTypePost() %></span>
							</div>
							<div class='short-info__item'>
								<span class='title'>Mã tin</span> <span class='value'><%=realEstate.getRealEstateId()%></span>
							</div>
						</div>
					</div>
					<div class='recommend-list-container'>
						<div class='swiper mySwiper3'>
						    <div class='recommend-list-header'>
						        <h5 class='recommend-title'>Bất động sản dành cho bạn</h5>
						    </div>
						    <div class='swiper-wrapper'>
						        <%
						        List<HCMRealEstateModel> realEstates = (List<HCMRealEstateModel>) request.getAttribute("realEstates");
						
						        if (realEstates != null) {
						            for (HCMRealEstateModel r : realEstates) {
						                String imageStr = (String) r.getImages();
						
						                if (imageStr != null && !imageStr.isEmpty()) {
						                    imageStr = imageStr.substring(1, imageStr.length() - 1);
						                    String[] imgPaths = imageStr.split(",");
						        %>
						        <div class='swiper-slide'>
						            <div class='recommend-card'>
						                <div class='card-image'>
						                    <a href="http://localhost:8080/batdongsan/chi-tiet.html?realEstateId=<%=r.getRealEstateId()%>">
						                        <img src="images/<%=imgPaths[0].trim()%>" alt='' />
						                    </a>
						                    <div class='card-image-feature'>
						                        <i class='fa-regular fa-image'></i> <span><%= imgPaths.length %></span>
						                    </div>
						                </div>
						                <div class='card-info-container'>
						                    <a href="http://localhost:8080/batdongsan/chi-tiet.html?realEstateId=<%=r.getRealEstateId()%>">
						                        <div class='card-info__title'><%=r.getTitle()%></div>
						                    </a>
						                    <div class='card-info__config'>
						                        <span class='card-config__item card-config__price'>
						                        <%
						                        if (!r.getUnit().equals("Thỏa thuận")) {
						                            if (r.getPrice() < 1000000000) {
						                                out.print((int) (r.getPrice() / 1000000) + " triệu");
						                            } else {
						                                out.print(r.getPrice() / 1000000000 + " tỷ");
						                            }
						
						                            if (!r.getUnit().equals("triệu")) {
						                                out.print(" " + r.getUnit());
						                            }
						                        } else {
						                            out.print(r.getUnit());
						                        }
						                        %>
						                        </span>
						                        <span class='card-config__item card-config__dot'>·</span>
						                        <span class='card-config__item card-config__area'><%= r.getSize()%> m²</span>
						                    </div>
						                    <div class='card-info__location'>
						                        <i class='fa-solid fa-location-dot'></i> <span><%=r.getDistrict().getName()%>, Thành phố Hồ Chí Minh</span>
						                    </div>
						                    <div class='card-info__contact'>
						                        <div class='card-published-info' value="<%=r.getSubmittedDate()%>"></div>
						                        <div class='card-contact-button__favorite' value="<%=r.getRealEstateId()%>">
						                            <%
																			Collection<FavouriteModel> favourites2 = r.getFavourite();
																			boolean isLogined2 = false;
																			if(user != null) {
																			    for (FavouriteModel favourite : favourites2) {
																			    	if(user.getUserId() == favourite.getUser().getUserId()) {
																			    		isLogined = true;
																			    		break;
																			    	}    
																			    }
																			}
																			%> 
						                            <i class='fa-regular fa-heart' style="display: <%= isLogined2 ? "none" : "block"%>;"></i>
						                            <i class="fa-solid fa-heart" style="color: #e03c31; display: <%= isLogined2 ? "block" : "none"%>;"></i>
						                        </div>
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
						    <div class='swiper-button-next'></div>
						    <div class='swiper-button-prev'></div>
						</div>
					</div>
				</div>

				<!-- Sidebar -->
				<div class='detail-sidebar col-lg-3'>
					<div class='sidebar-box-contact'>
						<a href='${pageContext.servletContext.contextPath}/profile.html?userId=<%=realEstate.getUser().getUserId() %>'>
							<img class='contact-avatar' src="images/<%=realEstate.getUser().getAvatar() %>" alt='' />
						</a>
						<p>Được đăng bởi</p>
						<a href='${pageContext.servletContext.contextPath}/profile.html?userId=<%=realEstate.getUser().getUserId() %>'>
							<h5 class='contact-name'><%=realEstate.getContactName()%></h5>
						</a>
						<div class='contact-button contact-button__phonenumber'>
								<span class="phonenumber" value="<%=realEstate.getPhoneNumber()%>"><%=realEstate.getPhoneNumber()%></span> 
								<span class='contact-button__phonenumber__dot'>·</span> 
								<span class="show-phonenumber">Hiện số</span>
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

					<div class='sidebar-box'>
						<h5 class='sidebar-box__title'>Lọc theo giá</h5>
						<ul class='sidebar-box__content'>
							<li class='sidebar-box__item'><a href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html?unit=thoa-thuan'>Thỏa thuận</a></li>
							<li class='sidebar-box__item'><a href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html?minPrice=0&maxPrice=500000000'>Dưới 500 triệu</a></li>
							<li class='sidebar-box__item'><a href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html?minPrice=500000000&maxPrice=800000000'>500 - 800 triệu</a></li>
							<li class='sidebar-box__item'><a href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html?minPrice=800000000&maxPrice=1000000000'>800 triệu - 1 tỷ</a></li>
							<li class='sidebar-box__item'><a href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html?minPrice=1000000000&maxPrice=2000000000'>1 - 2 tỷ</a></li>
							<li class='sidebar-box__item'><a href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html?minPrice=2000000000&maxPrice=3000000000'>2 - 3 tỷ</a></li>
							<li class='sidebar-box__item'><a href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html?minPrice=3000000000&maxPrice=5000000000'>3 - 5 tỷ</a></li>
							<li class='sidebar-box__item'><a href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html?minPrice=5000000000&maxPrice=7000000000l'>5 - 7 tỷ</a></li>
							<li class='sidebar-box__item'><a href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html?minPrice=7000000000&maxPrice=10000000000'>7 - 10 tỷ</a></li>
							<li class='sidebar-box__item'><a href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html?minPrice=10000000000&maxPrice=20000000000'>10 - 20 tỷ</a></li>
							<li class='sidebar-box__item'><a href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html?minPrice=20000000000&maxPrice=30000000000'>20 - 30 tỷ</a></li>
							<li class='sidebar-box__item'><a href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html?minPrice=30000000000&maxPrice=40000000000'>30 - 40 tỷ</a></li>
							<li class='sidebar-box__item'><a href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html?minPrice=40000000000&maxPrice=60000000000'>40 - 60 tỷ</a></li>
							<li class='sidebar-box__item'><a href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html?minPrice=60000000000&maxPrice=600000000000'>Trên 60 tỷ</a></li>
						</ul>
					</div>
					
					<div class='sidebar-box'>
						<h5 class='sidebar-box__title'>Lọc theo diện tích</h5>
						<ul class='sidebar-box__content'>
							<li class='sidebar-box__item'><a href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html?minArea=0&maxArea=30'>Dưới 30 m²</a></li>
							<li class='sidebar-box__item'><a href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html?minArea=30&maxArea=50'>30 - 50 m²</a></li>
							<li class='sidebar-box__item'><a href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html?minArea=50&maxArea=80'>50 - 80 m²</a></li>
							<li class='sidebar-box__item'><a href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html?minArea=80&maxArea=100'>80 - 100 m²</a></li>
							<li class='sidebar-box__item'><a href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html?minArea=100&maxArea=150'>100 - 150 m²</a></li>
							<li class='sidebar-box__item'><a href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html?minArea=150&maxArea=200'>150 - 200 m²</a></li>
							<li class='sidebar-box__item'><a href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html?minArea=200&maxArea=250'>200 - 250 m²</a></li>
							<li class='sidebar-box__item'><a href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html?minArea=250&maxArea=300'>250 - 300 m²</a></li>
							<li class='sidebar-box__item'><a href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html?minArea=300&maxArea=500'>300 - 500 m²</a></li>
							<li class='sidebar-box__item'><a href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html?minArea=5000&maxArea=10000'>Trên 500 m²</a></li>
						</ul>
					</div>
				</div>
			</div>
			<%
			}
			}
			%>
		</div>
	</div>
	<%@ include file="../../components/footer.jsp"%>

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
		    slidesPerView: 3,
		    spaceBetween: 15,
		    navigation: {
		        nextEl: ".swiper-button-next",
		        prevEl: ".swiper-button-prev",
		    },
		});
		
		$(document).ready(function() {
			// HANDLE ADD TO FAVOURITE
		    $(".card-contact-button__favorite").on("click", function(e) {
		    	e.preventDefault();
		    	
		    	<% if (user == null) { %>
                swal({
                	title: "Vui lòng đăng nhập để tiếp tục!",
                    icon: "error",
                    button: "OK"
                });
                <% } else { %>
		        var regularHeartIcon = $(this).find(".fa-regular.fa-heart");
		        var solidHeartIcon = $(this).find(".fa-solid.fa-heart");
		        if (regularHeartIcon.css("display") === "block") {
		        	regularHeartIcon.css("display", "none");
		        	solidHeartIcon.css("display", "block");
		        } else {
		        	regularHeartIcon.css("display", "block");
		        	solidHeartIcon.css("display", "none");
		        }
		        
		        var realEstateId = $(this).attr("value");
		        $.ajax({
					type: 'GET',
					url: '${pageContext.servletContext.contextPath}/addToFavourite.html',
					data: {realEstateId: realEstateId},
					dataType: 'text',
					success: function(data) {
						console.log("Thêm thành công");
					},
					error: function(xhr, status, error) {
						console.log("Thêm thất bại")
					}
				});
				<% } %>
		    });
			
			$(".contact-button__phonenumber").on("click", function(e) {
			    e.preventDefault();
			    
			    <% if (user == null) { %>
                swal({
                	title: "Vui lòng đăng nhập để tiếp tục!",
                    icon: "error",
                    button: "OK"
                });
                <% } else { %>
			    var phonenumber = $(this).find(".phonenumber").attr("value").trim();
			
			    var textarea = $("<textarea>")
			        .val(phonenumber)
			        .css({position: "fixed", opacity: 0});
			
			    $(document.body).append(textarea);
			
			    textarea[0].select();
			    document.execCommand("copy");
			
			    textarea.remove();
			
			    $(this).find(".phonenumber").text(phonenumber);
			    $(this).find(".show-phonenumber").text("Sao chép");
			    <% } %>
			});


		    
		    function hidePhoneNumber(phoneNumber) {
			    // Kiểm tra xem chuỗi có đúng 10 ký tự số không
			    if (phoneNumber.length === 10 && /^\d+$/.test(phoneNumber)) {
			        // Lấy 7 số đầu của chuỗi
			        var firstPart = phoneNumber.slice(0, 7);
			        // Tạo chuỗi kết quả bằng cách nối 7 số đầu và thêm 3 dấu *
			        var maskedPhoneNumber = firstPart + '***';
			        return maskedPhoneNumber;
			    } else {
			        // Trả về null nếu chuỗi không hợp lệ
			        return null;
			    }
			}
		    
		    $(".contact-button__phonenumber").each(function() {
		        var phonenumber = $(this).find(".phonenumber").text().trim();
		        var maskedPhoneNumber = hidePhoneNumber(phonenumber);
		        $(this).find(".phonenumber").text(maskedPhoneNumber);
		    });
		    
		    $(".card-published-info").each(function() {
		        var submittedTime = $(this).attr("value").trim();
		        var timeAgo = moment(submittedTime).locale('vi').fromNow(); 
		        $(this).text(timeAgo); 
		    });
		})
	</script>
</body>
</html>