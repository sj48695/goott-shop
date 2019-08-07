<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
		<div class="container">
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

			<div class="tab-content" id="myTabContent">
			
				<div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
					<div class="col-lg-12">
						<h4><strong>내 정보</strong></h4>
						<form action="/shop/account/update" class="form-contact form-review mt-3" method="post">
							<table class="table">
								<tr>
									<th>아이디</th>
									<td>${ member.memberId }</td>
								</tr>
								<tr>
									<th>비밀번호</th>
									<td><input class="form-control" name="pwd" type="password" required></td>
								</tr>
								<tr>
									<th>이름</th>
									<td><input class="form-control" name="name" type="text" value="${ member.name }"></td>
								</tr>
								<tr>
									<th>휴대폰 번호</th>
									<td><input class="form-control" name="phone" type="text" value="${ member.phone }"></td>
								</tr>
								<tr>
									<th>우편번호</th>
									<td><input class="form-control" name="postCode" type="text" value="${ member.postCode }"></td>
								</tr>
								<tr>
									<th>도로명주소</th>
									<td><input class="form-control" name="roadAddr" type="text" value="${ member.roadAddr }"></td>
								</tr>
								<tr>
									<th>지번주소</th>
									<td><input class="form-control" name="jibunAddr" type="text" value="${ member.jibunAddr }"></td>
								</tr>
								<tr>
									<th>상세주소</th>
									<td><input class="form-control" name="detailAddr" type="text" value="${ member.detailAddr }"></td>
								</tr>
								<tr>
									<th>참고사항</th>
									<td><input class="form-control" name="extraAddr" type="text" value="${ member.extraAddr }"></td>
								</tr>							
							</table>
							<div class="form-group text-center text-md-right mt-3">
								<input type="submit" value="수정" class="button button--active button-review">
							</div>
						</form>

					</div>
				</div>
				
				<div class="tab-pane fade" id="cart" role="tabpanel" aria-labelledby="cart-tab"></div>
				<div class="tab-pane fade" id="order" role="tabpanel" aria-labelledby="order-tab"></div>
				<div class="tab-pane fade" id="qna" role="tabpanel" aria-labelledby="qna-tab"></div>
			</div>
	
		</div>
	</section>
	
  <!--================End Order Details Area =================-->

 <jsp:include page="../include/footer.jsp"/>