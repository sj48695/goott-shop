<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="row">
	<c:forEach var="product" items="${ products }">
		<div class="col-md-6 col-lg-4">
			<div class="card text-center card-product">
				<div class="card-product__img">
					<a href="/shop/single-product/${ product.productNo }"> 
						<img class="card-img" src="/shop/resources/files/product-files/${ product.file.fileName }">
					</a>
				</div>
				<div class="card-body">
					<h4 class="card-product__title">
						<a href="/shop/single-product/${ product.productNo }">${ product.title }</a>
					</h4>
					<p class="card-product__price">
						<fmt:formatNumber pattern="#,###￦" value="${ product.price }"/>
					</p>
				</div>
			</div>
		</div>
	</c:forEach>
</div>