<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../include/header.jsp"/>
<section>
<jsp:include page="../include/sidebar.jsp"/>
<div id="content">
	<table class="table table-hover">
	  <thead>
	    <tr>
	      <th scope="col">번호</th>
	      <th scope="col">상품타이틀</th>
	      <th scope="col">가격</th>
	      <th scope="col">재고</th>
	    </tr>
	  </thead>
	  <tbody>
	  	<c:forEach var="product" items="${ products }" varStatus="status">
	    	<tr>
		      <th scope="row">${ product.productNo }</th>
		      <td><img src="/shop/resources/files/product-files/${ product.file.fileName }" style="width: 50px; padding-right:10px">${ product.title }</td>
		      <td><fmt:formatNumber value="${ product.price }" pattern="#,###" />원</td>
		      <td>${ product.count }</td>
		    </tr>
	    </c:forEach>
	  </tbody>
	</table>
</div>
</section>
<jsp:include page="../include/footer.jsp"/>