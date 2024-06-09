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
<link rel="stylesheet" href="../css/client/moreNews.css"
	type="text/css">
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
												<span class='primary'>Tên người viết: ${n.employee.fullname}</span>
												<div class='secondary'></div>
											</div>
											<div class='detail-item'>
												<span class='primary'>${n.dateUploaded}</span>
												<div class='secondary'></div>
											</div>
											
										</div>
										<div>
											<h4 class='header'>${n.title}</h4>
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

	<%@ include file="../../../components/footer.jsp"%>
	<script>
	$(document).ready(function() {

	    var totalPages = ${totalPages};
	    var currentPage = ${currentPage};

	    function loadPage(page) {
	        $.get("danh-sach.html", { page: page})
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
	        $('#news-container .more-post-card').each(function() {
	            var newsTitle = $(this).find('.header').text().toLowerCase();
	            if (newsTitle.includes(searchText)) {
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