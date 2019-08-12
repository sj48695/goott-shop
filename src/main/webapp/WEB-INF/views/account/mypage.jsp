<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page session="false" language="java" contentType="text/html; charset=utf-8"
	     pageEncoding="utf-8"%>
<c:set var="title" value="Aroma Shop - MyPage" scope="request"/>
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
	<section class="product_description_area container">
		<div>
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
						<h4><strong>내 정보</strong></h4><br>
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
					<h4><strong>장바구니</strong></h4><br>
					<c:if test="${ empty carts }">
					<div class="jumbotron">
						<h5 class="text-center">현재 장바구니에 담긴 상품이 존재하지 않습니다.</h5>
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
										<th scope="col"><input type="checkbox" id="th_checkAll" onclick="checkAll('${rows}')"></th>
										<th scope="col">Product</th>
										<th scope="col">Price</th>
										<th scope="col">Quantity</th>
										<th scope="col">SubTotal</th>
										<th scope="col">delete</th>
									</tr>
								</thead>
								<tbody>
			                      <c:forEach var="cart" items="${ carts }">
			                          <tr class="cartlist${ cart.cartNo }">
			                          	  <td class="px-4"><input type="checkbox" name="checkRow" value="${ cart.cartNo }" onclick="checkRow()"></td>
			                              <td class="px-4">
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
			                              <td class="px-3">
			                                  <h5><fmt:formatNumber pattern="#,###원">${ cart.price }</fmt:formatNumber></h5>
			                              </td>
			                              <td class="px-3">
			                                  <div class="product_count">
			                                      <input type="text" name="qty" id="sst${ cart.cartNo }" maxlength="12" value="${ cart.count }" title="Quantity:"
			                                          class="input-text qty">
			                                      <button class="increase items-count" type="button" onclick="increase(${ cart.cartNo }, ${ cart.price })"><i class="ti-angle-up"></i></button>
			                                      <button class="reduced items-count" type="button" onclick="reduced(${ cart.cartNo },  ${ cart.price })"><i class="ti-angle-down"></i></button>
			                                  </div>
			                              </td>
			                              <td class="px-3">
			                              	  <input hidden="true" id="total_before${ cart.cartNo }" value="${ cart.price * cart.count }">
			                                  <h5 class="total${ cart.cartNo }">
			                                  	<fmt:formatNumber pattern="#,###원">${ cart.price * cart.count }</fmt:formatNumber>
			                                  	<c:set var="total" value="${ total + (cart.price * cart.count) }"/>
			                                  </h5>
			                              </td>
			                              <td class="text-center px-3"><a onclick="javascript:removeCart(${ cart.cartNo })">X</a></td>
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
			      	</c:if>
				</div>
				
				<div class="tab-pane fade" id="order" role="tabpanel" aria-labelledby="order-tab">
					<h4><strong>주문내역</strong></h4><br>
					<c:if test="${ empty buyList }">
					<div class="jumbotron">
						<h5 class="text-center">현재 주문내역이 존재하지 않습니다.</h5>
					</div>
					</c:if>
					<c:if test="${ not empty buyList }">
					<div class="table-responsive">
						<table class="table">
							<colgroup>
								<col width="*">
								<col width="10%">
								<col width="15%">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">Product</th>
									<th scope="col" class="text-center">Quantity</th>
									<th scope="col" class="text-center">SubTotal</th>
								</tr>
							</thead>
							<tbody>
								<c:set var="total" value="0"/>
								<c:forEach var="buy" items="${ buyList }">
									<tr>
										<td class="px-4">
											<a class="row" href="/shop/single-product/${ buy.productNo }">
												<div class="col-2">
												<img src="/shop/resources/files/product-files/${ buy.file.fileName }" width="100">
												</div>
												<div class="col-10 py-4">
													<p class="mb-0">${ buy.title }</p>
													<p class="mb-0">- ${ buy.productName }(${ buy.color }/${ buy.size })</p>
												</div>
											</a>
										</td>
										<td class="text-center px-4">
											<h5>${ buy.count }</h5>
										</td>
										<td class="text-center px-4">
											<p><fmt:formatNumber pattern="#,###원">${ buy.count * buy.price }</fmt:formatNumber></p>
										</td>
									</tr>									
		                            <c:set var="total" value="${ total + (buy.price * buy.count) }"/>
								</c:forEach>
								<tr><td colspan="3"/></tr>
								<tr>
									<td></td>
									<td class="px-4">
										<h5>Total</h5>
									</td>
									<td class="px-4">
										<h5 class="subtotal">
											<fmt:formatNumber pattern="#,###원">${ total }</fmt:formatNumber>
										</h5>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					</c:if>
				</div>
				
				<div class="tab-pane fade" id="qna" role="tabpanel" aria-labelledby="qna-tab">
					<h4><strong>QnA</strong></h4><br>
					<c:if test="${ empty questions }">
					<div class="jumbotron">
						<h5 class="text-center">현재 작성된 QnA가 존재하지 않습니다.</h5>
					</div>
					</c:if>
					<c:if test="${ not empty questions }">
						<table class="table table-hover">	
							<colgroup>
								<col width="5%">
								<col width="15%">
								<col width="50%">
								<col width="18%">
								<col width="10%">
							</colgroup>					
							<tr>
								<th scope="col">NO</th>
								<th scope="col" class="text-center">CATEGORY</th>
								<th scope="col">CONTENTS</th>
								<th scope="col" class="text-center">DATE</th>
								<th scope="col" class="text-center">ANSWER</th>
							</tr>						
							<c:forEach var="question" items="${questions}">
								<tr>
									<td class="text-center px-3">${ question.questionNo }</td>
									<td class="text-center px-4">${ question.category }</td>
									<td class="text-left px-4">
									<a	href=<c:if test='${ question.secure eq true}'>
									"/../shop/pwCheck/${ question.questionNo }" 
									</c:if>
									<c:if test='${ question.secure eq false}'>
									 "/../shop/qa-detail/${ question.questionNo }" 
									</c:if>>
									${ question.title }</a>
									<c:if test='${ question.secure eq true }'>
									<i class="fa fa-lock"></i>
									</c:if>
									
									&nbsp;&nbsp;[${ question.recnt }]
									</td>
									<td class="text-center px-2">${ question.regDate }</td>
									<td class="text-center px-2">${ question.answer ? "답변완료" : "답변대기" }
								</tr>
							</c:forEach>
						</table>
					</c:if>
				</div>
				
			</div><!-- tab-content -->
	
		</div>
	</section>
	
  <!--================End Order Details Area =================-->

 <jsp:include page="../include/footer.jsp"/>