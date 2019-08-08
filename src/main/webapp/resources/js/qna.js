$(function() {

	$('#qaselectcategory').on('change', function(event) {

		this.form.submit();

	});
});

//브라우저가 html을 모두 읽고 처리할 준비가 되었을 때 호출 할 함수 지정
window.addEventListener('load',function(event) {//js의 main 함수 역할
	var btnCancel = document.querySelector('#cancel_button');
	btnCancel.addEventListener('click', function(event) {
		//location.href = "list";//주소창에 list.action을 입력하고 엔터
		history.back(); //브라우저의 이전 버튼을 클릭
	});
});


function secureSubmit(){
		var pwd = prompt('[ 비밀글 ]\n\
				SECRET WRITING\
				안전한 글 접속을 위해 작성하신 비밀번호를 입력해주세요!','');
//	$.ajax({
//		url:"/shop/securePwd",
//		methos:"GET",
//		data:{"pwd":pwd},
//		success:function(data, status, xhr){
//			alert("장바구니에서 삭제되었습니다.");
//			var cartNo = cartNoList.split(',');
//			for(var i=0;i<cartNo.length;i++){
//				$('.cartlist'+cartNo[i]).remove();
//			}
//		},
//		error:function(status, xhr, err){
//			alert(err);
//		}
//	});
	
}





