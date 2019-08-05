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
            <div class="row">
                <div class="col-lg-8">
                    <h3>Billing Details</h3>
                    <form class="row contact_form" action="#" method="post" novalidate="novalidate">
                      	<div class="col-md-12 form-group p_star">
                            <input type="text" class="form-control" id="name_from" name="name" placeholder="Name" value="이름" readonly="readonly">
                        </div>
                        <div class="col-md-12 form-group p_star">
                            <input type="text" class="form-control" id="phone_from" name="phone" placeholder="Phone number" value="번호" readonly="readonly">
                        </div>
                        <div class="col-md-12 form-group p_star">
                            <input type="text" class="form-control" id="email_from" name="email" placeholder="Email Address" value="이메일@naver.com" readonly="readonly">
                        </div>
                    	<div class="col-md-12 form-group">
                    		<hr>
                            <div class="creat_account">
                                <input type="checkbox" id="f-option2" name="selector">
                                <label for="f-option2">주문자 정보와 동일</label>
                            </div>
                        </div>
                        <div class="col-md-12 form-group p_star">
                            <input type="text" class="form-control" id="name_from" name="name" placeholder="Name">
                        </div>
                        <div class="col-md-12 form-group p_star">
                            <input type="text" class="form-control" id="phone_from" name="phone" placeholder="Phone number">
                        </div>
                        <div class="col-md-12 form-group p_star">
                            <input type="text" class="form-control" id="email_from" name="email" placeholder="Email Address">
                        </div>
                        <div class="col-md-12 form-group p_star">
                            <input type="text" class="form-control" id="add1" name="add1">
                            <span class="placeholder" data-placeholder="Address line 01"></span>
                        </div>
                        <div class="col-md-12 form-group p_star">
                            <input type="text" class="form-control" id="add2" name="add2">
                            <span class="placeholder" data-placeholder="Address line 02"></span>
                        </div>
                        <div class="col-md-12 form-group p_star">
                            <input type="text" class="form-control" id="city" name="city">
                            <span class="placeholder" data-placeholder="Town/City"></span>
                        </div>
                        <div class="col-md-12 form-group p_star">
                            <select class="country_select">
                                <option value="1">District</option>
                                <option value="2">District</option>
                                <option value="4">District</option>
                            </select>
                        </div>
                        <div class="col-md-12 form-group">
                            <input type="text" class="form-control" id="zip" name="zip" placeholder="Postcode/ZIP">
                        </div>
                        <div class="col-md-12 form-group">
                            <div class="creat_account">
                                <input type="checkbox" id="f-option2" name="selector">
                                <label for="f-option2">Create an account?</label>
                            </div>
                        </div>
                        <div class="col-md-12 form-group mb-0">
                            <div class="creat_account">
                                <h3>Shipping Details</h3>
                            </div>
                            <textarea class="form-control" name="message" id="message" rows="1" placeholder="Order Notes"></textarea>
                        </div>
                    </form>
                </div>
                <div class="col-lg-4">
                    <div class="order_box">
                        <h2>Your Order</h2>
                        <ul class="list">
                            <li><a href="#"><h4>Product <span>Total</span></h4></a></li>
                         <c:forEach var="product" items="${ products }">
                            <li>
                            	<a href="#">${ product.productName }
	                            	<span class="middle">${ product.count }개</span> 
	                            	<span class="last">
	                                  	<fmt:formatNumber pattern="#,###원">${ product.price * product.count }</fmt:formatNumber>
	                                  	<c:set var="subtotal" value="${ subtotal + (product.price * product.count) }"/>
									</span>
	                            </a>
                            </li>
                         </c:forEach>
                        </ul>
                        <ul class="list list_2">
                            <li><a href="#">Subtotal <span><fmt:formatNumber pattern="#,###원">${ subtotal }</fmt:formatNumber></span></a></li>
                            <li><a href="#">Shipping <span>Flat rate: $50.00</span></a></li>
                            <li><a href="#">Total <span>$2210.00</span></a></li>
                        </ul>
                        <div class="payment_item">
                            <div class="radion_btn">
                                <input type="radio" id="f-option5" name="selector">
                                <label for="f-option5">Check payments</label>
                                <div class="check"></div>
                            </div>
                            <p>Please send a check to Store Name, Store Street, Store Town, Store State / County,
                                Store Postcode.</p>
                        </div>
                        <div class="payment_item active">
                            <div class="radion_btn">
                                <input type="radio" id="f-option6" name="selector">
                                <label for="f-option6">Paypal </label>
                                <img src="/shop/resources/img/product/card.jpg" alt="">
                                <div class="check"></div>
                            </div>
                            <p>Pay via PayPal; you can pay with your credit card if you donât have a PayPal
                                account.</p>
                        </div>
                        <div class="creat_account">
                            <input type="checkbox" id="f-option4" name="selector">
                            <label for="f-option4">Iâve read and accept the </label>
                            <a href="#">terms & conditions*</a>
                        </div>
                        <div class="text-center">
                          <a class="button button-paypal" href="#">Proceed to Paypal</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
  </section>
  <!--================End Checkout Area =================-->
<jsp:include page="include/footer.jsp"/>