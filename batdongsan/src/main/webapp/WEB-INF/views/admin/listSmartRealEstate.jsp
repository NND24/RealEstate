<%@page import="java.time.ZoneId"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="batdongsan.models.HCMRealEstateModel"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ page pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Website số 1 về bất động sản</title>
<link rel="stylesheet" href="../css/client/index.css" type="text/css">
<link rel="stylesheet" href="../css/admin/headerAdmin.css"
	type="text/css">
<link rel="stylesheet" href="../css/admin/listPost.css?version=57"
	type="text/css">
<%@ include file="../../../links/links.jsp"%>
</head>
<body>
	<%@ include file="../../components/headerAdmin.jsp"%>
	<div class='admin'>
		<%@ include file="../../components/sidebarAdmin.jsp"%>

		<!-- ListPost -->
		<div class='admin-list-post'>
			<h1>Danh sách bất động sản</h1>
			<div class='content-container'>
				<div class='filter-wrapper'>
					<div class='search-input'>
						<input type='text' id="searchInput"
							placeholder='Tìm theo nội dung, tiêu đề' /> 
					</div>
					<div style="display: flex; align-items: center; gap: 10px;">
					    <input type="number" id="threshold" placeholder="Số lượng tương tác" class="search-interest"
					        style="padding: 8px 12px; font-size: 16px; border: 1px solid #ccc; border-radius: 4px; width: 200px;">
					     <i
							class='fa-solid fa-magnifying-glass'></i>
					</div>
					<div class="dropdown-wrapper" style="display: flex; align-items: center;">
					    <select id="categoryDropdown" name="categoryId" class="form-control"
					            style="padding: 8px 12px; font-size: 16px; border: 1px solid #ccc; border-radius: 4px; width: 220px;">
					            <option value="" disabled selected>Chọn một danh mục</option>
					        <c:forEach var="c" items="${categories}">
					            <option value="${c.categoryId}">${c.name}</option>
					        </c:forEach>
					    </select>
					</div>
					<div style="margin-left: auto; width: fit-content;">
					    <button style="background-color: #67B7D1; color: white; padding: 10px 20px; border: none; border-radius: 5px; font-size: 16px; cursor: pointer;" class="download">
					        Xuất csv
					    </button>
					</div>


				</div>
				<%
				List<HCMRealEstateModel> allRealEstates = (List<HCMRealEstateModel>) request.getAttribute("allRealEstates");
				Integer currentAllPage = (Integer) request.getAttribute("currentAllPage");
				Integer totalAllPages = (Integer) request.getAttribute("totalAllPages");
				Integer totalAllResults = (Integer) request.getAttribute("totalAllResults");
				%>
				<div class='post-container'>
					<div class='tab-content'>
						<%
						if (allRealEstates != null) {
							for (HCMRealEstateModel r : allRealEstates) {
								String imageString = (String) r.getImages();

								if (imageString != null && !imageString.isEmpty()) {
							imageString = imageString.substring(1, imageString.length() - 1);
							String[] imagePaths = imageString.split(",");

							LocalDate ngayHienTai = LocalDate.now();
							java.util.Date submittedDate = r.getSubmittedDate();
							java.util.Date expirationDate = r.getExpirationDate();
							LocalDate ngay2 = null;
							if (expirationDate != null) {
								// Convert java.sql.Date to java.util.Date
								java.util.Date utilExpirationDate = new java.util.Date(expirationDate.getTime());
								ngay2 = utilExpirationDate.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
							}

							// Calculate the difference in days
							long khoangCach = ChronoUnit.DAYS.between(ngayHienTai, ngay2);

							SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
							String submittedDateString = dateFormat.format(submittedDate);
							String expirationDateString = dateFormat.format(expirationDate);
						%>
						<div class='admin-post-card'>
							<div>
								<img
									src="${pageContext.servletContext.contextPath}/images/<%= imagePaths[0] %>"
									alt='' />
								<div class='post-content-container'>
									<div>
										<h4 class='title'><%=r.getTitle()%></h4>
										<div class='location'>
											<span><%=r.getCategory().getName()%></span> <span> ·
											</span> <span><%=r.getAddress()%></span>
										</div>
									</div>
									<div class='button-container'>
									<div class='button-item'>
									<span style="font-size: 16px; font-weight: bold; color: #333;">Số lượng tương tác:</span>
							        <span id="interactionCount" style="font-size: 16px; font-weight: bold; color: #4CAF50;"><%=r.getInterestedClick()%></span>
									</div>
									
								</div>
								</div>
								
							</div>
						</div>
						<%
						}
						}
						}
						%>

						<!-- Phân trang -->
						<div class="pagination">
							<%
							if (currentAllPage > 1) {
							%>
							<a
								href="${pageContext.servletContext.contextPath}/admin/quan-ly-bat-dong-san.html?pageAll=<%=currentAllPage - 1%>">
								<i class="fa-solid fa-chevron-left"></i>
							</a>
							<%
							}
							%>

							<%
							for (int i = 1; i <= totalAllPages; i++) {
							%>
							<a
								href="${pageContext.servletContext.contextPath}/admin/quan-ly-bat-dong-san.html?pageAll=<%=i%>"
								class="<%=i == currentAllPage ? "active" : ""%>"><%=i%></a>
							<%
							}
							%>

							<%
							if (currentAllPage < totalAllPages) {
							%>
							<a
								href="${pageContext.servletContext.contextPath}/admin/quan-ly-bat-dong-san.html?pageAll=<%=currentAllPage + 1%>">
								<i class="fa-solid fa-angle-right"></i>
							</a>
							<%
							}
							%>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
	$(document).ready(function() {
		let searchInput = $(".search-input input");
		let searchInterest = $(".search-interest")
		let searchInputButton = $(".fa-magnifying-glass");
		let downloadButton = $(".download")
		let categoryDropdown = $("#categoryDropdown");

		
		$(downloadButton).on("click", handleDownload)
		
		$(document).on("change", "#categoryDropdown", function() {
	        console.log("Dropdown changed:", categoryDropdown.val()); // Debugging
	        handleSearch();
	    });
		$(searchInputButton).on("click", handleSearch);
		$(searchInput).on("keyup", function(event) {
		    if (event.which === 13) { // Enter key code
		        event.preventDefault(); // Prevent default form submission if necessary
		        handleSearch();
		    }
		});
		$(searchInterest).on("keyup", function(event) {
		    if (event.which === 13) { // Enter key code
		        event.preventDefault(); // Prevent default form submission if necessary
		        handleSearch();
		    }
		});
		
		function handleSearch() {
			let url = "${pageContext.servletContext.contextPath}/admin/thong-minh.html";
			url += "?searchInput=" + searchInput.val();
			url += "&interest=" + searchInterest.val();
			if (categoryDropdown.val()) {
                url += "&categoryId=" + encodeURIComponent(categoryDropdown.val());
            }
			window.location.href = url;
		}
		
		function handleDownload() {
		    // Get the current URL and create a URL object for easy manipulation
		    let currentUrl = new URL(window.location.href);
		    
		    // Extract searchInput, interest, and categoryId from the current URL parameters (if available)
		    let searchInputParam = currentUrl.searchParams.get("searchInput") || searchInput.val();
		    let interestParam = currentUrl.searchParams.get("interest") || searchInterest.val();
		    let categoryIdParam = currentUrl.searchParams.get("categoryId") || categoryDropdown.val();

		    // Construct the download URL using extracted parameters
		    let url = "${pageContext.servletContext.contextPath}/admin/thong-minh/download.html";
		    url += "?searchInput=" + encodeURIComponent(searchInputParam);
		    url += "&interest=" + encodeURIComponent(interestParam);
		    if (categoryIdParam) {
		        url += "&categoryId=" + encodeURIComponent(categoryIdParam);
		    }

		    // Perform AJAX request to download the file without opening a new tab
		    $.ajax({
		        url: url,
		        type: "GET",
		        xhrFields: {
		            responseType: 'blob' // Set response type as blob to handle binary data
		        },
		        success: function(data, status, xhr) {
		            // Create a Blob object from the data and generate a download link
		            let blob = new Blob([data], { type: 'text/csv' });
		            let downloadUrl = window.URL.createObjectURL(blob);

		            // Create a temporary anchor element
		            let a = document.createElement("a");
		            a.href = downloadUrl;
		            a.download = "realestate_data.csv"; // Set the file name
		            document.body.appendChild(a);
		            a.click(); // Trigger the download
		            document.body.removeChild(a); // Remove anchor after download

		            // Revoke the object URL to free up memory
		            window.URL.revokeObjectURL(downloadUrl);
		        },
		        error: function(xhr, status, error) {
		            console.error("Error downloading file:", status, error);
		        }
		    });
		}

	})
	</script>
</body>
</html>