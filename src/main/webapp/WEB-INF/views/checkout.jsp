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
				<h1>Product Checkout</h1>
				<nav aria-label="breadcrumb" class="banner-breadcrumb">
           <ol class="breadcrumb">
             <li class="breadcrumb-item"><a href="#">Home</a></li>
             <li class="breadcrumb-item active" aria-current="page">Checkout</li>
           </ol>
         </nav>
			</div>
		</div>
   </div>
</section>
	<!-- ================ end banner area ================= -->
  
  
  <!--================Checkout Area =================-->
<section class="checkout_area section-margin--small">
    <div class="container">
        <div class="billing_details">
			<form class="row contact_form" action="/shop/buy/${ cartNostrs }" method="post" novalidate="novalidate">
                <input hidden="true" name="products" value="${ products }">
                <div class="col-lg-8">
                    <h3>Billing Details</h3>
                    <div class="row">
                      	<div class="col-md-6 form-group p_star">
                            <input type="text" class="form-control" id="name_from"
                            	placeholder="이름" value="${ loginuser.name }" readonly>
                        </div>
                        <div class="col-md-6 form-group p_star">
                            <input type="text" class="form-control" id="phone_from"
                            	placeholder="핸드폰 번호" value="${ loginuser.phone }" readonly>
                        </div>
                        <!-- <div class="col-md-12 form-group p_star">
                            <input type="text" class="form-control" id="email_from"
                            	placeholder="Email Address" value="이메일@naver.com" readonly="readonly">
                        </div> -->
                        <div class="col-md-4 form-group p_star">
                            <input type="text" class="form-control" id="postCode_from" readonly
                            	placeholder="우편번호" value="${ loginuser.postCode}">
                        </div>
                        <div class="col-md-8 form-group p_star">
                            <input type="text" class="form-control" id="roadAddr_from" readonly
                            	placeholder="도로명주소" value="${ loginuser.roadAddr}">
                        </div>
                        <div class="col-md-4 form-group p_star"></div>
                        <div class="col-md-8 form-group p_star">
                            <input type="text" class="form-control" id="jibunAddr_from" readonly
                            	placeholder="지번주소" value="${ loginuser.jibunAddr }">
                        </div>
                        <div class="col-md-4 form-group p_star"></div>
                        <div class="col-md-8 form-group p_star">
                            <input type="text" class="form-control" id="detailAddr_from" readonly
                            	placeholder="상세주소" value="${ loginuser.detailAddr }">
                        </div>
                        <div class="col-md-4 form-group p_star"></div>
                        <div class="col-md-8 form-group p_star">
                            <input type="text" class="form-control" id="extraAddr_from" readonly
                            	placeholder="Address line 01" value="${ loginuser.extraAddr }">
                        </div>
                    	<div class="col-md-12 form-group">
                    		<hr>
                            <div class="creat_account">
                                <input type="checkbox" id="f-option2" name="selector" onclick="checkBuy(this)">
                                <label for="f-option2">주문자 정보와 동일</label>
                            </div>
                        </div>
                        <div class="col-md-6 form-group p_star">
                            <input type="text" class="form-control" id="name_to" name="name" placeholder="Name">
                        </div>
                        <div class="col-md-6 form-group p_star">
                            <input type="text" class="form-control" id="phone_to" name="phone" placeholder="Phone number">
                        </div>
                        <!-- <div class="col-md-12 form-group p_star">
                            <input type="text" class="form-control" id="email_to" name="email" placeholder="Email Address">
                        </div> -->
                        <div class="col-md-4 form-group">
							<input type="text" class="form-control" id="postcode" name="postCode" placeholder="우편번호">
						</div>
						<div class="col-md-8 form-group">
							<input type="text" class="form-control" id="roadAddress" name="roadAddr" placeholder="도로명주소"><br>
						</div>
						<div class="col-md-4 form-group">
							<input type="button" class="button addrBtn col py-2 text-white" value="우편번호 찾기">
						</div>
						<div class="col-md-8 form-group">
							<input type="text" class="form-control" id="jibunAddress" name="jibunAddr" placeholder="지번주소">
						</div>
						
                        <div class="col-md-4 form-group p_star"></div>
						<div class="col-md-8 form-group">
							<input type="text" class="form-control col-md-6" id="detailAddress" name="detailAddr" placeholder="상세주소">&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="text" class="form-control col-md-5" id="extraAddress" name="extraAddr" placeholder="참고항목">
						</div>
                        <div class="col-md-12 form-group mb-0">
                            <div class="creat_account">
                                <h3>Shipping Details</h3>
                            </div>
                            <textarea class="form-control" name="orderMsg" id="message" rows="1" placeholder="기사분께 전달할 내용을 입력해주세요"></textarea>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="order_box">
                        <h2>Your Order</h2>
                        <ul class="list">
                            <li><a href="#"><h4>Product <span class="middle">Quantity</span><span>Total</span></h4></a></li>
                         <c:forEach var="product" items="${ products }">
                         	<li><a href="/shop/single-product/${ product.productNo }">${ product.title }
                            		-${ product.productName }(${ product.color }/${ product.size })</a></li>
                            <li>
                            	<a href="#">
                            	
	                            	<span class="middle">${ product.count }개</span> 
	                            	<span class="last">
	                                  	<fmt:formatNumber pattern="#,###원">${ product.price * product.count }</fmt:formatNumber>
	                                  	<c:set var="total" value="${ total + (product.price * product.count) }"/>
									</span>
	                            </a>
                            </li>
                         </c:forEach>
                        </ul>
                        <ul class="list list_2">
                            <li><a href="#">Total <span><fmt:formatNumber pattern="#,###원">${ total }</fmt:formatNumber></span></a></li>
                        </ul>
                        <div class="payment_item">
                            <div class="radion_btn">
                                <input type="radio" id="f-option5" name="selector">
                                <label for="f-option5">무통장입금</label>
                                <div class="check"></div>
                            </div>
                        </div>
                        <div class="payment_item active">
                            <div class="radion_btn">
                                <input type="radio" id="f-option6" name="selector">
                                <label for="f-option6">신용카드</label>
                                <img src="/shop/resources/img/product/card.jpg" alt="">
                                <div class="check"></div>
                            </div>
                        </div>
                        <div class="creat_account">
                            <input type="checkbox" id="f-option4" name="selector" required>
                            <label for="f-option4"><a href="#">결제조건 확인 및 개인정보 제공</a>에 동의합니다.</label>
                        </div>
                        <div class="text-center">
                          <input type="submit" class="button button-paypal" value="결제하기">
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</section>
  <!--================End Checkout Area =================-->
<jsp:include page="include/footer.jsp"/>