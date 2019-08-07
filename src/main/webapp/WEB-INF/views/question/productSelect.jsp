
<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>






<div
	class="xans-element- xans-search xans-search-frompackage ec-base-layer ">

	<div class="content">
		<form id="searchForm" name="" method="get" 
		target="_self" enctype="multipart/form-data">
				<fieldset class="ec-base-box">
					<legend>상품검색</legend>
					<select>
						<option value="product_name">상품명</option>
					</select> 
					<input type="text">
					<input type="submit" value="검색하기">
				</fieldset>
			
		</form>
		<div class="ec-base-table typeList">
			<table border="1">
				<%-- <caption>제품 검색결과입니다</caption> --%>
				<colgroup>
					<col style="width: 100px">
					<col style="width: auto">
					<col style="width: 80px">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">상품 이미지</th>
						<th scope="col">상품 정보</th>
						<th scope="col">선택</th>
					</tr>
				</thead>
				<tbody class="center">
					<c:forEach var="product" items="${ products }" varStatus="status">
						<tr >
							<td style="text-align: center">
								<img src="/shop/resources/files/product-files/${ product.file.fileName }" 
									style="width: 60px; padding-right:10px">
							</td>
							<td>
								${ product.title }
							</td>
							<td style="text-align: center">
								<input type="submit" name="productSelect" id="productSelect" value="선택">
							</td>
						</tr>
						<tr>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>


	</div>
</div>