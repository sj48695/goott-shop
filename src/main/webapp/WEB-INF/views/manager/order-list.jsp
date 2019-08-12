<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../include/header.jsp"/>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawVisualization);

      function drawVisualization() {
        // Some raw data (not necessarily accurate)
        var data = google.visualization.arrayToDataTable([
          ['제품', '주문량'],
          <c:forEach var="order" items="${ order }" varStatus="status">
           ['${ order.title }', ${ order.cnt }],
          </c:forEach>
          ]);
		
        var options = {
          title : '제품별 구매현황',
          vAxis: {title: '구매'},
          hAxis: {title: '제품'},
          seriesType: 'bars',
          series: {5: {type: 'line'}}
        };

        var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
        chart.draw(data, options);
      }
    </script>
<section>
<jsp:include page="../include/sidebar.jsp"/>
	<div class="container py-5">
		<div id="chart_div" style="width: 1000px; height: 500px;"></div>
	</div>
</section>
<jsp:include page="../include/footer.jsp"/>