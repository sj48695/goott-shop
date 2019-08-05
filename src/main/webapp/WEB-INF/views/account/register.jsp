<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
								<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기">
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
	
	<script>
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("roadAddress").value = roadAddr;
                document.getElementById("jibunAddress").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
	</script>
	
	<!--================End Login Box Area =================-->
	
	<jsp:include page="../include/footer.jsp"/>
	