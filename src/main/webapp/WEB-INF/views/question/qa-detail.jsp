
<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
	              <li class="breadcrumb-item active" aria-current="page"></li>
	            </ol>
	          </nav>
	        </div>
	      </div>
	    </div>
	  </section>
		

			<div >


				<div class="container" style="text-align: center">
					<div>
						<div>
							<div class="inputsubtitle"></div>
							<br /> <br /> <br />
							<table class="table table-hover">
								<tr>
									<th colspan="1" style="width: 200px">제목</th>
									<td colspan="2" style="text-align: left">[${ question.category }] &nbsp;&nbsp;${ question.title }</td>
									<th colspan="1">조회수</th>
									<td colspan="2" style="text-align: left">${ question.readCount }</td>
								</tr>
								
								<tr>
									<th colspan="1">작성자</th>
									<td colspan="2" style="text-align: left">${ question.uploader }</td>
									<th colspan="1">등록일자</th>
									<td colspan="2" style="text-align: left">${ question.regDate }</td>
								</tr>
								

								<tr>
									<%-- 줄바꿈 문자열을 저장하고 있는 변수 만들기 --%>
									<c:set var="enter" value="" />
									<%--upload.content 문자열에서 \r\n을 <br>로 변경 --%>
									<td colspan="6" style="text-align: left; width: 700px"
										rows="20">${ fn:replace(question.content, enter,'<br>')}</td>
								</tr>
								<tr>
									
									<td style="border-bottom:solid 0px;">
									</td>
								</tr>
							</table>
							<div class="buttons">
								<%--eq: 같은애를 찾는  / 로그인한 사용자와 글의 작성자가 같으면 삭제, 수정 버튼 활성화--%>
								<c:if test="${ loginuser.memberId eq question.uploader }">
									<input type="button" id="update_button"
										class="button button-subscribe mr-auto mb-1" value="edit" />
									<input type="button" id="delete_button"
										class="button button-subscribe mr-auto mb-1" value="delete" />
								</c:if>

								<input type="button" id="cancel_button"
									class="button button-subscribe mr-auto mb-1" value="back" /> <br> <br>
								<script type="text/javascript">
		        	//브라우저가 html을 모두 읽고 처리할 준비가 되었을 때 호출 할 함수 지정
		        	window.addEventListener('load',function(event){//js의 main 함수 역할
						var btnCancel =document.querySelector('#cancel_button');
		        		btnCancel.addEventListener('click', function(event) {
		        			location.href="/shop/qa-list";//주소창에 list을 입력하고 엔터
		        			//history.back(); //브라우저의 이전 버튼을 클릭
		        		});
		        		
		        		var btnDelete = document.querySelector('#delete_button');
		        		btnDelete.addEventListener('click', function(event){
		        			var ok = confirm("${question.questionNo}번 자료를 삭제할까요?");//의사 확인문장
		        			if(ok){
		        			//<a 를 통한 요청이므로 주소 뒤에 ?key=value 형식을 써서 데이터 전송
		        			location.href="/shop/delete/${ question.questionNo }";
		        			}
		        		});
		        		
		        		var btnUpdate = document.querySelector('#update_button');
		        		btnUpdate.addEventListener('click', function(event){
		        			//<a 를 통한 요청이므로 주소 뒤에 ?key=value 형식을 써서 데이터 전송
		        			location.href="/shop/qa-update/${ question.questionNo }";
		        		});
		        		
		        	});
		        	</script>
							</div>
						</div>
					</div>



					<!-- write comment area -->
					<form id="commentform">
						<input type="hidden" name="questionNo"
							value="${ question.questionNo }" /> <input type="hidden"
							name="writer" value="${ loginuser.memberId }" />
						<table style="width: 550px; border: solid 1px; margin: 0 auto"
							class="table table-bordered">
							<tr>
								<td style="width: 500px"><textarea id="comment_content"
										name="content" style="width: 500px" rows="3"
										class="form-control"></textarea></td>
								<td style="width: 50px; vertical-align: middle"><a
									id="writecomment" href="javascript:"
									style="text-decoration: none"> 댓글등록
								</a></td>
							</tr>
						</table>
					</form>
					<!-- comment list -->
					<div>
						<br>
						<hr style="width: 550px; margin: 0 auto">
						<br>
						<table id="comment-list"
							style="width: 550px; border: solid 1px; margin: 0 auto"
							class="table table-bordered">
							<c:if
								test="${ not empty question.comments and question.comments[0].commentNo != 0 }">

								<!-- 대댓글 -->

								<c:forEach var="comment" items="${ question.comments }">
									<tr id="tr${ comment.commentNo }">
										<td
											style="text-align:left;margin:5px;border-bottom: solid 1px;padding-left:${comment.depth * 20}px">


											<div id='commentview${ comment.commentNo }'>
												${ comment.writer } &nbsp;&nbsp; [${ comment.regDate }] <br />
												<br /> <span> ${ comment.content } </span> <br /> <br />

												<c:if test='${ loginuser.memberId eq "manager" }'>
													<a class="editcomment "
														data-commentno='${ comment.commentNo }' href="javascript:">편집</a>
													<a class="deletecomment " href="javascript:"
														data-commentno="${ comment.commentNo }">삭제</a>
												</c:if>
												<c:if test='${ loginuser.memberId ne "manager" }'>
													<div
														style='display:${ loginuser.memberId eq comment.writer ? "block" : "none" }'>
														<a class="editcomment "
															data-commentno='${ comment.commentNo }'
															href="javascript:">편집</a> <a class="deletecomment "
															href="javascript:"
															data-commentno="${ comment.commentNo }">삭제</a>
													</div>
												</c:if>
												<br /> <a class="recomment-link btn btn-outline-secondary"
													data-commentno="${ comment.commentNo }">댓글 쓰기</a>
											</div> <!-- 수정 -->
											<div id='commentedit${ comment.commentNo }'
												style="display: none">
												${ comment.writer } &nbsp;&nbsp; [${ comment.regDate }] <br />
												<br />
												<form id="updateform${ comment.commentNo }">
													<input type="hidden" name="commentNo"
														value="${ comment.commentNo }" />
													<textarea name="content" style="width: 550px" rows="3"
														maxlength="200">${ comment.content }</textarea>
												</form>
												<br />
												<div>
													<a class="updatecomment btn btn-outline-secondary"
														href="javascript:" data-commentno="${ comment.commentNo }">수정</a>
													&nbsp; <a class="cancel btn btn-outline-secondary"
														data-commentno="${ comment.commentNo }" href="javascript:">취소</a>
												</div>

											</div>

										</td>
									</tr>

								</c:forEach>
							</c:if>
						</table>

					</div>
				</div>

			</div>

			<br></br> <br></br> <br></br>



		


	</div>

