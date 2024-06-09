<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Quản lý tin tức</title>
<link rel="stylesheet" href="../css/admin/listNews.css?version=58"
	type="text/css">
<link rel="stylesheet" href="../css/client/index.css" type="text/css">
<link rel="stylesheet" href="../css/admin/headerAdmin.css"
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
							<i class="fa-solid fa-tags"></i> <span  id="filter-display"> <c:choose>
									<c:when test="${filter == null}">Tất cả</c:when>
									<c:when test="${filter == 'approved'}">Đã duyệt</c:when>
									<c:when test="${filter == 'hidden'}">Đã ẩn</c:when>
								</c:choose>
							</span> <i class='fa-solid fa-angle-down'></i>
						</button>
						<ul class='dropdown-menu'>
							<li><a href='listNews.html?filter='>Tất cả</a></li>
							<li><a href='listNews.html?filter=approved'>Đã duyệt</a></li>
							<li><a href='listNews.html?filter=hidden'>Đã ẩn</a></li>
						</ul>
					</div>
				</div>
				<div class='post-container'>
					<div class='tab-content' id="news-container">
						<c:forEach var="n" items="${listOfNews}">
							<div class='admin-post-card'>
								<div>
									<div class="img-wrapper">
										<img
										src="${pageContext.servletContext.contextPath}/images/News/${n.thumbnail}"
										alt="" />
									</div>									
									<div class='post-content-container'>
										<div>
											<h4 class='title'>${n.title}</h4>
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


	</div>
	<script>
	$(document).ready(function() {

	    var totalPages = ${totalPages};
	    var currentPage = ${currentPage};
	    var filter = "${filter}"; // Lấy filter hiện tại từ server

	    function loadPage(page) {
	        $.get("danh-sach.html", { page: page, filter: filter })
	            .done(function(data) {
	                var newContent = $(data).find('#news-container').html();
	                $('#news-container').html(newContent);
	                $('#pagination').twbsPagination('changeTotalPages', totalPages, page);
	            })
	            .fail(function() {
	                console.error('Error while fetching data from server.');
	            });
	    }

	    $('#pagination').twbsPagination({
	        totalPages: totalPages,
	        visiblePages: 5,
	        startPage: currentPage,
	        onPageClick: function(event, page) {
	            if (page !== currentPage) {
	                currentPage = page;
	                loadPage(page);
	            }
	        },
	        first: 'Đầu',
	        prev: '<i class="fas fa-angle-left"></i>',
	        next: '<i class="fas fa-angle-right"></i>',
	        last: 'Cuối'
	    });

	    // Initial load
	    loadPage(currentPage);

	    // Chức năng tìm kiếm
	    $('#searchInput').on('keyup', function() {
	        var searchText = $(this).val().toLowerCase();
	        $('#news-container .admin-post-card').each(function() {
	            var newsId = $(this).find('.detail-item .secondary').first().text().toLowerCase();
	            var newsTitle = $(this).find('.header').text().toLowerCase();
	            if (newsId.includes(searchText) || newsTitle.includes(searchText)) {
	                $(this).show();
	            } else {
	                $(this).hide();
	            }
	        });
	    });

	    // Chức năng lọc trạng thái
	    $('.dropdown-menu a').on('click', function() {
	        filter = $(this).attr('href').split('=')[1];
	        $('#filter-display').text($(this).text());
	        loadPage(currentPage);
	        return false;
	    });
	});

	</script>
</body>
</html>