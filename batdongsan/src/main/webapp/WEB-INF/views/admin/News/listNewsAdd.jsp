<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Thêm tin tức</title>
<link rel="stylesheet" href="../../css/admin/listNews.css?version=56"
	type="text/css">
<link rel="stylesheet" href="../../css/client/index.css" type="text/css">
<link rel="stylesheet" href="../../css/admin/headerAdmin.css?version=56"
	type="text/css">
<%@ include file="../../../../links/links.jsp"%>
</head>
<body>
	<%@ include file="../../../components/headerAdmin.jsp"%>
	<div class='admin'>
		<%@ include file="../../../components/sidebarAdmin.jsp"%>
		<!-- ListNews -->
		<div class='admin-list-news'>
			<div class='head-container'>
				<h1>Danh sách tin tức</h1>
				<a href="listNews/add.html"><button class='add-new-button'
						id="addNewsButton">Thêm mới</button></a>
			</div>
			<div class='content-container'>
				<div class='filter-wrapper'>
					<div class='search-input'>
						<input type='text' id="searchInput"
							placeholder='Tìm theo mã tin, tiêu đề' /> <i
							class='fa-solid fa-magnifying-glass'></i>
					</div>
					<div class='dropdown'>
						<button class='btn dropdown-toggle' type='button'
							data-toggle='dropdown'>
							<i class='fa-regular fa-calendar'></i> <span>Mặc định 1</span> <i
								class='fa-solid fa-angle-down'></i>
						</button>
						<ul class='dropdown-menu'>
							<li><a href='#HTML'>Mặc định</a></li>
							<li><a href='#'>1 tuần qua</a></li>
							<li><a href='#'>30 ngày qua</a></li>
						</ul>
					</div>
				</div>

				<div class='post-container'>
					<div class='tab-content' id="news-container">
						<c:forEach var="n" items="${listOfNews}">
							<div class='admin-post-card'>
								<div>
									<img
										src="${pageContext.servletContext.contextPath}/images/News/${n.thumbnail}"
										alt="" />
									<div class='post-content-container'>
										<div>
											<h4 class='header'>${n.title}</h4>
											<div class='location'>
												<span>${n.shortDescription}</span>
											</div>
										</div>
										<div class='detail-container'>
											<div class='detail-item'>
												<span class='primary'>Trạng thái</span>
												<div class='status' data-status='${n.status}'>${n.status ? 'Đang hiển thị' : 'Ẩn'}</div>
											</div>
											<div class='detail-item'>
												<span class='primary'>Mã tin</span>
												<div class='secondary'>${n.newsId}</div>
											</div>
											<div class='detail-item'>
												<span class='primary'>Ngày đăng</span>
												<div class='secondary'>${n.dateUploaded}</div>
											</div>
											<div class='detail-item'>
												<span class='primary'>Mã viết bài</span>
												<div class='secondary'>${n.employee.id}</div>
											</div>
											<div class='detail-item'>
												<span class='primary'>Tên người viết</span>
												<div class='secondary'>${n.employee.fullname}</div>
											</div>
										</div>
									</div>
								</div>
								<div>
									<div class='blank-container'></div>
									<div class='button-container'>
										<div class='button-item'>
											<a href='listNews/approve/${n.newsId}.html'><i
												class='fa-regular fa-flag'></i> <span>Duyệt tin</span></a>
										</div>
										<div class='button-item'>
											<a href="listNews/detailNews/${n.newsId}.html"><i
												class='fa-solid fa-ranking-star'></i> <span>Chi tiết</span></a>

										</div>
										<div class='button-item'>
											<a href='listNews/hide/${n.newsId}.html'><i
												class='fa-solid fa-pencil'></i> <span>Ẩn tin</span></a>
										</div>
										<div class='button-item'>
											<a href='listNews/delete/${n.newsId}.html'><i
												class='fa-regular fa-share-from-square'></i> <span>Xóa
													tin</span></a>
										</div>

										<div class='button-item'>
											<a href='listNews/update/${n.newsId}.html'> <i
												class='fa-solid fa-pencil'></i> <span>Sửa tin</span>
											</a>
										</div>
									</div>
								</div>
							</div>
							<!-- End -->
						</c:forEach>

					</div>
				</div>
				<div class="pagination-container">
					<nav aria-label="Page navigation">
						<ul id="pagination" class="pagination"></ul>
					</nav>
				</div>
			</div>
		</div>

		<!-- ADD NEWS -->
		<div class='add-modal' style="display: flex;" id='addNewsForm'>
			<div class='modal-wrapper'>
				<div class='modal-container'>
					<h1>Thêm tin tức</h1>
					<form:form action="addNews.html" modelAttribute="news"
						method="post" enctype="multipart/form-data">
						<div class='input-container'>
							<div class='form-item'>
								<p>Tiêu đề</p>
								<div class='input-wrapper'>
									<form:input path="title" placeholder='Nhập tiêu đề' />
								</div>
								<c:if test="${not empty titleError}">
									<p class="errorMessage">${titleError}</p>
								</c:if>
							</div>

							<div class='form-item'>
								<p>Trạng thái</p>
								<form:select path="status" class='select-wrapper' name='' id=''>
									<option value='true'>Hiển thị</option>
									<option value='false'>Ẩn</option>
								</form:select>
							</div>
						</div>

						<div class='input-container'>
							<div class='form-item full-width'>
								<p>Mô tả</p>
								<div class='input-wrapper'>
									<form:textarea path="shortDescription" placeholder='Nhập mô tả' />
								</div>
								<c:if test="${not empty shortDescriptionError}">
									<p class="errorMessage">${shortDescriptionError}</p>
								</c:if>
							</div>
						</div>

						<div class='input-container'>
							<div class='form-item full-width'>
								<p>Nội dung</p>
								<div class='input-wrapper input-body-news'>
									<form:textarea id="editor" path='description' cols='30'
										rows='7'></form:textarea>
								</div>
							</div>
						</div>

						<div class='input-container'>
							<div class='form-item'>
								<p>Ảnh tiêu đề</p>
								<div class='input-wrapper'>
									<input type="file" name="thumbnail" />
								</div>
							</div>

						</div>

						<div class='button-wrapper'>
							<div></div>
							<button class='continue-button'>
								<span>Lưu</span>
							</button>
						</div>
					</form:form>

				</div>
			</div>
			<button class='close-btn' id='closeAddModelButton'
				onclick="window.location.href='/batdongsan/admin/updateNews/cancel.html'">
				<i class='fa-solid fa-xmark'></i>
			</button>
		</div>
		<!-- END -->


	</div>
	<script>
		$(document).ready(function() {
			ClassicEditor
	        .create( document.querySelector( '#editor' ) )
	        .catch( error => {
	            console.error( error );
	        } );
			
	         // Chức năng tìm kiếm
	            $('#searchInput').on('keyup', function () {
	                var searchText = $(this).val().toLowerCase();
	                $('#news-container .admin-post-card').each(function () {
	                    var newsId = $(this).find('.detail-item .secondary').first().text().toLowerCase();
	                    var newsTitle = $(this).find('.header').text().toLowerCase();
	                    if (newsId.includes(searchText) || newsTitle.includes(searchText)) {
	                        $(this).show();
	                    } else {
	                        $(this).hide();
	                    }
	                });
	            });
		});
	</script>
</body>
</html>