</div>

	<script src="https://code.jquery.com/jquery-3.4.1.js"></script>



<!-- 댓글 javascript -->
<script type="text/javascript">
$(function() {
	$('#writecomment').on('click', function(event) {
		
		//serialize : <form에 포함된 입력 요소의 값을 이름=값&이름=값&... 형식으로 만드는 함수
		var formData = $('#commentform').serialize();
		// alert(formData)
		
			$.ajax({
			url: "/shop/write-comment",
			method: "POST",
			data: formData,
			success: function(data, status, xhr) {
				 alert(data);
				$("#comment-list").load('/shop/comment-list', 
										{ "questionNo" : ${  question.questionNo } }, 
										function() {})
			},
			error: function(xhr, status, err) {
				alert(err);
			} 
		});
	});
	
	var currentCommentNo = -1;
	//$('.editcomment').on('click', function(event) {
	$('#comment-list').on('click', '.editcomment', function(event) {
		commentNo = $(this).attr('data-commentno'); // $(event.target) == $(this)
		
		//이전에 편집중인 항목을 원래 상태로 복구
		if (currentCommentNo != -1) {
			$('#commentview' + currentCommentNo).css('display', '');
			$('#commentedit' + currentCommentNo).css('display', 'none');
		}
		
		$('#commentview' + commentNo).css('display', 'none');
		$('#commentedit' + commentNo).css('display', '');
		currentCommentNo = commentNo;
	});
	
	$('#comment-list').on('click', '.cancel', function(event) {
		commentNo = $(this).attr('data-commentno'); // $(event.target) == $(this)
		$('#commentview' + commentNo).css('display', '');
		$('#commentedit' + commentNo).css('display', 'none');
		currentCommentNo = -1;			
	});
	
	$('#comment-list').on('click', '.deletecomment', function(event) {
		commentNo = $(this).attr('data-commentno');
		$.ajax({
			url: "/shop/delete-comment",
			method: "GET",
			data: "commentNo=" + commentNo,
			success: function(data, status, xhr) {
				if (data == 'success') {
					$('#tr' + commentNo).remove();
					alert('삭제했습니다.');
				} else {
					alert('삭제 실패 1');
				}
			},
			error: function(xhr, status, err) {
				alert('삭제 실패 2');
			}
		});
	});
	
	$('#comment-list').on('click', '.updatecomment', function(event) {
		//현재 클릭된 <a 의 data-commentno 속성 값 읽기
		var commentNo = $(this).attr('data-commentno');
		var content = $('#updateform' + commentNo + ' textarea').val();
		var inputData = $('#updateform' + commentNo).serialize();
		
		//ajax 방식으로 데이터 수정
		$.ajax({
			"url": "/shop/update-comment",
			"method": "POST",
			"data": inputData,
			"success": function(data, status, xhr) {
				alert('댓글을 수정했습니다.');
				var span = $('#commentview' + commentNo + ' span');					
				span.html(content.replace(/\n/gi, '<br>'));
				//view-div는 숨기고, edit-div는 표시하기	
				$('#commentview' + commentNo).css('display', 'block');
				$('#commentedit' + commentNo).css('display', 'none');
			},
			"error": function(xhr, status, err) {
				alert('댓글 수정 실패');
			}
		});
	});
	
	$('#comment-list').on('click', '.recomment-link', function(event) {
		var commentNo = $(this).attr('data-commentno');
		$('#write-recomment-modal input[name=commentNo]').val(commentNo);
		$('#write-recomment-modal').modal('show'); //show bootstrap modal
	});
	
	$('#write-recomment').on('click', function(event) {
		
		var content = $('#recomment-form textarea').val();
		if (content.length == 0) return;
		
		var recommentData = $('#recomment-form').serialize();
		
		$.ajax({
			url: "/shop/write-recomment",
			method: "POST",
			data: recommentData,
			success: function(data, status, xhr) {
				alert('success');					
				$('#write-recomment-modal').modal('hide'); //hide bootstrap modal
				$('#recomment-form').each(function() {
					this.reset();
				});
				$("#comment-list").load('/shop/comment-list', 
						{ "questionNo" : ${ question.questionNo } }, 
						function() {})
				
			},
			error: function(xhr, status, err) {
				alert('fail');
			}
		});
	
	});	
	

});
	</script>

<!-- The Modal 댓글-->


<div class="modal" id="write-recomment-modal">
	<div class="modal-dialog">
		<div class="modal-content">

			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">댓글 쓰기</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>

			<!-- Modal body -->
			<div class="modal-body">
				<form id="recomment-form">
					<input type="hidden" name="commentNo"> <input type="hidden"
						name="writer" value="${ loginuser.memberId }"> <input
						type="hidden" name="questionNo" value="${ question.questionNo	 }">
					<textarea name="content" rows="5" style="width: 465px"
						class="form-control"></textarea>
				</form>
			</div>

			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" id="write-recomment"
					class="btn btn-outline-secondary">댓글 등록</button>
				<button type="button" class="btn btn-outline-secondary"
					data-dismiss="modal">취소</button>
			</div>

		</div>
	</div>
</div>



<jsp:include page="../include/footer.jsp" />