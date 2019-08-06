<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/include/header.jsp" />

<!-- ##### Main Content Wrapper Start ##### -->
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
	            </ol>
	          </nav>
	        </div>
	      </div>
	    </div>
	  </section>
	  
	  <section class="blog_categorie_area">
	    <div class="container">
	      <div class="row">
	        <div class="col-sm-6 col-lg-4 mb-4 mb-lg-0">
	            <div class="categories_post">
	                <img class="card-img rounded-0" src="/shop/resources/img/blog/cat-post/cat-post-3.jpg" alt="post">
	                <div class="categories_details">
	                    <div class="categories_text">
	                        <a href="single-blog.html">
	                            <h5>공지사항</h5>
	                        </a>
	                        <div class="border_line"></div>
	                        <p>Notice</p>
	                    </div>
	                </div>
	            </div>
	        </div>
	        <div class="col-sm-6 col-lg-4 mb-4 mb-lg-0">
	          <div class="categories_post">
	            <img class="card-img rounded-0" src="/shop/resources/img/blog/cat-post/cat-post-2.jpg" alt="post">
	            <div class="categories_details">
	              <div class="categories_text">
	                <a href="single-blog.html">
	                    <h5>상품문의</h5>
	                </a>
	                <div class="border_line"></div>
	                <p>QnA</p>
	              </div>
	            </div>
	          </div>
	        </div>
	        <div class="col-sm-6 col-lg-4 mb-4 mb-lg-0">
	            <div class="categories_post">
	                <img class="card-img rounded-0" src="/shop/resources/img/blog/cat-post/cat-post-1.jpg" alt="post">
	                <div class="categories_details">
	                    <div class="categories_text">
	                        <a href="single-blog.html">
	                            <h5>사용후기</h5>
	                        </a>
	                        <div class="border_line"></div>
	                        <p>Review</p>
	                    </div>
	                </div>
	            </div>
	        </div>
	      </div>
	    </div>
	  </section>
  
  <!-- 시작 -->
		<div class="amado-pro-catagory clearfix">

			<div>
				<br />
				<div class="container" style="padding-top: 50; text-align: center">
				<form id="selectform" action="/shop/qa-list" method="POST">
								
							
									<select name="category" id="qaselectcategory">
										<option value="all">전체</option>
										<option value="상품문의"
											<c:if test="${param.category eq '상품문의'}">selected</c:if>>상품문의</option>
										<option value="교환/반품문의"
											<c:if test="${param.category eq '교환/반품문의'}">selected</c:if>>교환/반품문의</option>
										<option value="기타문의"
											<c:if test="${param.category eq '기타문의'}">selected</c:if>>기타문의</option>
									</select>
						</form>
					<table class="table table-hover">
						
						<tr style="background-color:; height: 50px" >
							<th style="width: 50px; text-align: center">NO</th>
							<th style="width: 50px; text-align: center">PRODUCT</th>
							<th style="width: 100px; text-align: center">CATEGORY</th>
							<th style="width: 400px; text-align: center">CONTENTS</th>
							<th style="width: 125px; text-align: center">NAME</th>
							<th style="width: 150px; text-align: center;">DATE</th>
							<th style="width: 125px; text-align: center">ANSWER</th>
						</tr>
						
						<c:forEach var="notice" items="${noticelist}">
							<tr style="height: 30px">
								<td style="text-align: center">${ notice.questionNo }</td>
								<td style="text-align: center"><strong>${ notice.title }</strong></td>
								<td style='text-align: left; padding-left: 10px'><strong>${ notice.content }</strong></td>
								<td style="text-align: center">${ notice.managerID }</td>
								<td style="text-align: center">${ notice.regDate }</td>
								<td style="text-align: center"></td>
							</tr>
						</c:forEach>
						<c:forEach var="question" items="${questions}">
							<tr style="height: 30px">
								<td style="text-align: center">${ question.questionNo }</td>
								<td style="text-align: center">${ question.questionNo }</td>
								<td style="text-align: center">${ question.category }</td>
								<td style='text-align: left; padding-left: 10px'>
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
								<td style="text-align: center">${ question.uploader }</td>
								<td style="text-align: center">${ question.regDate }</td>
								<td style="text-align: center">${ question.answer ? "답변완료" : "답변대기" }
							</tr>
						</c:forEach>
					</table>

					<br></br>
					<div style="padding-left: 70%; text-align: center">
						<input type="button" value="Write"
							onclick="location.href='qa-write' "
							class="button button-subscribe mr-auto mb-1">
					</div>

				</div>
			</div>
		</div>
	</div>

	<!-- Product Catagories Area End -->
</div>

<br>
<br>
<br>
<br>


<jsp:include page="../include/footer.jsp" />