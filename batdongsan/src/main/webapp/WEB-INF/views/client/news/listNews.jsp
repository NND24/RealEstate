<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Website số 1 về bất động sản</title>
<link rel="stylesheet" href="../css/client/header.css" type="text/css">
<link rel="stylesheet" href="../css/client/news.css?version=50"
	type="text/css">
<link rel="stylesheet" href="../css/client/moreNews.css" type="text/css">
<%@ include file="../../../../links/links.jsp"%>
</head>
<body>
	<%@ include file="../../../components/header.jsp"%>
	<!-- ListNews -->
	<div class='more-list-news'>
		<div class='head-container'>
			<h1>Danh sách tin tức</h1>
		</div>
		<div class='content-container'>
			<div class='filter-wrapper'>
				<div class='search-input'>
					<input type='text' id="searchInput"
						placeholder='Tìm theo mã tin, tiêu đề' />
				</div>
			</div>
			<div class='post-container'>
				<div class='tab-content' id="news-container">
					<c:forEach var="n" items="${listOfNews}">
						<div class='more-post-card'>
							<div>
								<img
									src="${pageContext.servletContext.contextPath}/images/News/${n.thumbnail}"
									alt="" />
								<div class='post-content-container'>
									<div class='detail-container'>
										<div class='detail-item'>
											<span class='primary'>Tên người viết:
												${n.employee.fullname}</span>
											<div class='secondary'></div>
										</div>
										<div class='detail-item'>
											<span class='primary'>${n.dateUploaded}</span>
											<div class='secondary'></div>
										</div>

									</div>
									<div>
										<a href="${n.newsId}.html"><h4 class='header'>${n.title}</h4></a>
										<div class='location'>
											<span>${n.shortDescription}</span>
										</div>
									</div>
								</div>
							</div>
							<div>
								<div class='blank-container'></div>
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
	<input type="hidden" id="totalPages" value="${totalPages}" />
	<input type="hidden" id="currentPage" value="${currentPage}" />	
	<%@ include file="../../../components/footer.jsp"%>
	<script>
	$(document).ready(function() {
	    var totalPages = parseInt('${totalPages}');
	    var currentPage = parseInt('${currentPage}');

	    function loadPage(page, searchText) {
	        $.get("danh-sach.html", { page: page, search: searchText })
	            .done(function(data) {
	                var newContent = $(data).find('#news-container').html();
	                $('#news-container').html(newContent);

	                // Cập nhật totalPages và currentPage từ nội dung trả về
	                totalPages = parseInt($(data).find('#totalPages').val());
	                currentPage = parseInt($(data).find('#currentPage').val());

	                // Kiểm tra và cập nhật pagination
	                $('#pagination').twbsPagination('destroy');
	                initPagination(totalPages, currentPage);
	            })
	            .fail(function() {
	                console.error('Error while fetching data from server.');
	            });
	    }

	    function initPagination(totalPages, startPage) {
	        $('#pagination').twbsPagination({
	            totalPages: totalPages,
	            visiblePages: 5,
	            startPage: startPage,
	            onPageClick: function(event, page) {
	                if (page !== currentPage) {
	                    currentPage = page;
	                    var searchText = $('#searchInput').val();
	                    loadPage(page, searchText);
	                }
	            },
	            first: 'Đầu',
	            prev: '<i class="fas fa-angle-left"></i>',
	            next: '<i class="fas fa-angle-right"></i>',
	            last: 'Cuối'
	        });
	    }

	    // Initial load
	    initPagination(totalPages, currentPage);

	    // Chức năng tìm kiếm
	    $('#searchInput').on('keyup', function() {
	        var searchText = $(this).val().toLowerCase();
	        loadPage(1, searchText);
	    });
	});
</script>
</body>
</html>