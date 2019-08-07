
<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/include/header.jsp" />


<div class="main-content-wrapper d-flex clearfix">

	<!-- Product Catagories Area Start -->
	<div class="products-catagories-area clearfix" style="width: 100%">

		<section class="blog-banner-area" id="blog">
			<div class="container h-100">
				<div class="blog-banner">
					<div class="text-center">
						<h1>QnA</h1>
						<nav aria-label="breadcrumb" class="banner-breadcrumb">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="#">Home</a></li>
								<li class="breadcrumb-item active" aria-current="page">QnA</li>
								<li class="breadcrumb-item active" aria-current="page"></li>
							</ol>
						</nav>
					</div>
				</div>
			</div>
		</section>

<br></br>
		<form action="/shop/pwCheck" method="POST">
			<div class="container" style="text-align: center">
				<fieldset>
					<legend>비밀번호 입력</legend>
					<ul>
						<li>[ 비밀글 ]</li>
						<li>Secret Writing</li>
						<li>안전한 글 접속을 위해 작성하신 비밀번호를 입력해주세요!</li>
						<li class="form_wrap"><span class="pw_form">P/W 
							<input type="hidden" name="questionNo" value="${ questionNo }">
							<input id="secure_pwdd" name="pwd" type="password"></span>
							<input type="submit" value="OK" >
							
						</li>
					</ul>
				</fieldset>
			</div>
		</form>
		
	</div>
</div>

<br></br>  
<jsp:include page="../include/footer.jsp" />