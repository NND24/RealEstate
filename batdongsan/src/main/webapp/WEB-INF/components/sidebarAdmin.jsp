<%@ page pageEncoding="utf-8"%>

<div class='sidebar'>
	<div class='sidebar-wrapper'>
		<div class='panel-group'>
			<div class='panel panel-default'>
				<div class='panel-heading'>
					<h4 class='panel-title'>
						<a href="${pageContext.servletContext.contextPath}/admin/dashboard.html">
							<div>
								<i class="fa-solid fa-table-columns"></i> <span>Trang chủ</span>
							</div></a>
					</h4>
				</div>
			</div>
		</div>
		<div class='panel-group'>
			<div class='panel panel-default'>
				<div class='panel-heading'>
					<h4 class='panel-title'>
						<a data-toggle='collapse' href='#collapse1'>
							<div>
								<i class='fa-solid fa-list'></i> <span> Quản lý tin đăng</span>
							</div> <i class='fa-solid fa-angle-down'></i>
						</a>
					</h4>
				</div>
				<div id='collapse1' class='panel-collapse collapse'>
					<ul class='list-group'>
						<li class='list-group-item'>Đăng mới</li>
						<li class='list-group-item'>Danh sách tin</li>
						<li class='list-group-item'>Tin nháp</li>
					</ul>
				</div>
			</div>
		</div>

		<div class='panel-group'>
			<div class='panel panel-default'>
				<div class='panel-heading'>
					<h4 class='panel-title'>
						<a href='${pageContext.servletContext.contextPath}/admin/listNews.html'>
							<div>
								<i class="fa-solid fa-newspaper"></i> <span> Quản lý tin tức</span>
							</div>
						</a>
					</h4>
				</div>
			</div>
		</div>

		<div class='panel-group'>
			<div class='panel panel-default'>
				<div class='panel-heading'>
					<h4 class='panel-title'>
						<a href='${pageContext.servletContext.contextPath}/admin/listEmployee.html' >
							<div>
								<i class="fa-solid fa-users"></i> <span>Quản lý nhân viên</span>
							</div>
						</a>
					</h4>
				</div>
			</div>
		</div>

		<div class='panel-group'>
			<div class='panel panel-default'>
				<div class='panel-heading'>
					<h4 class='panel-title'>
						<a href='${pageContext.servletContext.contextPath}/admin/listCategory.html'>
							<div>
								<i class="fa-solid fa-table-list"></i> <span>Quản lý danh mục</span>
							</div>
						</a>
					</h4>
				</div>
				<div id='collapse4' class='panel-collapse collapse'>
					<ul class='list-group'>
						<li class='list-group-item'>Thông báo</li>
						<li class='list-group-item'>Quản lý đăng ký nhận email</li>
						<li class='list-group-item'>Yêu cầu khóa tài khoản</li>
					</ul>
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
