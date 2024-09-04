<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>House Price Prediction</title>
</head>
<body>
    <h1>Predict House Price</h1>
    <form id="houseForm" onsubmit="event.preventDefault(); predictPrice();">
        <label for="area">Area (m²):</label>
        <input type="number" id="area" name="area" required><br>
        <label for="bedroom">Number of Bedrooms:</label>
        <input type="number" id="bedroom" name="bedroom" required><br>
        <label for="toilet">Number of Toilets:</label>
        <input type="number" id="toilet" name="toilet" required><br>
        <label for="district">District:</label>
        <input type="text" id="district" name="district" required><br>
        <label for="province">Province:</label>
        <input type="text" id="province" name="province" required><br>
        <button type="submit">Predict Price</button>
    </form>
    <h2 id="result"></h2>
    <script>
        async function predictPrice() {
            const area = document.getElementById('area').value;
            const bedroom = document.getElementById('bedroom').value;
            const toilet = document.getElementById('toilet').value;
            const district = document.getElementById('district').value;
            const province = document.getElementById('province').value;

            const data = {
                area: parseFloat(area),
                bedroom: parseInt(bedroom),
                toilet: parseInt(toilet),
                district: district,
                province: province
            };

            try {
                const response = await fetch('http://localhost:5000/predict', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(data)
                });

                const result = await response.json();
                document.getElementById('result').innerText = `Predicted Price: ` + result.predicted_price;
            } catch (error) {
                console.error('Error predicting price:', error);
                document.getElementById('result').innerText = 'Error predicting price.';
            }
        }
    </script>
</body>
</html>
