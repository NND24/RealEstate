<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<div class='sidebar'>
	<div class='sidebar-wrapper'>
		<div class='panel-group'>
			<div class='panel panel-default'>
				<div class='panel-heading'>
					<h4 class='panel-title'>
						<a
							href="${pageContext.servletContext.contextPath}/admin/dashboard.html">
							<div>
								<i class="fa-solid fa-table-columns"></i> <span>Trang chủ</span>
							</div>
						</a>
					</h4>
				</div>
			</div>
		</div>
		<!-- Quản lý tin đăng -->
		<c:if test="${fn:contains(permissions, 1) || fn:contains(permissions, 2)}">
			<div class='panel-group'>
				<div class='panel panel-default'>
					<div class='panel-heading'>
						<h4 class='panel-title'>
							<a
								href='${pageContext.servletContext.contextPath}/admin/quan-ly-bat-dong-san.html'>
								<div>
									<i class="fa-regular fa-building"></i> <span> Quản lý bài đăng</span>
								</div>
							</a>
						</h4>
					</div>
				</div>
			</div>
		</c:if>

		<!-- Quản lý tin tức -->
		<c:if test="${fn:contains(permissions, 1) || fn:contains(permissions, 3)}">
			<div class='panel-group'>
				<div class='panel panel-default'>
					<div class='panel-heading'>
						<h4 class='panel-title'>
							<a
								href='${pageContext.servletContext.contextPath}/admin/listNews.html'>
								<div>
									<i class="fa-solid fa-newspaper"></i></i> <span> Quản lý tin
										tức</span>
								</div>
							</a>
						</h4>
					</div>
				</div>
			</div>
		</c:if>

		<!-- Quản lý nhân viên -->
		<c:if test="${fn:contains(permissions, 1) || fn:contains(permissions, 4)}">
			<div class='panel-group'>
				<div class='panel panel-default'>
					<div class='panel-heading'>
						<h4 class='panel-title'>
							<a
								href='${pageContext.servletContext.contextPath}/admin/listEmployee.html'>
								<div>
									<i class="fa-solid fa-user-tie"></i> <span>Quản lý nhân
										viên</span>
								</div>
							</a>
						</h4>
					</div>
				</div>
			</div>
		</c:if>
		
		<!-- Quản lý người bán -->
		<c:if test="${fn:contains(permissions, 1) || fn:contains(permissions, 5)}">
			<div class='panel-group'>
				<div class='panel panel-default'>
					<div class='panel-heading'>
						<h4 class='panel-title'>
							<a
								href='${pageContext.servletContext.contextPath}/admin/listUser.html'>
								<div>
									<i class="fa-solid fa-users"></i> <span>Quản lý người bán
										</span>
								</div>
							</a>
						</h4>
					</div>
				</div>
			</div>
		</c:if>

		<!-- Quản lý danh mục (chỉ admin) -->
		<c:if test="${fn:contains(permissions, 1)}">
			<div class='panel-group'>
				<div class='panel panel-default'>
					<div class='panel-heading'>
						<h4 class='panel-title'>
							<a
								href='${pageContext.servletContext.contextPath}/admin/listCategory.html'>
								<div>
									<i class="fa-solid fa-list"></i></i> <span>Quản lý
										danh mục</span>
								</div>
							</a>
						</h4>
					</div>
				</div>
			</div>
		</c:if>
		
		<!-- Quản lý danh mục (chỉ admin) -->
		<c:if test="${fn:contains(permissions, 1)}">
			<div class='panel-group'>
				<div class='panel panel-default'>
					<div class='panel-heading'>
						<h4 class='panel-title'>
							<a
								href='${pageContext.servletContext.contextPath}/admin/thong-minh.html'>
								<div>
									<i class="fa-solid fa-brain"></i></i> <span>Quản lý thông minh</span>
								</div>
							</a>
						</h4>
					</div>
				</div>
			</div>
		</c:if>
		
		<div class='panel-group'>
			<div class='panel panel-default'>
				<div class='panel-heading'>
					<h4 class='panel-title'>
						<a
							href='${pageContext.servletContext.contextPath}/trang-chu.html'>
							<div>
								<i class="fa-solid fa-circle-left"></i> <span>Trở lại trang PTIT HOUSE</span>
							</div>
						</a>
					</h4>
				</div>
			</div>
		</div>
	</div>

	<div class='collapse-container collapse-container-1'>
		<ul class='list-group'>
			<li class='list-group-item'>Đăng mới</li>
			<li class='list-group-item'>Danh sách tin</li>
			<li class='list-group-item'>Tin nháp</li>
		</ul>
	</div>

	<div class='collapse-container collapse-container-2'>
		<ul class='list-group'>
			<li class='list-group-item'>Đăng mới</li>
			<li class='list-group-item'>Danh sách tin</li>
			<li class='list-group-item'>Tin nháp</li>
		</ul>
	</div>

	<div class='collapse-container collapse-container-3'>
		<ul class='list-group'>
			<li class='list-group-item'>Đăng mới</li>
			<li class='list-group-item'>Danh sách tin</li>
			<li class='list-group-item'>Tin nháp</li>
		</ul>
	</div>
</div>
