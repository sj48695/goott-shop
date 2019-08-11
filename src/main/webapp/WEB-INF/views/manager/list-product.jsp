<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<c:set var="nav" value="meneger" scope="request"/>
<c:set var="title" value="Aroma Shop - ManageMent" scope="request"/>
<jsp:include page="../include/header.jsp"/>
<section>
<jsp:include page="../include/sidebar.jsp"/>
<div id="content">
	<form class="form-inline py-3" action="/shop/manager/list-product" method="get">
			<select name="category" class="form-control" id="category_form">
				<option value="전체" <c:if test="${param.category eq '전체'}">selected</c:if>>전체</option>
				<option value="가구" <c:if test="${param.category eq '가구'}">selected</c:if>>가구</option>
                <option value="가전" <c:if test="${param.category eq '가전'}">selected</c:if>>가전</option>
                <option value="그릇/홈세트" <c:if test="${param.category eq '그릇/홈세트'}">selected</c:if>>그릇/홈세트</option>
                <option value="주방" <c:if test="${param.category eq '주방'}">selected</c:if>>주방</option>
                <option value="홈데코" <c:if test="${param.category eq '홈데코'}">selected</c:if>>홈데코</option>
	      	</select>
	      	<div class="offset-7">
				<input type="text" class="form-control" name="keyword" value="${ param.keyword }"> 
				<input type="submit" class="btn btn-dark" value="검색">
			</div>
	</form>
	
	<table class="table table-hover">
	  <thead>
	    <tr>
	      <th scope="col">번호</th>
	      <th scope="col"></th>
	      <th scope="col">상품타이틀</th>
	      <th scope="col">가격</th>
	      <th scope="col">재고</th>
	      <th scope="col">등록일자</th>
	    </tr>
	  </thead>
	  <tbody>
	  	<c:set var="num" value="${ allCount }"/>
	  	<c:forEach var="product" items="${ products }" varStatus="status">
	    	<tr>
		      <th scope="row">${ num }</th>
			      <td><img src="/shop/resources/files/product-files/${ product.file.fileName }" style="width: 50px; padding-right:10px"></td>
			      		<td><a href="/shop/manager/detail/${ product.productNo }">${ product.title }</a></td>
			      <td><fmt:formatNumber value="${ product.price }" pattern="#,###" />원</td>
			      <td>${ product.count }</td>
			      <td><fmt:formatDate value="${ product.regDate }" pattern="YYYY-MM-dd" /></td>
		    </tr>
	  	<c:set var="num" value="${ num - 1 }"/>
	    </c:forEach>
	  </tbody>
	</table>
</div>
</section>
<jsp:include page="../include/footer.jsp"/>