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
<link rel="stylesheet" href="../css/client/listPost.css" type="text/css">
<%@ include file="../../../../links/links.jsp"%>
<script src="https://cdn.ckeditor.com/ckeditor5/41.2.1/classic/ckeditor.js"></script>


<base href="${pageContext.servletContext.contextPath}/">
</head>
<body>
	<%@ include file="../../../components/header.jsp"%>
	<div class='sellernet'>
		<%@ include file="../../../components/sellernetSidebar.jsp"%>

		<!-- ListPost -->
		<div class='list-post'>
			<h1>Danh sách tin</h1>
			<div class='content-container'>
				<div class='filter-wrapper'>
					<div class='search-input'>
						<input type='text' placeholder='Tìm theo mã tin, tiêu đề' /> <i
							class='fa-solid fa-magnifying-glass'></i>
					</div>
					<div class='dropdown'>
						<button class='btn dropdown-toggle' type='button'
							data-toggle='dropdown'>
							<i class='fa-regular fa-calendar'></i> <span>Mặc định</span>
							<i class='fa-solid fa-angle-down'></i>
						</button>
						<ul class='dropdown-menu'>
							<li><a href='#HTML'>Mặc định</a></li>
							<li><a href='#'>1 tuần qua</a></li>
							<li><a href='#'>30 ngày qua</a></li>
						</ul>
					</div>
				</div>

				<div class='post-container'>
					<ul class='nav nav-tabs'>
						<li class='active'><a data-toggle='tab' href='#home'>
								Tất cả </a></li>
						<li><a data-toggle='tab' href='#menu1'> Hết hạn </a></li>
						<li><a data-toggle='tab' href='#menu2'> Sắp hết hạn </a></li>
						<li><a data-toggle='tab' href='#menu3'> Đang hiển thị </a></li>
					</ul>

					<div class='tab-content'>
						<div id='home' class='tab-pane fade in active'>
							<div class='post-card'>
								<div>
									<img src={home} alt='' />
									<div class='post-content-container'>
										<div>
											<h4 class='header'>Bán nhà riêng m2 riêng m2 đường
												Nguyễn Thái Học, Bán nhà riêng m2 riêng m2 đường Nguyễn Thái
												Học</h4>
											<div class='location'>
												<span>Bán nhà mặt phố</span> <span> · </span> <span>Bình
													Thạnh, Hồ Chí Minh</span>
											</div>
										</div>
										<div class='detail-container'>
											<div class='detail-item'>
												<span class='primary'>Trạng thái</span>
												<div class='status'>Đang hiển thị</div>
											</div>
											<div class='detail-item'>
												<span class='primary'>Mã tin</span>
												<div class='secondary'>28794101</div>
											</div>
											<div class='detail-item'>
												<span class='primary'>Ngày đăng</span>
												<div class='secondary'>21/12/2022</div>
											</div>
											<div class='detail-item'>
												<span class='primary'>Ngày hết hạn</span>
												<div class='secondary'>31/12/2022</div>
											</div>
											<div class='detail-item'>
												<span class='primary'>Thời gian</span>
												<div class='secondary'>Còn 10 ngày</div>
											</div>
										</div>
									</div>
								</div>
								<div>
									<div class='blank-container'></div>
									<div class='button-container'>
										<div class='button-item'>
											<i class='fa-regular fa-flag'></i> <span>Báo cáo</span>
										</div>
										<div class='button-item'>
											<i class='fa-solid fa-ranking-star'></i> <span>Chi
												tiết</span>
										</div>
										<div class='button-item'>
											<i class='fa-solid fa-pencil'></i> <span>Sửa tin</span>
										</div>
										<div class='button-item'>
											<i class='fa-regular fa-share-from-square'></i> <span>Chia
												sẻ</span>
										</div>
										<div class='dropdown'>
											<div class='button-item dropdown-toggle' type='button'
												data-toggle='dropdown'>
												<i class='fa-solid fa-ellipsis'></i> <span>Thao
													tác</span>
											</div>
											<ul class='dropdown-menu'>
												<li><a href='#'> <i class='fa-solid fa-pencil'></i>
														<span>Sửa tin</span>
												</a></li>
												<li><a href='#'>CSS</a></li>
												<li><a href='#'>JavaScript</a></li>
											</ul>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div id='menu1' class='tab-pane fade'>
							<h3>Menu 1</h3>
							<p>Ut enim ad minim veniam, quis nostrud exercitation ullamco
								laboris nisi ut aliquip ex ea commodo consequat.</p>
						</div>
						<div id='menu2' class='tab-pane fade'>
							<h3>Menu 2</h3>
							<p>Sed ut perspiciatis unde omnis iste natus error sit
								voluptatem accusantium doloremque laudantium, totam rem aperiam.
							</p>
						</div>
						<div id='menu3' class='tab-pane fade'>
							<h3>Menu 3</h3>
							<p>Eaque ipsa quae ab illo inventore veritatis et quasi
								architecto beatae vitae dicta sunt explicabo.</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
	
	</script>
</body>
</html>