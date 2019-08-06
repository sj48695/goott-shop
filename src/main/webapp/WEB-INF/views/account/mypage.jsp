<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page session="false" language="java" contentType="text/html; charset=utf-8"
	     pageEncoding="utf-8"%>

<jsp:include page="../include/header.jsp"/>  
	<!-- ================ start banner area ================= -->	
	<section class="blog-banner-area" id="category">
		<div class="container h-100">
			<div class="blog-banner">
				<div class="text-center">
					<h1>마이페이지</h1>
				</div>
			</div>
    </div>
	</section>
	<!-- ================ end banner area ================= -->
  
  <!--================Order Details Area =================--> 
	<section class="product_description_area">
		<div style="width:70%; margin-left:275px">
			<ul class="nav nav-tabs" id="myTab" role="tablist"> 
				<li class="nav-item">
		          <a class="nav-link active" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="flase">내정보</a>
				</li>
				<li class="nav-item">
		          <a class="nav-link" id="cart-tab" data-toggle="tab" href="#cart" role="tab" aria-controls="cart" aria-selected="false">장바구니</a>
				</li>
				<li class="nav-item">
		          <a class="nav-link" id="order-tab" data-toggle="tab" href="#order" role="tab" aria-controls="order" aria-selected="false">주문내역</a>
				</li>
				<li class="nav-item">
		          <a class="nav-link" id="qna-tab" data-toggle="tab" href="#qna" role="tab" aria-controls="qna" aria-selected="false">QnA</a>
				</li>
		    </ul> 

			<div class="tab-content" id="myTabContent" style="width:100%">
			
				<div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
					<div class="col-lg-12">
						<h4><strong>내 정보</strong></h4>
						<form class="form-contact form-review mt-3">
							<table class="table">
								<tr>
									<th>아이디</th>
									<td>${ member.memberId }</td>
								</tr>
								<tr>
									<th>이름</th>
									<td>${ member.name }</td>
								</tr>
								<tr>
									<th>휴대폰 번호</th>
									<td>${ member.phone }</td>
								</tr>
								<tr>
									<th>우편번호</th>
									<td>${ member.postCode }</td>
								</tr>
								<tr>
									<th>도로명주소</th>
									<td>${ member.roadAddr }</td>
								</tr>
								<tr>
									<th>지번주소</th>
									<td>${ member.jibunAddr }</td>
								</tr>
								<tr>
									<th>상세주소</th>
									<td>${ member.detailAddr }</td>
								</tr>
								<tr>
									<th>참고사항</th>
									<td>${ member.extraAddr }</td>
								</tr>							
							</table>
							<div class="form-group text-center text-md-right mt-3">
								<input type="button" value="수정" id="update_button" class="button button--active button-review">
							</div>
							<script type="text/javascript">
							window.addEventListener('load', function(event) {	
								var btnUpdate = document.querySelector('#update_button');
					       		btnUpdate.addEventListener('click', function(event) {
					       			location.href = "/shop/account/update";
					       		});
							});
							</script>
						</form>
					</div>
				</div>
				
				<div class="tab-pane fade" id="cart" role="tabpanel" aria-labelledby="cart-tab">
					<h4><strong>장바구니</strong></h4>
					<c:if test="${ empty carts }">
					<div class="jumbotron">
						<h5 style="text-align: center">현재 장바구니에 담긴 상품이 존재하지 않습니다.</h5>
					</div>
					</c:if>
					
					<c:if test="${ not empty carts }">
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
										<th scope="col"><input type="checkbox" id="th_checkAll" onclick="checkAll()"></th>
										<th scope="col">Product</th>
										<th scope="col">Price</th>
										<th scope="col">Quantity</th>
										<th scope="col">Total</th>
										<th scope="col">delete</th>
									</tr>
								</thead>
								<tbody>
			                      <c:forEach var="cart" items="${ carts }">
			                          <tr class="cartlist${ cart.cartNo }">
			                          	  <td><input type="checkbox" name="checkRow"></td>
			                              <td>
			                                  <div class="media">
			                                      <div class="d-flex">
			                                          <img src="/shop/resources/img/cart/cart1.png" alt="">
			                                      </div>
			                                      <div class="media-body">
			                                          <p>${ cart.productName }</p>
			                                      </div>
			                                  </div>
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
			                                  	<c:set var="subtotal" value="${ subtotal + (cart.price * cart.count) }"/>
			                                  </h5>
			                              </td>
			                              <td><a onclick="javascript:removeCart(${ cart.cartNo })">X</a></td>
			                          </tr>
			                        </c:forEach>
			                          <tr>
			                          	  <td colspan="3"></td>
			                              <td>
			                                  <h4>Subtotal</h4>
			                              </td>
			                              <td>
			                                  <input hidden="true" id="subtotal_before" value="${ subtotal }">
			                                  <h5 class="subtotal">
			                                  	<fmt:formatNumber pattern="#,###원">${ subtotal }</fmt:formatNumber>
			                                  </h5>
			                              </td>
			                              <td></td>
			                          </tr>
			                          <tr class="out_button_area">
			                              <td colspan="6">
			                                  <div class="checkout_btn_inner d-flex align-items-center ml-0 row justify-content-end">
			                                      <button class="gray_btn" onclick="history.go(-1);">Continue Shopping</button>
			                                      <a class="primary-btn ml-2" href="/shop/checkout">Proceed to checkout</a>
			                                  </div>
			                              </td>
			                          </tr>
			                      </tbody>
			                  </table>
			            	</div>
			        	</div>
			      	</c:if>
				</div>
				
				<div class="tab-pane fade" id="order" role="tabpanel" aria-labelledby="order-tab">
				</div>
				
				<div class="tab-pane fade" id="qna" role="tabpanel" aria-labelledby="qna-tab">
					<h4><strong>QnA</strong></h4>
					<c:if test="${ empty questions }">
					<div class="jumbotron">
						<h5 style="text-align: center">현재 작성된 QnA가 존재하지 않습니다.</h5>
					</div>
					</c:if>
					<c:if test="${ not empty questions }">
						<table class="table">
							<tr>
								<th>NO</th>
								<th>
									<form id="selectform" action="qacategory" method="POST">
										<select name="category" id="qaselectcategory">
											<option value="all">CATEGORY</option>
											<option value="고양이문의"
												<c:if test="${param.category eq '고양이문의'}">selected</c:if>>고양이문의</option>
											<option value="용품문의"
												<c:if test="${param.category eq '용품문의'}">selected</c:if>>용품문의</option>
											<option value="기타문의"
												<c:if test="${param.category eq '기타문의'}">selected</c:if>>기타문의</option>
										</select>
									</form>
								</th>
								<th style="width: 400px; text-align: center">CONTENTS</th>
								<th style="width: 125px; text-align: center">NAME</th>
								<th style="width: 150px; text-align: center;">DATE</th>
								<th style="width: 125px; text-align: center">ANSWER</th>
							</tr>
							<c:forEach var="question" items="${questions}">
								<tr>
									<td style="text-align: center">${ question.questionNo }</td>
									<td style="text-align: center">${ question.category }</td>
									<td style='text-align: left; padding-left: 10px'>
									<a href="/catopia/qa-upload/qa-detail/${ question.questionNo }"> ${ question.title }</a>&nbsp;&nbsp;[${ question.recnt }]</td>
									<td style="text-align: center">${ question.uploader }</td>
									<td style="text-align: center">${ question.regDate }</td>
									<td style="text-align: center">${ question.answer ? "답변완료" : "답변대기" }
								</tr>
							</c:forEach>
						</table>
					</c:if>
				</div>
				
			</div>
	
		</div>
	</section>
	
  <!--================End Order Details Area =================-->

 <jsp:include page="../include/footer.jsp"/>