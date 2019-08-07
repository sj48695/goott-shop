<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="include/header.jsp"/>	
<style>
.optLabel{
	align-self: center;
}
</style>
	<!-- ================ start banner area ================= -->	
	<section class="blog-banner-area" id="blog">
		<div class="container h-100">
			<div class="blog-banner">
				<div class="text-center">
					<h1>Shop Single</h1>
					<nav aria-label="breadcrumb" class="banner-breadcrumb">
            <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active" aria-current="page">Shop Single</li>
            </ol>
          </nav>
				</div>
			</div>
    </div>
	</section>
	<!-- ================ end banner area ================= -->


  <!--================Single Product Area =================-->
	<div class="product_image_area">
		<div class="container">
			<div class="row s_product_inner">
				<div class="col-lg-6">
					<div class="owl-carousel owl-theme s_Product_carousel">
						<div class="single-prd-item">
							<img class="img-fluid" src="/shop/resources/img/category/s-p1.jpg" alt="">
						</div>
						<!-- <div class="single-prd-item">
							<img class="img-fluid" src="/shop/resources/img/category/s-p1.jpg" alt="">
						</div>
						<div class="single-prd-item">
							<img class="img-fluid" src="/shop/resources/img/category/s-p1.jpg" alt="">
						</div> -->
					</div>
				</div>
				<div class="col-lg-5 offset-lg-1">			
					<div class="s_product_text">
						<form id="addCartForm" action="/shop/checkout/buynow" method="post">
							<input hidden="true" name="productNo" value="${ product.productNo }">
							<input hidden="true" name="price" value="${ product.price }">
							<input hidden="true" id="result" name="result" value="0">
							<h3>${ product.title }</h3>
							<h2><fmt:formatNumber pattern="#,###￦">${ product.price }</fmt:formatNumber></h2>
							<ul class="list">
								<li><a class="active" href="#"><span>Category</span> : ${ product.category }</a></li>
								<li><a href="#"><span>Availibility</span> : In Stock</a></li>
							</ul>
							<p>${ product.content }</p>
							
							<c:set var="colors" value="${ fn:split(product.color, ',') }"/>
							<c:set var="sizes" value="${ fn:split(product.size, ',') }"/>
							<c:set var="productNames" value="${ fn:split(product.productName, ',') }"/>
							
							<div class="product_count w-100">
	              				<div class="row py-1">
	              					<label class="col-3" for="sst">Quantity : </label>
									<button	class="items-count quantityDown" type="button"
										style="position: relative;"><i class="ti-angle-left"></i></button>
									<input type="text" name="count" id="sst" size="2" maxlength="12" value="1" title="Quantity:" class="input-text qty">
		              				<button class="items-count quantityUp" type="button"
										style="position: relative;"><i class="ti-angle-right"></i></button>
								</div>
								<c:if test="${ product.color ne '' && product.color ne null }">
								<div class="row py-1">
									<label class="col-3 optLabel" for="color">Color	: </label>
									<select name="color" required="required">
										<option>색상선택</option>
										<c:forEach var="color" items="${ colors }">
											<option>${ color }</option>
										</c:forEach>
									</select>
								</div>
								</c:if>
								<c:if test="${ product.size ne '' && product.size ne null }">
								<div class="row py-1">
									<label class="col-3 optLabel" for="size">Size	: </label>
									<select name="size" required="required">
										<option>크기선택</option>
										<c:forEach var="size" items="${ sizes }">
											<option>${ size }</option>
										</c:forEach>
									</select>
								</div>
								</c:if>
								<c:if test="${ product.productName ne '' && product.productName ne null }">
								<div class="row py-1">
									<label class="col-3 optLabel" for="productName">ProductName	: </label>
									<select name="productName" required="required">
										<option>상품선택</option>
										<c:forEach var="productName" items="${ productNames }">
											<option>${ productName }</option>
										</c:forEach>
									</select>
								</div>
								</c:if>
								<div class="row text-center">
									<input class="button primary-btn addToCart col-5 m-3 pr-0 text-center" value="Add to Cart">  
									<input type="submit" class="button button-header col-5 m-3 pr-0 text-center" value="Buy Now">
								</div>
							</div>
							<div class="card_area d-flex align-items-center">
								<a class="icon_btn" href="#"><i class="lnr lnr lnr-diamond"></i></a>
								<a class="icon_btn" href="#"><i class="lnr lnr lnr-heart"></i></a>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--================End Single Product Area =================-->

	<!--================Product Description Area =================-->
	<section class="product_description_area">
		<div class="container">
			<ul class="nav nav-tabs" id="myTab" role="tablist">
				<li class="nav-item">
					<a class="nav-link" id="description-tab" data-toggle="tab" href="#description" role="tab" aria-controls="description" aria-selected="true">Description</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" id="specification-tab" data-toggle="tab" href="#specification" role="tab" aria-controls="specification"
					 aria-selected="false">Specification</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" id="comments-tab" data-toggle="tab" href="#comments" role="tab" aria-controls="comments"
					 aria-selected="false">Comments</a>
				</li>
				<li class="nav-item">
					<a class="nav-link active" id="review-tab" data-toggle="tab" href="#review" role="tab" aria-controls="review"
					 aria-selected="false">Reviews</a>
				</li>
			</ul>
			<div class="tab-content" id="myTabContent">
				<div class="tab-pane fade" id="description" role="tabpanel" aria-labelledby="description-tab">
					<p>${ product.content }</p>
				</div>
				<div class="tab-pane fade" id="specification" role="tabpanel" aria-labelledby="specification-tab">
					<div class="table-responsive">
						<table class="table">
							<tbody>
								<tr>
									<td><h5>Width</h5></td>
									<td><h5>128mm</h5></td>
								</tr>
								<tr>
									<td><h5>Height</h5></td>
									<td><h5>508mm</h5></td>
								</tr>
								<tr>
									<td><h5>Depth</h5></td>
									<td><h5>85mm</h5></td>
								</tr>
								<tr>
									<td><h5>Weight</h5></td>
									<td><h5>52gm</h5></td>
								</tr>
								<tr>
									<td><h5>Quality checking</h5></td>
									<td><h5>yes</h5></td>
								</tr>
								<tr>
									<td><h5>Freshness Duration</h5></td>
									<td><h5>03days</h5></td>
								</tr>
								<tr>
									<td><h5>When packeting</h5></td>
									<td><h5>Without touch of hand</h5></td>
								</tr>
								<tr>
									<td><h5>Each Box contains</h5></td>
									<td><h5>60pcs</h5></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<div class="tab-pane fade" id="comments" role="tabpanel" aria-labelledby="comments-tab">
					<div class="row">
						<div class="col-lg-6">
							<div class="comment_list">
								<div class="review_item">
									<div class="media">
										<div class="d-flex">
											<img src="/shop/resources/img/product/review-1.png" alt="">
										</div>
										<div class="media-body">
											<h4>Blake Ruiz</h4>
											<h5>12th Feb, 2018 at 05:56 pm</h5>
											<a class="reply_btn" href="#">Reply</a>
										</div>
									</div>
									<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et
										dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea
										commodo</p>
								</div>
								<div class="review_item reply">
									<div class="media">
										<div class="d-flex">
											<img src="/shop/resources/img/product/review-2.png" alt="">
										</div>
										<div class="media-body">
											<h4>Blake Ruiz</h4>
											<h5>12th Feb, 2018 at 05:56 pm</h5>
											<a class="reply_btn" href="#">Reply</a>
										</div>
									</div>
									<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et
										dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea
										commodo</p>
								</div>
								<div class="review_item">
									<div class="media">
										<div class="d-flex">
											<img src="/shop/resources/img/product/review-3.png" alt="">
										</div>
										<div class="media-body">
											<h4>Blake Ruiz</h4>
											<h5>12th Feb, 2018 at 05:56 pm</h5>
											<a class="reply_btn" href="#">Reply</a>
										</div>
									</div>
									<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et
										dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea
										commodo</p>
								</div>
							</div>
						</div>
						<div class="col-lg-6">
							<div class="review_box">
								<h4>Post a comment</h4>
								<form class="row contact_form" action="contact_process.php" method="post" id="contactForm" novalidate="novalidate">
									<div class="col-md-12">
										<div class="form-group">
											<input type="text" class="form-control" id="name" name="name" placeholder="Your Full name">
										</div>
									</div>
									<div class="col-md-12">
										<div class="form-group">
											<input type="email" class="form-control" id="email" name="email" placeholder="Email Address">
										</div>
									</div>
									<div class="col-md-12">
										<div class="form-group">
											<input type="text" class="form-control" id="number" name="number" placeholder="Phone Number">
										</div>
									</div>
									<div class="col-md-12">
										<div class="form-group">
											<textarea class="form-control" name="message" id="message" rows="1" placeholder="Message"></textarea>
										</div>
									</div>
									<div class="col-md-12 text-right">
										<button type="submit" value="submit" class="btn primary-btn">Submit Now</button>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
				<div class="tab-pane fade show active" id="review" role="tabpanel" aria-labelledby="review-tab">
					<div class="row">
						<div class="col-lg-12">
							<div class="review_list">
								<div class="review_item">
									<div class="media">
										<div class="d-flex">
											<img src="/shop/resources/img/product/review-1.png" alt="">
										</div>
										<div class="media-body">
											<h4>Blake Ruiz</h4>
											<i class="fa fa-star"></i>
											<i class="fa fa-star"></i>
											<i class="fa fa-star"></i>
											<i class="fa fa-star"></i>
											<i class="fa fa-star"></i>
										</div>
									</div>
									<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et
										dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea
										commodo</p>
								</div>
								<div class="review_item">
									<div class="media">
										<div class="d-flex">
											<img src="/shop/resources/img/product/review-2.png" alt="">
										</div>
										<div class="media-body">
											<h4>Blake Ruiz</h4>
											<i class="fa fa-star"></i>
											<i class="fa fa-star"></i>
											<i class="fa fa-star"></i>
											<i class="fa fa-star"></i>
											<i class="fa fa-star"></i>
										</div>
									</div>
									<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et
										dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea
										commodo</p>
								</div>
								<div class="review_item">
									<div class="media">
										<div class="d-flex">
											<img src="/shop/resources/img/product/review-3.png" alt="">
										</div>
										<div class="media-body">
											<h4>Blake Ruiz</h4>
											<i class="fa fa-star"></i>
											<i class="fa fa-star"></i>
											<i class="fa fa-star"></i>
											<i class="fa fa-star"></i>
											<i class="fa fa-star"></i>
										</div>
									</div>
									<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et
										dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea
										commodo</p>
								</div>
							</div>
						</div>
						<div>
						<div>
				<!-- 후기 -->
				<%-- <c:if test="${ product.reviewCheck }"> --%>
	            <form id="reviewform" class="form-inline row">
	               <h4 class="text-black col-md-12 py-3"><b>후기</b></h4>
	               <input type="hidden" name="productNo" id="productNo" value="${ product.productNo }"> 
	               <input type="hidden" name="memberId" value="${ loginuser.memberId }">
					<div class="col-md-12">
						<!-- <div class='starrr' id='star'></div>
						<br /> 
						<input type="hidden" name='rating' id='star_input' /> -->
						<textarea class="form-control mr-1" id="review_content"
							name="content" cols="65" rows="3"></textarea>
						<a class="btn btn-primary py-3 px-4" id="memberIdeview"
							href="javascript:">댓글<br>등록
						</a>
					</div>
				</form>
	            <%-- </c:if> --%>
	            
	            <hr style="border-color: #4a2773;">
				<!-- review list -->
				<c:if test="${ not empty product.reviews and product.reviews[0].reviewNo != 0 }">
					<table id="review-list" class="w-100 m-auto border-top">
						<c:forEach var="review" items="${ product.reviews }">
						<fmt:formatDate value="${ review.regDate }" var="regDate" type="date" pattern="yyyy-MM-dd hh:mm:ss"/>
							<tr id="tr${ review.reviewNo }">
								<td class="border-bottom text-left" style="padding-left:${ review.depth*20 + 10 }px">
									<div id='reviewview${ review.reviewNo }' class="container">
										<div class="col-sm-12 row justify-content-between py-1">
											${ review.memberId } &nbsp;&nbsp; [${ regDate }] 
											<div class="row"style='display:${ loginuser.memberId eq review.memberId ? "block" : "none" }'>
												<a class="editreview" data-reviewno='${ review.reviewNo }' href="javascript:" style="width: 30px; height: 30px">
													편집<!-- <img src="/spacerental/resources/images/edit.svg" class="svg"> -->
												</a> &nbsp; 
												<a class="deletereview" href="javascript:" data-reviewno="${ review.reviewNo }" style="width: 30px; height: 30px">
													삭제<!-- <img src="/spacerental/resources/images/delete.svg" class="svg"> -->
												</a>
											</div>
										</div>
										<span>${ review.content }</span>
										
										<div style="width: 30px;height: 30px">
											<a class="comment-link"
												data-toggle="collapse" href="#comment-collapse${ review.reviewNo }"
												aria-controls="comment-collapse${ review.reviewNo }">
													<img src="/shop/resources/img/comment.svg" class="svg">
											</a>
										</div>

									</div>
									<div>
									<div class="row">
										<div class="col">
											<div class="collapse multi-collapse" id="comment-collapse${ review.reviewNo }">
												<div class="card-body">
												<form id="comment-form" class="form-inline row">
													<input type="hidden" name="reviewNo" value="${ review.reviewNo }">
									               <input type="hidden" name="productNo" id="productNo" value="${ product.productNo }"> 
									               <input type="hidden" name="memberId" value="${ loginuser.memberId }">
									               <div class="col-md-12">
									                  <textarea class="form-control mr-1" name="content" cols="${ 60 - review.depth*5 }" rows="3"></textarea>
									                  <a class="btn btn-primary py-3 px-4" id="write-comment" 
									                  	data-reviewno='${ review.reviewNo }' href="javascript:">댓글<br>등록</a>
									               </div>
									            </form>
									            </div>
											</div>
										</div>
									</div>
									</div>
									<div id='reviewedit${ review.reviewNo }' style="display: none" class="container">
										<div class="col-sm-12 row justify-content-between py-1">
											${ review.memberId } &nbsp;&nbsp; [${ regDate }]
										</div>
										<form id="updateform${ review.reviewNo }">
											<input type="hidden" name="reviewNo" value="${ review.reviewNo }" />
											<textarea class="form-control"name="content" style="width: 550px" rows="3"
												maxlength="200">${ review.content }</textarea>
										</form>
										<div>
											<a class="updatereview" href="javascript:" data-reviewno="${ review.reviewNo }">수정</a> &nbsp; 
											<a class="cancel" data-reviewno="${ review.reviewNo }" href="javascript:">취소</a>
										</div>
									</div>
								</td>
							</tr>
						</c:forEach>
					</table>
				</c:if>
				<c:if test="${ empty product.reviews or product.reviews[0].reviewNo eq 0 }">
					<table id="review-list" class="w-100 m-auto border-top">
						<tr>
							<td>등록된 후기가 없습니다.</td>
						</tr>
					</table>
				</c:if>
				</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!--================End Product Description Area =================-->

	<!--================ Start related Product area =================-->  
	<section class="related-product-area section-margin--small mt-0">
		<div class="container">
			<div class="section-intro pb-60px">
        <p>Popular Item in the market</p>
        <h2>Top <span class="section-intro__style">Product</span></h2>
      </div>
			<div class="row mt-30">
        <div class="col-sm-6 col-xl-3 mb-4 mb-xl-0">
          <div class="single-search-product-wrapper">
            <div class="single-search-product d-flex">
              <a href="#"><img src="/shop/resources/img/product/product-sm-1.png" alt=""></a>
              <div class="desc">
                  <a href="#" class="title">Gray Coffee Cup</a>
                  <div class="price">$170.00</div>
              </div>
            </div>
            <div class="single-search-product d-flex">
              <a href="#"><img src="/shop/resources/img/product/product-sm-2.png" alt=""></a>
              <div class="desc">
                <a href="#" class="title">Gray Coffee Cup</a>
                <div class="price">$170.00</div>
              </div>
            </div>
            <div class="single-search-product d-flex">
              <a href="#"><img src="/shop/resources/img/product/product-sm-3.png" alt=""></a>
              <div class="desc">
                <a href="#" class="title">Gray Coffee Cup</a>
                <div class="price">$170.00</div>
              </div>
            </div>
          </div>
        </div>

        <div class="col-sm-6 col-xl-3 mb-4 mb-xl-0">
          <div class="single-search-product-wrapper">
            <div class="single-search-product d-flex">
              <a href="#"><img src="/shop/resources/img/product/product-sm-4.png" alt=""></a>
              <div class="desc">
                  <a href="#" class="title">Gray Coffee Cup</a>
                  <div class="price">$170.00</div>
              </div>
            </div>
            <div class="single-search-product d-flex">
              <a href="#"><img src="/shop/resources/img/product/product-sm-5.png" alt=""></a>
              <div class="desc">
                <a href="#" class="title">Gray Coffee Cup</a>
                <div class="price">$170.00</div>
              </div>
            </div>
            <div class="single-search-product d-flex">
              <a href="#"><img src="/shop/resources/img/product/product-sm-6.png" alt=""></a>
              <div class="desc">
                <a href="#" class="title">Gray Coffee Cup</a>
                <div class="price">$170.00</div>
              </div>
            </div>
          </div>
        </div>

        <div class="col-sm-6 col-xl-3 mb-4 mb-xl-0">
          <div class="single-search-product-wrapper">
            <div class="single-search-product d-flex">
              <a href="#"><img src="/shop/resources/img/product/product-sm-7.png" alt=""></a>
              <div class="desc">
                  <a href="#" class="title">Gray Coffee Cup</a>
                  <div class="price">$170.00</div>
              </div>
            </div>
            <div class="single-search-product d-flex">
              <a href="#"><img src="/shop/resources/img/product/product-sm-8.png" alt=""></a>
              <div class="desc">
                <a href="#" class="title">Gray Coffee Cup</a>
                <div class="price">$170.00</div>
              </div>
            </div>
            <div class="single-search-product d-flex">
              <a href="#"><img src="/shop/resources/img/product/product-sm-9.png" alt=""></a>
              <div class="desc">
                <a href="#" class="title">Gray Coffee Cup</a>
                <div class="price">$170.00</div>
              </div>
            </div>
          </div>
        </div>

        <div class="col-sm-6 col-xl-3 mb-4 mb-xl-0">
          <div class="single-search-product-wrapper">
            <div class="single-search-product d-flex">
              <a href="#"><img src="/shop/resources/img/product/product-sm-1.png" alt=""></a>
              <div class="desc">
                  <a href="#" class="title">Gray Coffee Cup</a>
                  <div class="price">$170.00</div>
              </div>
            </div>
            <div class="single-search-product d-flex">
              <a href="#"><img src="/shop/resources/img/product/product-sm-2.png" alt=""></a>
              <div class="desc">
                <a href="#" class="title">Gray Coffee Cup</a>
                <div class="price">$170.00</div>
              </div>
            </div>
            <div class="single-search-product d-flex">
              <a href="#"><img src="/shop/resources/img/product/product-sm-3.png" alt=""></a>
              <div class="desc">
                <a href="#" class="title">Gray Coffee Cup</a>
                <div class="price">$170.00</div>
              </div>
            </div>
          </div>
        </div>
      </div>
		</div>
	</section>
	<!--================ end related Product area =================-->
<jsp:include page="include/footer.jsp"/>