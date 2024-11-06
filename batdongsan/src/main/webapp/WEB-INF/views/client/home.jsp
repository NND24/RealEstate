<%@page import="batdongsan.models.NewsModel"%>
<%@page import="batdongsan.models.FavouriteModel"%>
<%@page import="batdongsan.models.HCMRealEstateModel"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Website số 1 về bất động sản</title>
    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/client/index.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/client/header.css?version=52" type="text/css">
    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/client/home.css?version=52" type="text/css">
    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/client/footer.css" type="text/css">
    <%@ include file="../../../links/links.jsp" %>
    <base href="${pageContext.servletContext.contextPath}/">
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
						<a href='${pageContext.servletContext.contextPath}/tin-tuc.html'
							class='tabview'> <span>Xem thêm</span> <i
							class='fa-solid fa-arrow-right'></i>
						</a>
					</ul>
					<%
					List<NewsModel> listNews = (List<NewsModel>) request.getAttribute("listNews");
					List<NewsModel> listNewsHN = (List<NewsModel>) request.getAttribute("listNewsHN");
					List<NewsModel> listNewsHCM = (List<NewsModel>) request.getAttribute("listNewsHCM");
					%>

					<div class='tab-content'>
						<%
						if (listNews != null) {
						%>
						<div id='tinNoiBat' class='tab-pane fade in active'>
							<div class='article-container'>
								<a
									href='${pageContext.servletContext.contextPath}/tin-tuc/<%= listNews.get(0).getNewsId() %>.html'
									class='article-info-container'> <img
									src='${pageContext.servletContext.contextPath}/images/News/<%= listNews.get(0).getThumbnail() %>'
									alt='' />
									<h3><%=listNews.get(0).getTitle()%></h3>
								</a>
								<div class='article-list-container'>
									<ul>
										<%
										if (listNews != null) {
											int i = 0;
											for (NewsModel n : listNews) {
												i++;
												if (i == 7) {
											break;
												}
										%>
										<li><a
											href='${pageContext.servletContext.contextPath}/tin-tuc/<%= n.getNewsId() %>.html'><%=n.getTitle()%></a>
										</li>
										<%
										}
										}
										%>
									</ul>
								</div>
							</div>
						</div>
						<div id='tinTuc' class='tab-pane fade'>
							<div class='article-container'>
								<a
									href='${pageContext.servletContext.contextPath}/tin-tuc/<%= listNews.get(0).getNewsId() %>.html'
									class='article-info-container'> <img
									src='${pageContext.servletContext.contextPath}/images/News/<%= listNews.get(0).getThumbnail() %>'
									alt='' />
									<h3><%=listNews.get(0).getTitle()%></h3>
								</a>
								<div class='article-list-container'>
									<ul>
										<%
										if (listNews != null) {
											int i = 0;
											for (NewsModel n : listNews) {
												i++;
												if (i == 7) {
											break;
												}
										%>
										<li><a
											href='${pageContext.servletContext.contextPath}/tin-tuc/<%= n.getNewsId() %>.html'><%=n.getTitle()%></a>
										</li>
										<%
										}
										}
										%>
									</ul>
								</div>
							</div>
						</div>

						<%
						}
						%>
						<%
						if (listNewsHCM != null) {
						%>
						<div id='bdsHcm' class='tab-pane fade'>
							<div class='article-container'>
								<a
									href='${pageContext.servletContext.contextPath}/tin-tuc/<%= listNewsHCM.get(0).getNewsId() %>.html'
									class='article-info-container'> <img
									src='${pageContext.servletContext.contextPath}/images/News/<%= listNewsHCM.get(0).getThumbnail() %>'
									alt='' />
									<h3><%=listNewsHCM.get(0).getTitle()%></h3>
								</a>
								<div class='article-list-container'>
									<ul>
										<%
										if (listNewsHCM != null) {
											int i = 0;
											for (NewsModel n : listNewsHCM) {
												i++;
												if (i == 7) {
											break;
												}
										%>
										<li><a
											href='${pageContext.servletContext.contextPath}/tin-tuc/<%= n.getNewsId() %>.html'><%=n.getTitle()%></a>
										</li>
										<%
										}
										}
										%>
									</ul>
								</div>
							</div>
						</div>
						<%
						}
						%>
						<%
						if (listNewsHN != null) {
						%>
						<div id='bdsHN' class='tab-pane fade'>
							<div class='article-container'>
								<a
									href='${pageContext.servletContext.contextPath}/tin-tuc/<%= listNewsHN.get(0).getNewsId() %>.html'
									class='article-info-container'> <img
									src='${pageContext.servletContext.contextPath}/images/News/<%= listNewsHN.get(0).getThumbnail() %>'
									alt='' />
									<h3><%=listNewsHN.get(0).getTitle()%></h3>
								</a>
								<div class='article-list-container'>
									<ul>
										<%
										if (listNewsHN != null) {
											int i = 0;
											for (NewsModel n : listNewsHN) {
												i++;
												if (i == 7) {
											break;
												}
										%>
										<li><a
											href='${pageContext.servletContext.contextPath}/tin-tuc/<%= n.getNewsId() %>.html'><%=n.getTitle()%></a>
										</li>
										<%
										}
										}
										%>
									</ul>
								</div>
							</div>
						</div>
						<%
						}
						%>
					</div>
				</div>

				<!-- 	<div class='home__hot-news-banner'>
					<img
						src='https://tpc.googlesyndication.com/simgad/3748612651896058688'
						alt='' />
				</div>  -->
			</div>
		</div>

		<!-- BDSForYouContent -->
		<div class='content-container gray-background '>
			<div class='container '>
				<div class='content__header'>
					<h3 class='content__header--label'>Bất động sản dành cho bạn</h3>
					<div class='content-container-link'>
						<a
							href='${pageContext.servletContext.contextPath}/nha-dat-ban.html'>Tin
							nhà đất mới nhất</a> <span>|</span> <a
							href='${pageContext.servletContext.contextPath}/nha-dat-cho-thue.html'>Tin
							nhà đất cho thuê mới nhất</a>
					</div>
				</div>
				<div class='product-container '>
					<div class='row'>
						<%
						List<HCMRealEstateModel> listREForYou = (List<HCMRealEstateModel>) request.getAttribute("listREForYou");

						if (listREForYou != null) {
							int i = 0;
							for (HCMRealEstateModel r : listREForYou) {
								i++;
								if (i == 9) {
							break;
								}
								String imageString = (String) r.getImages();

								if (imageString != null && !imageString.isEmpty()) {
							imageString = imageString.substring(1, imageString.length() - 1);
							String[] imagePaths = imageString.split(",");
						%>
						<div class='col-lg-3'>
							<div class='card'>
								<a
									href="http://localhost:8080/batdongsan/chi-tiet.html?realEstateId=<%=r.getRealEstateId()%>">
									<img class='card-img-top' src="images/<%=imagePaths[0]%>"
									alt='' />
								</a>
								<div class='card-info-container'>
									<a
										href="http://localhost:8080/batdongsan/chi-tiet.html?realEstateId=<%=r.getRealEstateId()%>">
										<h3 class='card-title'><%=r.getTitle()%></h3>
									</a>
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
										</span> <i class='fa-solid fa-circle'></i> <span
											class='card-config-area'><%=r.getSize()%> m²</span>
									</div>
									<div class='card-location'>
										<i class='fa-solid fa-location-dot'></i> <span><%=r.getDistrict().getName()%>,
											Thành Phố Hồ Chí Minh</span>
									</div>
									<div class='card-contact'>
										<span class='card-published-info' data-toggle='tooltip2'
											data-placement='right' title='<%=r.getSubmittedDate()%>'
											value='<%=r.getSubmittedDate()%>'></span>
										<button class='card-contact-button' data-toggle='tooltip'
											data-placement='bottom' title='Bấm để lưu tin '
											value="<%=r.getRealEstateId()%>">
											<%
											if (user != null) {
												Boolean showHeart = false;
												for (FavouriteModel fa : r.getFavourite()) {
													if (fa.getUser() == user) {
												showHeart = true;
												break;
													}
												}
											%>
											<i class='fa-regular fa-heart'
												style="display: <%=showHeart ? "none" : "block"%>;"></i> <i
												class="fa-solid fa-heart"
												style="color: #e03c31;display: <%=showHeart ? "block" : "none"%>;"></i>
											<%
											} else {
											%>
											<i class='fa-regular fa-heart' style="display:"block";"></i>
											<%
											}
											%>
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
				<!--  	<div class='product-view-container'>
					<a href='${pageContext.servletContext.contextPath}/nha-dat-ban.html' class='product-view-more'>
						<span>Xem thêm</span>
					</a>
				</div> -->
			</div>
		</div>

		<!-- PlaceBlockContent -->
		<div class='content-container white-background '>
			<div class='container'>
				<div class='content__header'>
					<h3 class='content__header--label'>Bất động sản theo địa điểm</h3>
				</div>
				<div class='place-container'>
					<a
						href="${pageContext.servletContext.contextPath}/nha-dat-ban.html?districtId=1"
						class='place-item place-big'> <img
						src='https://file4.batdongsan.com.vn/images/newhome/cities1/HCM-web-2.jpg'
						alt='' />
						<div class='place-info'>
							<span class='place-name'>Quận 1</span> <span
								class='place-number'><%=request.getAttribute("amountREHCM")%>
								tin đăng</span>
						</div>
					</a>
					<div class='place-small'>
						<div class='row'>
							<a
								href="${pageContext.servletContext.contextPath}/nha-dat-ban.html?districtId=2"
								class='col-lg-6 place-item'> <img
								src='https://file4.batdongsan.com.vn/images/newhome/cities1/HN-web-2.jpg'
								alt='' />
								<div class='place-info'>
									<span class='place-name'>Quận 2</span> <span
										class='place-number'><%=request.getAttribute("amountREHN")%>
										tin đăng</span>
								</div>
							</a> <a
								href="${pageContext.servletContext.contextPath}/nha-dat-ban.html?districtId=3"
								class='col-lg-6 place-item'> <img
								src='https://file4.batdongsan.com.vn/images/newhome/cities1/DDN-web-2.jpg'
								alt='' />
								<div class='place-info'>
									<span class='place-name'>Quận 3</span> <span
										class='place-number'><%=request.getAttribute("amountREDaNang")%>
										tin đăng</span>
								</div>
							</a> <a
								href="${pageContext.servletContext.contextPath}/nha-dat-ban.html?districtId=4"
								class='col-lg-6 place-item'> <img
								src='https://file4.batdongsan.com.vn/images/newhome/cities1/BD-web-1.jpg'
								alt='' />
								<div class='place-info'>
									<span class='place-name'>Quận 4</span> <span
										class='place-number'><%=request.getAttribute("amountREBD")%>
										tin đăng</span>
								</div>
							</a> <a
								href="${pageContext.servletContext.contextPath}/nha-dat-ban.html?districtId=5"
								class='col-lg-6 place-item'> <img
								src='https://file4.batdongsan.com.vn/images/newhome/cities1/DNA-web-2.jpg'
								alt='' />
								<div class='place-info'>
									<span class='place-name'>Quận 6</span> <span
										class='place-number'><%=request.getAttribute("amountREDongNai")%>
										tin đăng</span>
								</div>
							</a>
						</div>
					</div>
				</div>
			</div>
		</div>



		<!-- NewsBlockContent -->
		<div class='content-container white-background '>
			<div class='container'>
				<div class='swiper mySwiper3'>
					<div class='recommend-list-header'>
						<h5 class='recommend-title'>Bất động sản dành cho bạn</h5>
					</div>
					<div class='swiper-wrapper'>
						<%
						if (listREForYou != null) {
							int i = 0;
							for (NewsModel n : listNews) {
						%>
						<div class='swiper-slide'>
							<a
								href='${pageContext.servletContext.contextPath}/tin-tuc/<%= n.getNewsId() %>.html'
								class='card'> <img class='card-img-top'
								src='${pageContext.servletContext.contextPath}/images/News/<%= n.getThumbnail() %>'
								alt='' />
								<div class='card-info-container'>
									<h3 class='card-title'><%=n.getTitle()%></h3>
								</div>
							</a>
						</div>
						<%
						}
						}
						%>
					</div>
					<div class='swiper-button-next'></div>
					<div class='swiper-button-prev'></div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="../../components/footer.jsp"%>

	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							var swiper3 = new Swiper(".mySwiper3", {
								slidesPerView : 4,
								spaceBetween : 15,
								navigation : {
									nextEl : ".swiper-button-next",
									prevEl : ".swiper-button-prev",
								},
							});

							$(".card-published-info").each(
									function() {
										var submittedTime = $(this).attr(
												"value").trim();
										var timeAgo = moment(submittedTime)
												.locale('vi').fromNow();
										$(this).text(timeAgo);
									});

							// HANDLE ADD TO FAVOURITE
							$(".card-contact-button")
									.on(
											"click",
											function(e) {
												e.preventDefault();
	<%if (user == null) {%>
		swal({
													title : "Vui lòng đăng nhập để tiếp tục!",
													icon : "error",
													button : "OK"
												});
	<%} else {%>
		var regularHeartIcon = $(this)
														.find(
																".fa-regular.fa-heart");
												var solidHeartIcon = $(this)
														.find(
																".fa-solid.fa-heart");
												if (regularHeartIcon
														.css("display") === "block") {
													regularHeartIcon.css(
															"display", "none");
													solidHeartIcon.css(
															"display", "block");
												} else {
													regularHeartIcon.css(
															"display", "block");
													solidHeartIcon.css(
															"display", "none");
												}

												var realEstateId = $(this)
														.attr("value");
												$
														.ajax({
															type : 'GET',
															url : '${pageContext.servletContext.contextPath}/addToFavourite.html',
															data : {
																realEstateId : realEstateId
															},
															dataType : 'text',
															success : function(
																	data) {
																console
																		.log("Thêm thành công");
															},
															error : function(
																	xhr,
																	status,
																	error) {
																console
																		.log("Thêm thất bại")
															}
														});
	<%}%>
		});

						});
	</script>
</body>
</html>