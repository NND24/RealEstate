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
<link rel="stylesheet" href="../css/admin/modelAI.css?version=16"
	type="text/css">
<%@ include file="../../../../links/links.jsp"%>
</head>
<body>
	<%@ include file="../../components/headerAdmin.jsp"%>
	<div class='admin'>
		<%@ include file="../../components/sidebarAdmin.jsp"%>
		<!-- Dashboard -->
		<div class="train-container">
			<div class="title">Huấn luyện mô hình dự đoán giá bất động sản</div>
			<div class="data-container">
            <div class="row-container">
                <div class="item">
                    <img src="https://www.elkay.vn/wp-content/uploads/2022/03/thiet-ke-kien-truc-3D-nha-o-phong-cach-nhat-ban-1-scaled.jpg" alt="">
                    <div class="thumbnail">Nhà ở</div>
                    <div class="description">Dự đoán giá Nhà ở tại TP HCM</div>
                    <div class="action-container">
                        <button onclick="trainHouseModel()">Huấn luyện</button>
                    </div>   
                </div>

                <div class="item">
                    <img src="https://cdnphoto.dantri.com.vn/dKk4-inv3bpmSaHSZ93v3R9_zto=/zoom/1200_630/2024/11/02/chung-cu-ha-phong-crop-crop-1730537874529.jpeg" alt="">
                    <div class="thumbnail">Chung cư</div>
                    <div class="description">Dự đoán giá Chung cư ở tại TP HCM</div>
                    <div class="action-container">
                        <button onclick="trainApartmentModel()">Huấn luyện</button>
                    </div>   
                </div>
            </div>

            <div class="row-container">
                <div class="item">
                    <img src="https://cms.luatvietnam.vn/uploaded/Images/Original/2020/02/06/quyen-huong-dung-dat-dai_0602162547.jpg" alt="">
                    <div class="thumbnail">Đất</div>
                    <div class="description">Dự đoán giá Đất ở tại TP HCM</div>
                    <div class="action-container">
                        <button onclick="trainLandModel()">Huấn luyện</button>
                    </div>   
                </div>

                <div class="item">
                    <img src="https://i.ex-cdn.com/nhadautu.vn/files/content/2021/07/05/z2592743746286_a0940b3a7839a1034859cb7ec78ea7b9-0949.jpg" alt="">
                    <div class="thumbnail">Mặt bằng</div>
                    <div class="description">Dự đoán giá Mặt bằng ở tại TP HCM</div>
                    <div class="action-container">
                        <button onclick="trainCommercialModel()">Huấn luyện</button>
                    </div>   
                </div>
            </div>   
        </div> 
    	</div>
	</div>
	<script>
        async function trainHouseModel() {
            try {
                const response = await fetch("http://127.0.0.1:5000/trainHousePredictModel", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json"
                    }
                });
        
                if (!response.ok) {
                    throw new Error(`Lỗi: ${response.statusText}`);
                }
        
                const result = await response.json();
                alert("Huấn luyện mô hình dự đoán giá Nhà Ở thành công");
            } catch (error) {
                console.error("Lỗi khi huấn luyện mô hình:", error);
                alert("Đã xảy ra lỗi: " + error.message);
            }
        }

        async function trainApartmentModel() {
            try {
                const response = await fetch("http://127.0.0.1:5000/trainApartmentPredictModel", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json"
                    }
                });
        
                if (!response.ok) {
                    throw new Error(`Lỗi: ${response.statusText}`);
                }
        
                const result = await response.json();
                alert("Huấn luyện mô hình dự đoán giá Chung Cư thành công");
            } catch (error) {
                console.error("Lỗi khi huấn luyện mô hình:", error);
                alert("Đã xảy ra lỗi: " + error.message);
            }
        }

        async function trainLandModel() {
            try {
                const response = await fetch("http://127.0.0.1:5000/trainLandPredictModel", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json"
                    }
                });
        
                if (!response.ok) {
                    throw new Error(`Lỗi: ${response.statusText}`);
                }
        
                const result = await response.json();
                alert("Huấn luyện mô hình dự đoán giá Đất thành công");
            } catch (error) {
                console.error("Lỗi khi huấn luyện mô hình:", error);
                alert("Đã xảy ra lỗi: " + error.message);
            }
        }

        async function trainCommercialModel() {
            try {
                const response = await fetch("http://127.0.0.1:5000/trainCommercialPredictModel", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json"
                    }
                });
        
                if (!response.ok) {
                    throw new Error(`Lỗi: ${response.statusText}`);
                }
        
                const result = await response.json();
                alert("Huấn luyện mô hình dự đoán giá Mặt Bằng thành công");
            } catch (error) {
                console.error("Lỗi khi huấn luyện mô hình:", error);
                alert("Đã xảy ra lỗi: " + error.message);
            }
        }
    </script>
</body>
</html>