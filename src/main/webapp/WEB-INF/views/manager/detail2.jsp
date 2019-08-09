<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../include/header.jsp"/>
<section>
<jsp:include page="../include/sidebar.jsp"/>
<div class="product_image_area">
		<div class="container">
			<div class="row s_product_inner">
				<div class="col-lg-6">
					<div class="owl-carousel owl-theme s_Product_carousel">
						<div class="single-prd-item">
							<c:forEach var="file" items="${ product.files }">
								<img class="img-fluid" src="/shop/resources/files/product-files/${ file.fileName }" alt="">
							</c:forEach>
						</div>
						<!-- <div class="single-prd-item">
							<img class="img-fluid" src="/shop/resources/img/category/s-p1.jpg" alt="">
						</div>
						<div class="single-prd-item">
							<img class="img-fluid" src="/shop/resources/img/category/s-p1.jpg" alt="">
						</div> -->
					</div>
				</div>
				<div class="col-lg-5 offset-lg-1" id="detail_box">			
					<div class="s_product_text">
						<form id="updateForm" action="/shop/cart" method="post">
							<input hidden="true" name="productNo" value="${ product.productNo }">
							<input hidden="true" name="price" value="${ product.price }">
							<input hidden="true" id="result" name="result" value="0">
							<h3>${ product.title }</h3>
							<h2><fmt:formatNumber pattern="#,###￦">${ product.price }</fmt:formatNumber></h2>
							<ul class="list">
								<li><a class="active" href="#"><span>Category</span> : ${ product.category }</a></li>
							</ul>
							<%-- 줄바꿈 문자열을 저장하고 있는 변수 만들기 --%>	
<c:set var="enter" value="
" />
							<p>${ fn:replace(product.content, enter, '<br>') }</p>
							
							<c:set var="colors" value="${ fn:split(product.color, ',') }"/>
							<c:set var="sizes" value="${ fn:split(product.size, ',') }"/>
							<c:set var="productNames" value="${ fn:split(product.productName, ',') }"/>
							
							<div class="product_count w-100">
	              				<div class="row py-1">
	              					<label class="col-3" for="sst">재고 : </label>
									
									<input type="text" name="count" id="sst0" size="2" maxlength="12" value="${ product.count }" class="input-text qty">
		              				
								</div>
								<c:if test="${ product.color ne '' && product.color ne null }">
								<div class="row py-1">
									<label class="col-3 optLabel" for="color">색상	: </label>
									<select name="color" required="required">
										<option>색상선택</option>
										<c:forEach var="color" items="${ colors }">
											<option>${ color }</option>
										</c:forEach>
									</select>
								</div>
								</c:if>
								<c:if test="${ product.size ne '' && product.size ne null }">
								<div class="row py-1">
									<label class="col-3 optLabel" for="size">사이즈	: </label>
									<select name="size" required="required">
										<option>크기선택</option>
										<c:forEach var="size" items="${ sizes }">
											<option>${ size }</option>
										</c:forEach>
									</select>
								</div>
								</c:if>
								<c:if test="${ product.productName ne '' && product.productName ne null }">
								<div class="row py-1">
									<label class="col-3 optLabel" for="productName">상품명	: </label>
									<select name="productName" required="required">
										<option>상품선택</option>
										<c:forEach var="productName" items="${ productNames }">
											<option>${ productName }</option>
										</c:forEach>
									</select>
								</div>
								</c:if>
								<div class="row text-center">
									<a class="button primary-btn col-5 m-3" href="/shop/manager/update-product/${ product.productNo }">수정</a>  
									<a class="button button-header col-5 m-3" href="/shop/manager/delete-product/${ product.productNo }">삭제</a>
								</div>
							</div>
						</form>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart);

      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Month', 'Sales', 'Expenses'],
          ['08',  1000,      400],
          ['2005',  1170,      460],
          ['2006',  660,       1120],
          ['2007',  1030,      540]
        ]);

        var options = {
          title: 'Company Performance',
          curveType: 'function',
          legend: { position: 'bottom' }
        };

        var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));

        chart.draw(data, options);
      }
    </script>
    <div id="curve_chart" style="width: 900px; height: 500px"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<jsp:include page="../include/footer.jsp"/>