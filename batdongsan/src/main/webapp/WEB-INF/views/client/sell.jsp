<%@page import="batdongsan.models.FavouriteModel"%>
<%@page import="java.util.Collection"%>
<%@page import="batdongsan.models.RealEstateModel"%>
<%@page import="java.util.List"%>
<%@ page pageEncoding="utf-8"%>
<%@ page import="javax.servlet.http.HttpServletRequest"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Website số 1 về bất động sản</title>
<link rel="stylesheet" href="css/client/index.css" type="text/css">
<link rel="stylesheet" href="css/client/header.css?version=54"
	type="text/css">
<link rel="stylesheet" href="css/client/sell.css?version=53"
	type="text/css">
<link rel="stylesheet" href="css/client/footer.css?version=53"
	type="text/css">
<%@ include file="../../../links/links.jsp"%>
</head>
<body>
	<%
	UsersModel currentUser = (UsersModel) request.getAttribute("user");
	List<RealEstateModel> realEstates = (List<RealEstateModel>) request.getAttribute("realEstates");
	Integer currentPage = (Integer) request.getAttribute("currentPage");
	Integer totalResults = (Integer) request.getAttribute("totalResults");
	Integer totalPages = (Integer) request.getAttribute("totalPages");
	
	if ("sell".equals(request.getAttribute("page"))) {
	%>
	<%@ include file="../../components/headerSellWithFilter.jsp"%>
	<%
	} else {
	%>
	<%@ include file="../../components/headerRentWithFilter.jsp"%>
	<%
	}
	%>
	<div class="sell">
		<div class='container '>
			<div class='row'>
				<div class='sell-content col-lg-9'>
					<div class='breadcrumb'>
						<a
							href='${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html'>
							<%
							if ("sell".equals(request.getAttribute("page"))) {
							%> Bán <%
							} else {
							%> Cho thuê <%
							}
							%>
						</a> <span> / </span> <a id="refresh-page"> <%
						 List<Integer> categoryIdsList1 = (List<Integer>) request.getAttribute("categoryIds");
						 StringBuilder result = new StringBuilder();
						
						 if ("sell".equals(request.getAttribute("page"))) {
						 	if (categoryIdsList1 != null) {
						 		if (categoryIdsList1.containsAll(Arrays.asList(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11))) {
						 	result.append("Tất cả BĐS trên toàn quốc");
						 		} else {
						 	if (categoryIdsList1.contains(1)) {
						 		result.append("Căn hộ chung cư, ");
						 	}
						
						 	if (categoryIdsList1.containsAll(Arrays.asList(2, 3, 4, 5))) {
						 		result.append("Các loại nhà bán, ");
						 	} else {
						 		if (categoryIdsList1.contains(2)) {
						 			result.append("Nhà riêng, ");
						 		}
						 		if (categoryIdsList1.contains(3)) {
						 			result.append("Nhà biệt thự, liền kề, ");
						 		}
						 		if (categoryIdsList1.contains(4)) {
						 			result.append("Nhà mặt phố, ");
						 		}
						 		if (categoryIdsList1.contains(5)) {
						 			result.append("Shophouse, nhà phố thương mại, ");
						 		}
						 	}
						
						 	if (categoryIdsList1.containsAll(Arrays.asList(6, 7))) {
						 		result.append("Các loại đất bán, ");
						 	} else {
						 		if (categoryIdsList1.contains(6)) {
						 			result.append("Đất nền dự án, ");
						 		}
						 		if (categoryIdsList1.contains(7)) {
						 			result.append("Bán đất, ");
						 		}
						 	}
						
						 	if (categoryIdsList1.contains(8)) {
						 		result.append("Trang trại, khu nghỉ dưỡng, ");
						 	}
						 	if (categoryIdsList1.contains(9)) {
						 		result.append("Condotel, ");
						 	}
						 	if (categoryIdsList1.contains(10)) {
						 		result.append("Kho, nhà xưởng, ");
						 	}
						 	if (categoryIdsList1.contains(11)) {
						 		result.append("Bất động sản khác, ");
						 	}
						 	// Remove the trailing comma and space
						 	if (result.length() > 0) {
						 		result.setLength(result.length() - 2);
						 	}
						 		}
						 	} else {
						 		result.append("Tất cả BĐS trên toàn quốc");
						 	}
						 } else {
						 	if (categoryIdsList1 != null) {
						 		if (categoryIdsList1.containsAll(Arrays.asList(12, 13, 14, 15, 16, 17, 18, 19, 20, 21))) {
						 	result.append("Tất cả BĐS trên toàn quốc");
						 		} else {
						 	if (categoryIdsList1.contains(12)) {
						 		result.append("Căn hộ chung cư, ");
						 	}
						 	if (categoryIdsList1.contains(13)) {
						 		result.append("Nhà riêng, ");
						 	}
						 	if (categoryIdsList1.contains(14)) {
						 		result.append("Nhà biệt thự, liền kề, ");
						 	}
						 	if (categoryIdsList1.contains(15)) {
						 		result.append("Nhà mặt phố, ");
						 	}
						 	if (categoryIdsList1.contains(16)) {
						 		result.append("Shophouse, nhà phố thương mại, ");
						 	}
						 	if (categoryIdsList1.contains(17)) {
						 		result.append("Nhà trọ, phòng trọ, ");
						 	}
						 	if (categoryIdsList1.contains(18)) {
						 		result.append("Văn phòng, ");
						 	}
						 	if (categoryIdsList1.contains(19)) {
						 		result.append("Cửa hàng, ki ốt, ");
						 	}
						 	if (categoryIdsList1.contains(20)) {
						 		result.append("Kho, nhà xưởng, đất, ");
						 	}
						 	if (categoryIdsList1.contains(21)) {
						 		result.append("Bất động sản khác, ");
						 	}
						 	// Remove the trailing comma and space
						 	if (result.length() > 0) {
						 		result.setLength(result.length() - 2);
						 	}
						 		}
						 	} else {
						 		result.append("Tất cả BĐS trên toàn quốc");
						 	}
						 }
						
						 out.print(result.toString());
						 %>

						</a>
					</div>
					<h3 class='sell-content__title'>
						Nhà đất
						<%
					if ("sell".equals(request.getAttribute("page"))) {
					%>
						bán
						<%
					} else {
					%>
						cho thuê
						<%
					}
					%>
					</h3>
					<div class='sell-content__navbar'>
						<span class='total-count'>Hiện có ${ totalResults } bất
							động sản.</span>
						<div class='navbar-filter dropdown'>
							<div class=' dropdown-toggle' data-toggle='dropdown'>
								<span id="filter-title">Thông thường</span> <i
									class='fa-solid fa-chevron-down'></i>
							</div>
							<ul class='dropdown-menu list-filter'>

							</ul>
						</div>
					</div>

					<!-- CARD -->
					<%				
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
										<span class='card-config__item card-config__price'> 
										<%
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
										if (r.getNumberOfToilets() > 0) {
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
									<%
									Collection<FavouriteModel> favourites = r.getFavourite();
									boolean isLogined = false;
									if(currentUser != null) {
									    for (FavouriteModel favourite : favourites) {
									    	if(currentUser.getUserId() == favourite.getUser().getUserId()) {
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
								</div>
							</div>
						</div> 
						<%
						 if (r.getTypePost().equals("VIP Kim Cương")) {
						 %> 
						 <img class='card-label-img' src="images/Label_VIPDiamond.svg" />
						<%
						}
						%>
					</a>
					<%
					}
					}
					}
					%>

					<!-- Phân trang -->
					<div class="pagination">
						<%
						if (currentPage > 1) {
						%>
						<a href="?page=<%=currentPage - 1%>">
							<i class="fa-solid fa-chevron-left"></i>
						</a>
						<%
						}
						%>

						<%
						for (int i = 1; i <= totalPages; i++) {
						%>
						<a href="?page=<%=i%>"
							class="<%=i == currentPage ? "active" : ""%>"><%=i%></a>
						<%
						}
						%>

						<%
						if (currentPage < totalPages) {
						%>
						<a href="?page=<%=currentPage + 1%>"> 
							<i class="fa-solid fa-angle-right"></i>
						 </a>
						<%
						}
						%>
					</div>
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
			// HANDLE ADD TO FAVOURITE
		    $(".card-contact-button__favorite").on("click", function(e) {
                e.preventDefault();

                <% if (currentUser == null) { %>
                swal({
                	title: "Vui lòng đăng nhập để tiếp tục!",
                    icon: "error",
                    button: "OK"
                });
                <% } else { %>
                var regularHeartIcon = $(this).find(".fa-regular.fa-heart");
                var solidHeartIcon = $(this).find(".fa-solid.fa-heart");

                if (regularHeartIcon.is(":visible")) {
                    regularHeartIcon.hide();
                    solidHeartIcon.show();
                } else {
                    regularHeartIcon.show();
                    solidHeartIcon.hide();
                }

                var realEstateId = $(this).attr("value");

                $.ajax({
                    type: 'GET',
                    url: '${pageContext.servletContext.contextPath}/addToFavourite.html',
                    data: { realEstateId: realEstateId },
                    dataType: 'text',
                    success: function(data) {
                        console.log("Thêm thành công");
                    },
                    error: function(xhr, status, error) {
                        console.log("Thêm thất bại");
                    }
                });
                <% } %>
            });
			
		    window.addEventListener('load', () => {
		    	let currentURL = decodeURIComponent(window.location.href);
				let firstQuestionMarkIndex = currentURL.indexOf("?");
				let url = "${pageContext.servletContext.contextPath}/<%if ("sell".equals(request.getAttribute("page"))) {%>nha-dat-ban<%} else {%>nha-dat-cho-thue<%}%>.html";
				
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
				    
				    let hasParameters = false; 

				    if (result['listCategoryId'] !== undefined) {
				        url += hasParameters ? "&" : "?";
				        url += "categoryIds=" + result['listCategoryId'];
				        hasParameters = true;
				    }

				    if (result['minPrice'] !== undefined && result['maxPrice'] !== undefined) {
				        url += hasParameters ? "&" : "?";
				        url += "minPrice=" + result['minPrice'] + "&maxPrice=" + result['maxPrice'];
				        hasParameters = true;
				    }

				    if (result['minArea'] !== undefined && result['maxArea'] !== undefined) {
				        url += hasParameters ? "&" : "?";
				        url += "minArea=" + result['minArea'] + "&maxArea=" + result['maxArea'];
				        hasParameters = true;
				    }

				    if (result['numberOfBedrooms'] !== undefined) {
				        url += hasParameters ? "&" : "?";
				        url += "numberOfBedrooms=" + result['numberOfBedrooms'];
				        hasParameters = true;
				    }

				    if (result['numberOfToilets'] !== undefined) {
				        url += hasParameters ? "&" : "?";
				        url += "numberOfToilets=" + result['numberOfToilets'];
				        hasParameters = true;
				    }
				    
				    if(result['provinceId'] !== undefined) {
				        url += hasParameters ? "&" : "?";
				        url += "provinceId=" + result['provinceId'];
				        hasParameters = true;
				    }
				    
				    if(result['districtId'] !== undefined) {
				        url += hasParameters ? "&" : "?";
				        url += "districtId=" + result['districtId'];
				        hasParameters = true;
				    }
				    
				    if(result['wardId'] !== undefined) {
				        url += hasParameters ? "&" : "?";
				        url += "wardId=" + result['wardId'];
				        hasParameters = true;
				    }
				    
				    if(result['searchInput'] !== undefined) {
				        url += hasParameters ? "&" : "?";
				        url += "searchInput=" + result['searchInput'];
				    }
				    
				    if (result['verify'] !== undefined) {
				    	$("#filter-title").text(result['verify'])
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
				    
				    let title = "<%if ("sell".equals(request.getAttribute("page"))) {%>Mua bán<%} else {%>Cho thuê<%}%> các loại nhà đất bán trên toàn quốc, ";

				    if (result['minPrice'] !== undefined && result['maxPrice'] !== undefined) {
				        let price = "";
				        let minPrice = result['minPrice'] / 1000000000;
				        let maxPrice = result['maxPrice'] / 1000000000;

				        if (minPrice === 0 && maxPrice === 60) {
				            price = "≤ 60 tỷ";
				        } else if (minPrice === 0 && maxPrice < 60) {
				            if (maxPrice < 1) {
				                price = "≤ " + (maxPrice * 1000) + " triệu";
				            } else {
				                price = "≤ " + maxPrice + " tỷ";
				            }
				        } else {
				            if (minPrice < 1 && maxPrice < 1) {
				                price = (minPrice * 1000) + " - " + (maxPrice * 1000) + " triệu";
				            } else if (minPrice < 1 && maxPrice >= 1) {
				                price = (minPrice * 1000) + " triệu - " + maxPrice + " tỷ";
				            } else {
				                price = minPrice + " - " + maxPrice + " tỷ";
				            }
				        }

				        title += price + ", ";
				    }

				    if (result['minArea'] !== undefined && result['maxArea'] !== undefined) {
				        let area = "";
				        let minArea = result['minArea'];
				        let maxArea = result['maxArea'];

				        if (minArea === 0 && maxArea <= 500) {
				            area = "≤ " + maxArea + " m²";
				        } else if (minArea > 0 && maxArea <= 500) {
				            area = minArea + " - " + maxArea + " m²";
				        }

				        title += area + ", ";
				    }
				    
				    if (result['numberOfBedrooms'] !== undefined) {
				        let listBedroom = result['numberOfBedrooms'].split(",").map(Number);
				        let numberOfBedroom = listBedroom.join("-");
				        title += numberOfBedroom + " phòng ngủ, ";
				    }

				    if (result['numberOfToilets'] !== undefined) {
				        let listBedroom = result['numberOfToilets'].split(",").map(Number);
				        let numberOfBedroom = listBedroom.join("-");
				        title += numberOfBedroom + " phòng vệ sinh, ";
				    }
				    
				    if (result['searchInput'] !== undefined) {
				    	title += result['searchInput'] + ", ";
				    }

				    // Remove the trailing comma and space if it exists
				    if (title.endsWith(", ")) {
				        title = title.slice(0, -2);
				    }

				    document.querySelector(".sell-content__title").textContent = title;


				}
		    	
		        var hasQueryString = url.indexOf('?') !== -1;
		        
		        $('.list-filter').append(
		            "<a href='" + url + "'><li><span>Thông thường</span></li></a>" +
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
		    
		    
		    // Handle show and copy phonenumber
		   $(".card-contact-button__phonenumber").on("click", function(e) {
			    e.preventDefault();
			    
			    <% if(currentUser==null) { %>
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