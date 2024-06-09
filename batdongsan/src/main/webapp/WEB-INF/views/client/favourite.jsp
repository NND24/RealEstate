<%@page import="batdongsan.models.RealEstateModel"%>
<%@page import="java.util.List"%>
<%@ page pageEncoding="utf-8"%>
<%@ page import="javax.servlet.http.HttpServletRequest"%>
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
					<h3 class='sell-content__title'>Tin đăng đã lưu</h3>
					<div class='sell-content__navbar'>
						<span class='total-count'>Tổng số ${amountRealEstate }
							tin đăng</span>
						<div class='navbar-filter dropdown'>
							<div class=' dropdown-toggle' data-toggle='dropdown'>
								<span id="filter-title">Lưu mới nhất</span> <i
									class='fa-solid fa-chevron-down'></i>
							</div>
							<ul class='dropdown-menu list-filter'>

							</ul>
						</div>
					</div>

					<!-- CARD -->
					<%
					List<RealEstateModel> realEstates = (List<RealEstateModel>) request.getAttribute("realEstates");

					if (realEstates != null) {
						for (RealEstateModel r : realEstates) {
							String imageString = (String) r.getImages();

							if (imageString != null && !imageString.isEmpty()) {
						imageString = imageString.substring(1, imageString.length() - 1);
						String[] imagePaths = imageString.split(",");
					%>
					<a
						href="${pageContext.servletContext.contextPath}/chi-tiet.html?realEstateId=<%= r.getRealEstateId() %>"
						class='product-card'>
						<div class='card-img-container'>
							<%
							int i = 0;
							for (String imagePath : imagePaths) {
								i++;
							%>
							<img src='images/<%=imagePath.trim()%>' class='image-<%=i%>' />
							<%
							if (i == 4) {
								break;
							}
							}
							%>

							<div class='card-image-feature'>
								<i class='fa-regular fa-image'></i> <span><%=imagePaths.length%></span>
							</div>
						</div>

						<div class='card-info-container'>
							<div class='card-info-content'>
								<h3 class='card-info__title'><%=r.getTitle()%></h3>
								<div class='card-info__detail'>
									<div class='card-config'>
										<span class='card-config__item card-config__price'> <%
										 if (!r.getUnit().equals("Thỏa thuận")) {
										 	if (r.getPrice() < 1000000000) {
										 		out.print((int) (r.getPrice() / 1000000) + " triệu");
										 	} else {
										 		out.print(r.getPrice() / 1000000000 + " tỷ");
										 	}
										
										 	if (r.getUnit().equals("triệu")) {
										 		out.print("");
										 	} else {
										 		out.print(" "+r.getUnit());
										 	}
										 } else {
										 	out.print(r.getUnit());
										 }
										 %>
										</span> <span class='card-config__item card-config__dot'>·</span> <span
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
									<span class='card-location'><%=r.getWard().getName()%>,
										<%=r.getDistrict().getName()%>, <%=r.getProvince().getName()%></span>
								</div>
								<div class='card-description'></div>
							</div>
						</div>
						<div class='card-contact-container'>
							<div class='card-published-info'>
								<img src="images/<%=r.getUser().getAvatar()%>" alt=''
									class='card-published-info__avatar' />
								<div>
									<div class='card-published-info__name'><%=r.getContactName()%></div>
									<div class='card-published-info__update-time'
										value="<%=r.getSubmittedDate()%>"></div>
								</div>
							</div>
							<div class='card-contact-button-container'>
								<div class='card-contact-button__phonenumber'>
									<i class='fa-solid fa-phone-volume'></i> <span
										class="phonenumber" value="<%=r.getPhoneNumber()%>"><%=r.getPhoneNumber()%></span>
									<span class='card-contact-button__phonenumber__dot'>·</span> <span
										class="show-phonenumber">Hiện số</span>
								</div>
								<div class='card-contact-button__favorite'
									value="<%=r.getRealEstateId()%>">
									<i class='fa-regular fa-heart'
										style="display: <%=r.getFavourite().size() > 0 ? "none" : "block"%>;"></i>
									<i class="fa-solid fa-heart"
										style="color: #e03c31;display: <%=r.getFavourite().size() > 0 ? "block" : "none"%>;"></i>
								</div>
							</div>
						</div>
						<div class='card-label-img'></div>
					</a>
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
							<li class='sidebar-box__item'><a
								href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html?unit=thoa-thuan'>Thỏa
									thuận</a></li>
							<li class='sidebar-box__item'><a
								href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html?minPrice=0&maxPrice=500000000'>Dưới
									500 triệu</a></li>
							<li class='sidebar-box__item'><a
								href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html?minPrice=500000000&maxPrice=800000000'>500
									- 800 triệu</a></li>
							<li class='sidebar-box__item'><a
								href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html?minPrice=800000000&maxPrice=1000000000'>800
									triệu - 1 tỷ</a></li>
							<li class='sidebar-box__item'><a
								href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html?minPrice=1000000000&maxPrice=2000000000'>1
									- 2 tỷ</a></li>
							<li class='sidebar-box__item'><a
								href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html?minPrice=2000000000&maxPrice=3000000000'>2
									- 3 tỷ</a></li>
							<li class='sidebar-box__item'><a
								href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html?minPrice=3000000000&maxPrice=5000000000'>3
									- 5 tỷ</a></li>
							<li class='sidebar-box__item'><a
								href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html?minPrice=5000000000&maxPrice=7000000000l'>5
									- 7 tỷ</a></li>
							<li class='sidebar-box__item'><a
								href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html?minPrice=7000000000&maxPrice=10000000000'>7
									- 10 tỷ</a></li>
							<li class='sidebar-box__item'><a
								href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html?minPrice=10000000000&maxPrice=20000000000'>10
									- 20 tỷ</a></li>
							<li class='sidebar-box__item'><a
								href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html?minPrice=20000000000&maxPrice=30000000000'>20
									- 30 tỷ</a></li>
							<li class='sidebar-box__item'><a
								href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html?minPrice=30000000000&maxPrice=40000000000'>30
									- 40 tỷ</a></li>
							<li class='sidebar-box__item'><a
								href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html?minPrice=40000000000&maxPrice=60000000000'>40
									- 60 tỷ</a></li>
							<li class='sidebar-box__item'><a
								href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html?minPrice=60000000000&maxPrice=600000000000'>Trên
									60 tỷ</a></li>
						</ul>
					</div>

					<div class='sidebar-box'>
						<h5 class='sidebar-box__title'>Lọc theo diện tích</h5>
						<ul class='sidebar-box__content'>
							<li class='sidebar-box__item'><a
								href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html?minArea=0&maxArea=30'>Dưới
									30 m²</a></li>
							<li class='sidebar-box__item'><a
								href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html?minArea=30&maxArea=50'>30
									- 50 m²</a></li>
							<li class='sidebar-box__item'><a
								href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html?minArea=50&maxArea=80'>50
									- 80 m²</a></li>
							<li class='sidebar-box__item'><a
								href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html?minArea=80&maxArea=100'>80
									- 100 m²</a></li>
							<li class='sidebar-box__item'><a
								href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html?minArea=100&maxArea=150'>100
									- 150 m²</a></li>
							<li class='sidebar-box__item'><a
								href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html?minArea=150&maxArea=200'>150
									- 200 m²</a></li>
							<li class='sidebar-box__item'><a
								href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html?minArea=200&maxArea=250'>200
									- 250 m²</a></li>
							<li class='sidebar-box__item'><a
								href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html?minArea=250&maxArea=300'>250
									- 300 m²</a></li>
							<li class='sidebar-box__item'><a
								href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html?minArea=300&maxArea=500'>300
									- 500 m²</a></li>
							<li class='sidebar-box__item'><a
								href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html?minArea=5000&maxArea=10000'>Trên
									500 m²</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="../../components/footer.jsp"%>

	<script type="text/javascript">
		$(document).ready(function() {
			<%if (user != null) {%>
			// HANDLE ADD TO FAVOURITE
		    $(".card-contact-button__favorite").on("click", function(e) {
		    	e.preventDefault();
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
		    });
			<%}%>
			
		    window.addEventListener('load', () => {
		    	let currentURL = decodeURIComponent(window.location.href);
				let firstQuestionMarkIndex = currentURL.indexOf("?");
				let url = "${pageContext.servletContext.contextPath}/tin-da-luu.html";
				
		    	if (firstQuestionMarkIndex !== -1) {
				    let queryString = currentURL.substring(firstQuestionMarkIndex + 1);
				    let pairs = queryString.split("&");
				    
				    const result = {};
		
				    pairs.forEach(pair => {
				        const [key, value] = pair.split("=");
				        if (key && value) {
				            result[key] = decodeURIComponent(value);
				        }
				    });		
				    

				    
				    if (result['addedDate'] !== undefined) {
				    	$("#filter-title").text(result['addedDate'])
				    } else if (result['newPost'] !== undefined) {
				    	$("#filter-title").text(result['newPost'])
				    } else if (result['priceLowToHigh'] !== undefined) {
				    	$("#filter-title").text(result['priceLowToHigh'])
				    } else if (result['priceHighToLow'] !== undefined) {
				    	$("#filter-title").text(result['priceHighToLow'])
				    } else if (result['areaLowToHigh'] !== undefined) {
				    	$("#filter-title").text(result['areaLowToHigh'])
				    } else if (result['areaHighToLow'] !== undefined) {
				    	$("#filter-title").text(result['areaHighToLow'])
				    }
				}
		    	
		        var hasQueryString = url.indexOf('?') !== -1;
		        
		        $('.list-filter').append(
		            "<a href='" + url + (hasQueryString ? "&" : "?") + "addedDate=Lưu mới nhất'><li><span>Lưu mới nhất</span></li></a>" +
		            "<a href='" + url + (hasQueryString ? "&" : "?") + "newPost=Tin mới nhất'><li><span>Tin mới nhất</span></li></a>" +
		            "<a href='" + url + (hasQueryString ? "&" : "?") + "priceLowToHigh=Giá thấp đến cao'><li><span>Giá thấp đến cao</span></li></a>" +
		            "<a href='" + url + (hasQueryString ? "&" : "?") + "priceHighToLow=Giá cao đến thấp'><li><span>Giá cao đến thấp</span></li></a>" +
		            "<a href='" + url + (hasQueryString ? "&" : "?") + "areaLowToHigh=Diện tích bé đến lớn'><li><span>Diện tích bé đến lớn</span></li></a>" +
		            "<a href='" + url + (hasQueryString ? "&" : "?") + "areaHighToLow=Diện tích lớn đến bé'><li><span>Diện tích lớn đến bé</span></li></a>"
		        );
		        

		    })
		    
		    $("#refresh-page").on("click", () => {
		    	 location.reload();
		    })
		    
		    $(".card-contact-button__phonenumber").on("click", function(e) {
			    e.preventDefault();
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
		    
		    $(".card-contact-button__phonenumber").each(function() {
		        var phonenumber = $(this).find(".phonenumber").text().trim();
		        var maskedPhoneNumber = hidePhoneNumber(phonenumber);
		        $(this).find(".phonenumber").text(maskedPhoneNumber);
		    });
		    
		    $(".card-published-info__update-time").each(function() {
		        var submittedTime = $(this).attr("value").trim();
		        var timeAgo = moment(submittedTime).locale('vi').fromNow(); 
		        $(this).text(timeAgo); 
		    });
		});
	</script>
</body>
</html>