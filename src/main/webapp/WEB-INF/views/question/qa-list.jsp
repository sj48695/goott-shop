
<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>



<html>
<head>
<meta charset="UTF-8">
<meta name="description" content="">


<!-- <meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no"> -->
<!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->

<!-- Title  -->
<title>CatWebSite | List</title>

<!-- Favicon  -->
<!-- <link rel="icon" href="/catopia/resources/img/core-img/favicon.ico"> -->

<!-- Core Style CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="/catopia/resources/css/core-style.css">
<link rel="stylesheet" href="/catopia/resources/style.css">




</head>

<body>

	<!-- ##### Main Content Wrapper Start ##### -->
	<div class="main-content-wrapper d-flex clearfix">

		<!-- <!-- Mobile Nav (max width 767px)
		<div class="mobile-nav">
			Navbar Brand
			<div class="amado-navbar-brand">
				<a href="/catopia/home"><img
					src="/resources/img/core-img/logo.png" alt=""></a>
			</div>
			Navbar Toggler
			<div class="amado-navbar-toggler">
				<span></span><span></span><span></span>
			</div>
		</div> --> 

		<!--header start  -->
		<jsp:include page="/WEB-INF/views/include/header.jsp" />
		<!--header end  -->



		<!-- Product Catagories Area Start -->
		<div class="products-catagories-area clearfix">
			<div class="amado-pro-catagory clearfix">

				<div id="pageContainer">



					<h3 style="text-align: center; padding-top: 5%">QnA</h3>
					<br />



					<div class="container" style="padding-top: 50; text-align: center">
						<table class="table table-hover">
							<tr style="background-color:; height: 50px">
								<th style="width: 50px; text-align: center">NO</th>
								<th style="width: 100px; text-align: center">
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
							<tr style="height: 30px">
									<td style="text-align: center">*</td>
									<td style="text-align: center"><strong>공지사항</strong></td>
									<td style='text-align: left; padding-left: 10px'><strong>고객센터는 AM10:00 ~ PM16:30 까지 입니다</strong></td>
									<td style="text-align: center">manager</td>
									<td style="text-align: center">2019-06-24</td>
									<td style="text-align: center"></td>
							</tr>
							<c:forEach var="question" items="${questions}">
								<tr style="height: 30px">
									<td style="text-align: center">${ question.questionNo }</td>
									<td style="text-align: center">${ question.category }</td>
									<td style='text-align: left; padding-left: 10px'><a
										href="/catopia/qa-upload/qa-detail/${ question.questionNo }">
										${ question.title }</a>&nbsp;&nbsp;[${ question.recnt }]</td>
									<td style="text-align: center">${ question.uploader }</td>
									<td style="text-align: center">${ question.regDate }</td>
									<td style="text-align: center">${ question.answer ? "답변완료" : "답변대기" }
								</tr>
							</c:forEach>
								
						</table>

						<br></br>
						<div style="padding-left: 70%; text-align: center">
							<input type="button" value="글작성"
								onclick="location.href='qa-write' "
								class="btn btn-outline-secondary">
						</div>
					
					</div>
				</div>
			</div>
		</div>

		<!-- Product Catagories Area End -->
	</div>


	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	<!-- ##### jQuery (Necessary for All JavaScript Plugins) ##### -->
	<script
		src="<c:url value="/resources/js/jquery/jquery-2.2.4.min.js" />"></script>
	<!-- Popper js -->
	<script src="<c:url value="/resources/js/popper.min.js" />"></script>
	<!-- Bootstrap js -->
	<script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
	<!-- Plugins js -->
	<script src="<c:url value="/resources/js/plugins.js" />"></script>
	<!-- Active js -->
	<script src="<c:url value="/resources/js/active.js" />"></script>

	<script type="text/javascript">
		$(function() {

			$('#qaselectcategory').on('change', function(event) {

				this.form.submit();

			});
		});
	</script>
</body>
</html>

