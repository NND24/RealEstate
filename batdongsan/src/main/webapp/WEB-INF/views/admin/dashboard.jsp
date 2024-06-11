<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Trang chủ</title>
<link rel="stylesheet" href="../css/client/index.css" type="text/css">
<link rel="stylesheet" href="../css/admin/headerAdmin.css?version=55"
	type="text/css">
<link rel="stylesheet" href="../css/admin/dashboard.css?version=56"
	type="text/css">
<%@ include file="../../../../links/links.jsp"%>
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
	google.charts.load('current', {
		'packages' : [ 'corechart' ]
	});
	google.charts.setOnLoadCallback(drawCharts);

	function drawCharts() {
		drawPostsChart();
		drawMoneyChart();
	}

	function drawPostsChart() {
		var data = new google.visualization.DataTable();
		data.addColumn('string', 'Tháng-Năm');
		data.addColumn('number', 'Số Bài Viết');

		var postsChartData = JSON.parse(document
				.getElementById('posts-chart-data').textContent);

		var rows = [];
		for (var i = 0; i < postsChartData.length; i++) {
			var item = postsChartData[i];
			rows.push([ item.year + '-' + item.month, item.count ]);
		}
		data.addRows(rows);

		var options = {
			title : 'Tổng Số Bài Viết Trong Các Tháng Gần Đây',
			hAxis : {
				title : 'Tháng-Năm'
			},
			vAxis : {
				title : 'Số Bài Viết'
			},
			legend : {
				position : 'none'
			},
			colors : [ '#1c91c0' ]
		// Màu xanh biển
		};

		var chart = new google.visualization.ColumnChart(document
				.getElementById('posts_chart_div'));
		chart.draw(data, options);
	}

	function drawMoneyChart() {
		var data = new google.visualization.DataTable();
		data.addColumn('string', 'Tháng-Năm');
		data.addColumn('number', 'Số Tiền');

		var moneyChartData = JSON.parse(document
				.getElementById('money-chart-data').textContent);

		var rows = [];
		for (var i = 0; i < moneyChartData.length; i++) {
			var item = moneyChartData[i];
			rows.push([ item.year + '-' + item.month, item.amount ]);
		}
		data.addRows(rows);

		var options = {
			title : 'Tổng Số Tiền Trong Các Tháng Gần Đây',
			hAxis : {
				title : 'Tháng-Năm'
			},
			vAxis : {
				title : 'Số Tiền'
			},
			legend : {
				position : 'none'
			},
			colors : [ '#109618' ]
		// Màu xanh lá cây
		};

		var chart = new google.visualization.ColumnChart(document
				.getElementById('money_chart_div'));
		chart.draw(data, options);
	}
</script>
</head>
<body>
	<%@ include file="../../components/headerAdmin.jsp"%>
	<div class='admin'>
		<%@ include file="../../components/sidebarAdmin.jsp"%>
		<!-- Dashboard -->
		<div class='dashboard'>
			<div class='header-wrapper'>
				<h3>Bảng thống kê</h3>
			</div>

			<div class="row">
				<div class="col-md-3">
					<div class="card card-sales">
						<h3>Tổng doanh thu</h3>
						<p>${totalRevenue} VNĐ</p>
					</div>
				</div>
				<div class="col-md-3">
					<div class="card card-users">
						<h3>Số người dùng</h3>
						<p>${totalUsers}</p>
					</div>
				</div>
				<div class="col-md-3">
					<div class="card card-posts">
						<h3>Số bài đăng</h3>
						<p>${totalPosts}</p>
					</div>
				</div>
				<div class="col-md-3">
					<div class="card card-articles">
						<h3>Số bài viết</h3>
						<p>${totalArticles}</p>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-md-5 offset-md-1">
					<div id="posts_chart_div" style="width: 100%; height: 500px;"></div>
				</div>
				<div class="col-md-5">
					<div id="money_chart_div" style="width: 100%; height: 500px;"></div>
				</div>
			</div>

		</div>
	</div>
	<script type="application/json" id="posts-chart-data">
        ${postsChartData}
    </script>
	<script type="application/json" id="money-chart-data">
        ${moneyChartData}
    </script>
</body>
</html>