<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="include/header.jsp"/>  
	<!-- ================ start banner area ================= -->	
	<section class="blog-banner-area" id="category">
		<div class="container h-100">
			<div class="blog-banner">
				<div class="text-center">
					<h1>Order Confirmation</h1>
					<nav aria-label="breadcrumb" class="banner-breadcrumb">
            <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active" aria-current="page">Shop Category</li>
            </ol>
          </nav>
				</div>
			</div>
    </div>
	</section>
	<!-- ================ end banner area ================= -->
  
  <!--================Order Details Area =================-->
<section class="order_details section-margin--small">
	<div class="container">
		<p class="text-center billing-alert">Thank you. Your order has been received.</p>
		<div class="order_details_table">
			<h2>Order Details</h2>
			<div class="table-responsive">
				<table class="table">
					<thead>
						<tr>
							<th scope="col">Product</th>
							<th scope="col">Quantity</th>
							<th scope="col">SubTotal</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="buy" items="${ buyList }">
							<tr>
								<td>
									<p>${ buy.title }</p>
									<p>- ${ buy.productName }(${ buy.color }/${ buy.size })</p>
								</td>
								<td>
									<h5>${ buy.count }</h5>
								</td>
								<td>
									<p><fmt:formatNumber pattern="#,###원">${ buy.count * buy.price }</fmt:formatNumber></p>
								</td>
							</tr>
							
                                  	<c:set var="total" value="${ total + (buy.price * buy.count) }"/>
						</c:forEach>
						<tr><td colspan="3"/></tr>
						<tr>
							<td></td>
							<td>
								<h5>Total</h5>
							</td>
							<td>
								<h5 class="subtotal">
									<fmt:formatNumber pattern="#,###원">${ total }</fmt:formatNumber>
								</h5>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</section>
<!--================End Order Details Area =================-->
<jsp:include page="include/footer.jsp"/>