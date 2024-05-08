<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Website số 1 về bất động sản</title>
<link rel="stylesheet" href="../css/client/index.css" type="text/css">
<link rel="stylesheet" href="../css/client/header.css?version=62"
	type="text/css">
<link rel="stylesheet" href="../css/client/sellernet.css"
	type="text/css">
<link rel="stylesheet" href="../css/client/manageAccount.css?version=64"
	type="text/css">
<%@ include file="../../../../links/links.jsp"%>
<base href="${pageContext.servletContext.contextPath}/">
</head>
<body>
	<%@ include file="../../../components/header.jsp"%>
	<div class='sellernet'>
		<%@ include file="../../../components/sellernetSidebar.jsp"%>

		<!-- ManageAccount -->
		<div class='manage-account'>
			<div class='content-container'>
				<h1>Nạp tiền vào tài khoản</h1>
				<div class='post-container'>
					<form:form action="sellernet/recharge.html" method="post">
						<div class='input-wrapper'>
							<div class='input-container'>
								<div class='form-item recharge'>
									<p>Nhập số tiền bạn muốn nạp (đ)</p>
									<div class='input-wrapper'>
										<input name="money" type='number' />
									</div>
									<p class="errorMessage" style="display: none"></p>
								</div>

								<div class='form-item'>
									<p></p>
									<button class="update-pass-btn" disabled="disabled">Nạp tiền</button>
								</div>
							</div>
						</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		$(document).ready(function() {			
			var money = $('input[name="money"]');

			money.on("input", function() {		    
			    if (money.val() < 10000) {
			        $(".recharge .errorMessage").css("display", "block").text("Số tiền nạp tối thiểu là 10.000đ");
			        $(".recharge .input-wrapper").css("border-color", "rgb(224, 60, 49)")
			    } else {
			        $(".recharge .errorMessage").css("display", "none").text("");
			        $(".recharge .input-wrapper").css("border-color", "#ccc")
			    }
			    			    
			    if(money.val() >= 10000) {
			    	 $(".update-pass-btn").css("opacity", "1").prop('disabled', false);
			    } else {
		            $(".update-pass-btn").css("opacity", "0.4").prop('disabled', true);
			    }
			});

		})
	</script>
</body>
</html>