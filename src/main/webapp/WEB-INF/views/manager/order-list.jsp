<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
	google.charts.load('current', {'packages':['corechart']});
	
	google.charts.setOnLoadCallback(drawOrder);

	function drawOrder() {
		var data = google.visualization.arrayToDataTable([
	         ['Element', 'Density', { role: 'style' }],
	         ['Copper', 8.94, '#b87333'],            // RGB value
	         ['Silver', 10.49, 'silver'],            // English color name
	         ['Gold', 19.30, 'gold'],

	       ['Platinum', 21.45, 'color: #e5e4e2' ], // CSS-style declaration
	      ]);
	}

</script>
</head>
<body>

</body>
</html>