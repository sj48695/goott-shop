<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<c:set var="title" value="Aroma Shop - Register" scope="request"/>
<jsp:include page="../include/header.jsp"/>  
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
  <!-- ================ start banner area ================= -->	
	<section class="blog-banner-area" id="category">
		<div class="container h-100">
			<div class="blog-banner">
				<div class="text-center">
					<h1>Register</h1>
				</div>
			</div>
    	</div>
	</section>
	<!-- ================ end banner area ================= -->
  
  	<!--================Login Box Area =================-->
	<section class="login_box_area section-margin">
		<div class="container">
			<div class="row">
				<div class="col-lg-6">
					<div class="login_box_img">
						<div class="hover">
							<h4>이미 회원이십니까?</h4>
							<p>There are advances being made in science and technology everyday, and a good example of this is the</p>
							<a class="button button-account" href="/shop/account/login">Login Now</a>
						</div>
					</div>
				</div>
				<div class="col-lg-6">
					<div class="login_form_inner register_form_inner">
						<h3>Create an account</h3>
						<form class="row login_form" action="register" id="register_form" method="post">
							<div class="col-md-12 form-group">
								<input type="text" class="form-control" id="memberId" name="memberId" placeholder="ID" onfocus="this.placeholder = ''" onblur="this.placeholder = 'ID'">
							</div>
							<div class="col-md-12 form-group">
								<input type="password" class="form-control" id="pwd" name="pwd" placeholder="password" onfocus="this.placeholder = ''" onblur="this.placeholder = 'password'">
              				</div>
              				<div class="col-md-12 form-group">
								<input type="text" class="form-control" id="name" name="name" placeholder="name" onfocus="this.placeholder = ''" onblur="this.placeholder = 'name'">
              				</div>
              				<div class="col-md-12 form-group">
								<input type="text" class="form-control" id="phone" name="phone" placeholder="010-xxxx-xxxx" onfocus="this.placeholder = ''" onblur="this.placeholder = '010-xxxx-xxxx'">
							</div>
							<div class="col-md-12 form-group">
								<input type="text" class="col-md-8" id="postcode" name="postCode" placeholder="우편번호">&nbsp;&nbsp;
								<input type="button" class="addrBtn" value="우편번호 찾기">
							</div>
							<div class="col-md-12 form-group">
								<input type="text" class="form-control" id="roadAddress" name="roadAddr" placeholder="도로명주소"><br>
								<input type="text" class="form-control" id="jibunAddress" name="jibunAddr" placeholder="지번주소">
							</div>
							<div class="col-md-12 form-group">
								<input type="text" class="col-md-6" id="detailAddress" name="detailAddr" placeholder="상세주소">&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="text" class="col-md-5" id="extraAddress" name="extraAddr" placeholder="참고항목">
							</div>
							
							<div class="col-md-12 form-group">
								<div class="creat_account">
									<input type="checkbox" id="f-option2" name="selector">
									<label for="f-option2">Keep me logged in</label>
								</div>
							</div>
							<div class="col-md-12 form-group">
								<button class="button button-register w-100">Register</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>
	
	<!--================End Login Box Area =================-->
	
	<jsp:include page="../include/footer.jsp"/>
	