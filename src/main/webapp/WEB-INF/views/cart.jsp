<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<c:set var="nav" value="shop" scope="request"/>
<c:set var="title" value="cart" scope="request"/>
<jsp:include page="include/header.jsp"/>

	<!-- ================ start banner area ================= -->	
	<section class="blog-banner-area" id="category">
		<div class="container h-100">
			<div class="blog-banner">
				<div class="text-center">
					<h1>Shopping Cart</h1>
					<nav aria-label="breadcrumb" class="banner-breadcrumb">
            <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="/">Home</a></li>
              <li class="breadcrumb-item active" aria-current="page">Shopping Cart</li>
            </ol>
          </nav>
				</div>
			</div>
    </div>
	</section>
	<!-- ================ end banner area ================= -->
  
  

  <!--================Cart Area =================-->
  <section class="cart_area">
      <div class="container">
          <div class="cart_inner">
              <div class="table-responsive">
                  <table class="table">
					<colgroup>
						<col width="2%">
						<col width="45%">
						<col width="15%">
						<col width="15%">
						<col width="15%">
						<col width="5%">
					</colgroup>
					<thead>
						<tr>
							<th scope="col"><input type="checkbox" id="th_checkAll" onclick="checkAll('${rows}')"></th>
							<th scope="col">Product</th>
							<th scope="col">Price</th>
							<th scope="col">Quantity</th>
							<th scope="col">SubTotal</th>
							<th scope="col">delete</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${ carts eq '[]' }">
						<tr>
							<th colspan="6" class="py-5 text-center">장바구니에 등록된 상품이 없습니다.</th>
						</tr>
						</c:if>
                      <c:forEach var="cart" items="${ carts }">
                          <tr class="cartlist${ cart.cartNo }">
                          	  <td><input type="checkbox" name="checkRow" value="${ cart.cartNo }" onclick="checkRow()"></td>
                              <td>
                              	<a href="/shop/single-product/${ cart.productNo }">
                                  <div class="media">
                                      <div class="d-flex">
                                          <img src="/shop/resources/files/product-files/${ cart.file.fileName }" width="100" alt="">
                                      </div>
                                      <div class="media-body">
                                          <p>${ cart.title }</p>
                                          <p> - ${ cart.productName }(${ cart.color }/${ cart.size })</p>
                                      </div>
                                  </div>
                                  </a>
                              </td>
                              <td>
                                  <h5><fmt:formatNumber pattern="#,###원">${ cart.price }</fmt:formatNumber></h5>
                              </td>
                              <td>
                                  <div class="product_count">
                                      <input type="text" name="qty" id="sst${ cart.cartNo }" maxlength="12" value="${ cart.count }" title="Quantity:"
                                          class="input-text qty">
                                      <button class="increase items-count" type="button" onclick="increase(${ cart.cartNo }, ${ cart.price })"><i class="ti-angle-up"></i></button>
                                      <button class="reduced items-count" type="button" onclick="reduced(${ cart.cartNo },  ${ cart.price })"><i class="ti-angle-down"></i></button>
                                  </div>
                              </td>
                              <td>
                              	  <input hidden="true" id="total_before${ cart.cartNo }" value="${ cart.price * cart.count }">
                                  <h5 class="total${ cart.cartNo }">
                                  	<fmt:formatNumber pattern="#,###원">${ cart.price * cart.count }</fmt:formatNumber>
                                  	<c:set var="total" value="${ total + (cart.price * cart.count) }"/>
                                  </h5>
                              </td>
                              <td><a onclick="javascript:removeCart('${ cart.cartNo }')">X</a></td>
                          </tr>
                        </c:forEach><%-- 
                          <tr>
                          	  <td colspan="3"></td>
                              <td>
                                  <h5>Total</h5>
                              </td>
                              <td>
                                  <input hidden="true" id="subtotal_before" value="${ total }">
                                  <h5 class="subtotal">
                                  	<fmt:formatNumber pattern="#,###원">${ total }</fmt:formatNumber>
                                  </h5>
                              </td>
                              <td></td>
                          </tr> --%>
                          <tr class="out_button_area">
                              <td colspan="6">
                              	<input hidden="true" id="checkRows" name="checkRows">
                                  <div class="checkout_btn_inner d-flex align-items-center ml-0 row justify-content-end">
                                      <a id="delete" class="gray_btn mr-2" onclick="alert('상품을 선택해주세요')">선택 삭제</a>
                                      <a id="continue" class="gray_btn" onclick="history.go(-1);">쇼핑 계속하기</a>
                                      <a id="buy" class="primary-btn ml-2" onclick="alert('상품을 선택해주세요')">구매하기</a>
                                  </div>
                              </td>
                          </tr>
                      </tbody>
                  </table>
              </div>
          </div>
      </div>
  </section>
  <!--================End Cart Area =================-->
<jsp:include page="include/footer.jsp"/>