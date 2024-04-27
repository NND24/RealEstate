<%@page import="batdongsan.models.UsersModel"%>
<%@ page pageEncoding="utf-8"%>

<div class='sidebar'>
	<div class='sidebar-wrapper'>
		<div class='user-info-wrapper'>
			<%
			UsersModel user1 = (UsersModel) request.getAttribute("user");
			%>
			<img class="avatar" alt="" src="<%=user1.getAvatar()%>" /> 
			<div>
				<a href='' class='user-name'> <%=user1.getName()%> </a>
				<p>0 điểm</p>
			</div>
		</div>

		<div class='user-money-wrapper'>
			<div class='user-money-item'>
				<h5>Số dư tài khoản</h5>
			</div>
			<div class='user-money-item'>
				<div>Tài khoản chính</div>
				<div class='money'><%=user1.getAccountBalance()%></div>
			</div>

			<a href='${pageContext.servletContext.contextPath}/sellernet/nap-tien.html'>
				<button type='border' color='primary'>
					<i class='fa-regular fa-credit-card'></i> <span>Nạp tiền</span>
				</button>
			</a>
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
						<a href="${pageContext.servletContext.contextPath}/sellernet/dang-tin/ban.html">
							<li class='list-group-item'>Đăng mới</li>
						</a>
						<a href="${pageContext.servletContext.contextPath}/sellernet/quan-ly-tin-rao-ban-cho-thue.html">
							<li class='list-group-item'>Danh sách tin</li>
						</a>
					</ul>
				</div>
			</div>
		</div>

		<div class='panel-group'>
			<div class='panel panel-default'>
				<div class='panel-heading'>
					<h4 class='panel-title'>
						<a data-toggle='collapse' href='#collapse2'>
							<div>
								<i class='fa-solid fa-coins'></i> <span> Quản lý tài
									chính</span>
							</div> <i class='fa-solid fa-angle-down'></i>
						</a>
					</h4>
				</div>
				<div id='collapse2' class='panel-collapse collapse'>
					<ul class='list-group'>
						<a href="${pageContext.servletContext.contextPath}/sellernet/nap-tien.html">
							<li class='list-group-item'>Nạp tiền vào tài khoản</li>
						</a>
					</ul>
				</div>
			</div>
		</div>
		
		<div class='panel-group'>
			<div class='panel panel-default'>
				<div class='panel-heading'>
					<h4 class='panel-title'>
						<a data-toggle='collapse' href='#collapse3'>
							<div>
								<i class="fa-regular fa-user"></i> <span> Quản lý TK cá nhân</span>
							</div> <i class='fa-solid fa-angle-down'></i>
						</a>
					</h4>
				</div>
				<div id='collapse3' class='panel-collapse collapse'>
					<ul class='list-group'>
						<a href="${pageContext.servletContext.contextPath}/sellernet/thong-tin-ca-nhan.html?edit=true">
							<li class='list-group-item'>Chỉnh sửa thông tin cá nhân</li>
						</a>
						<a href="${pageContext.servletContext.contextPath}/sellernet/thong-tin-ca-nhan.html?setting=true">
							<li class='list-group-item'>Cài đặt tài khoản</li>
						</a>
					</ul>
				</div>
			</div>
		</div>
		
	</div>
</div>