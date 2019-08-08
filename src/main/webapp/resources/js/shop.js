/* ----------- Img preview ---------- */
function readURL(input,target) {
	if (input.files && input.files[0]) {
		var imgfiles = [];
		var files = input.files;
		var filesArr = Array.prototype.slice.call(files);
		
		var index = 0;
		filesArr.forEach(function(f){
			if(!f.type.match("image.*")){
				alert("확장자는 이미지 확장자만 가능합니다.");
				return;
			}
			
			imgfiles.push(f);
			
			var reader = new FileReader();
			reader.onload = function(e) {
				var result = "<img class='fileImg' src='" + e.target.result + "'>";
				target.append(result);
				console.log(result);
				index++;
			}
			reader.readAsDataURL(f);
			
		});
		
	}
}

/* ----------- product (write, update) ---------- */
$(function () {

	/* ----------- Img preview ---------- */
	$("#writeForm").on("change", "#titleImgFile", function (event) {
		$('.inner_img').empty();
		readURL(this, $(".inner_img"));
	});
	$("#writeForm").on("change", "#imgFile", function (event) {
		$('.inner_imgs').empty();
		readURL(this, $(".inner_imgs"));
	});

	$("#updateForm").on("change", "#titleImgFile", function (event) {
		$(".inner_img").empty();
	    readURL(this, $(".inner_img"));
	});
	$("#updateForm").on("change", "#imgFile", function (event) {
	    readURL(this, $(".inner_imgs"));
	});


	//이미지 삭제
	$('.img-wrap .close').on('click', function() {
		var productFileNo = $(this).attr('data-fileNo');
		var deleteBtn = $(this).parent().parent();
		$.ajax({
			url: "/shop/manager/delete-file",
			method: "GET",
			data: {"productFileNo" : productFileNo },
			success: function(data, status, xhr){
				deleteBtn.remove();
			},
			error: function(xhr, status, err){
				alert('삭제 실패');
			}
		});
	   
	});
});

$(function(){
	$('#category_form').on('change', function(event){
		this.form.submit();
	});
});

/*var currentPosition = parseInt($("#detail_box").css("top")); 
$(window).scroll(function() { 
	// 현재 스크롤 위치
	var scrollPosition = $(window).height() + $(window).scrollTop();
	var position = $(document).scrollTop(); 
	$("#detail_box").stop().animate({"top":position+currentPosition+"px"},1000); 
	
});*/


$(function() {
	
	$('.quantityUp').on('click',function(event) {
		var result = document.getElementById('sst');
		var sst = result.value;
		if (!isNaN(sst))
			result.value++;
		return false;
	});

	$('.quantityDown').on('click',function(event) {
		var result = document.getElementById('sst');
		var sst = result.value;
		if (!isNaN(sst) && sst > 0)
			result.value--;
		return false;
	});
	
	$('.addToCart').on('click', function(event) {		
		var formData = $('#addCartForm').serialize();
		$.ajax({
			url:"/shop/cart_register",
			methos:"GET",
			data:formData,
			success:function(data, status, xhr){
				var ok = confirm('장바구니에 추가되었습니다. 장바구니를 확인하시겠습니까?');
				if (ok) {
					window.location.href = "/shop/cart";
				}
			},
			error:function(status, xhr, err){
				alert("장바구니에 추가할 수 없습니다.\n" + err);
			}
		});
	});
	
	

});

/*---------------------category.jsp----------------------*/


function category(){
	var formData = $(this).serialize();
	$.ajax({
		url:"/shop/category/search",
		method:"GET",
		data : formData,
		success: function(data, xhr, status){
			console.log(data);
			$('.category-list').load(data);
		},
		error:function(xhr, status, err){
			alert(err);
		}
	});
	
	var formData = $(this).serialize();
	$.ajax({
		url:"/shop/category/search",
		method:"GET",
		data : formData,
		success: function(data, xhr, status){
			console.log(data);
			$('.category-list').load(data);
		},
		error:function(xhr, status, err){
			alert(err);
		}
	});
}

/*---------------------cart.jsp----------------------*/

function increase(cartNo, price) {
	var result = document.getElementById('sst'+cartNo);
	var sst = result.value;
	if (!isNaN(sst)){
		result.value++;
		$.ajax({
			url:"/shop/cart_cntupdate",
			methos:"GET",
			data:{
				"cartNo" : cartNo,
				"count" : result.value,
				"price" : price,
				"total_before" : $('#total_before'+cartNo).attr("value"),
				"subtotal_before" : $('#subtotal_before').attr("value")
			},
			success:function(data, status, xhr){
				var datas = data.split("/");
				$('.total'+cartNo).text(datas[0]+"원");
				$('.subtotal').text(datas[1]+"원");
			},
			error:function(status, xhr, err){
				alert(err);
			}
		});
	}
	return false;
}

function reduced(cartNo, price) {
	var result = document.getElementById('sst'+cartNo);
	var sst = result.value;
	if (!isNaN(sst) && sst > 0){
		result.value--;
		$.ajax({
			url:"/shop/cart_cntupdate",
			methos:"GET",
			data:{
				"cartNo" : cartNo,
				"count" : result.value,
				"price" : price,
				"total_before" : $('#total_before'+cartNo).attr("value"),
				"subtotal_before" : $('#subtotal_before').attr("value")
			},
			success:function(data, status, xhr){
				var datas = data.split("/");
				$('.total'+cartNo).text(datas[0]+"원");
				$('.subtotal').text(datas[1]+"원");
			},
			error:function(status, xhr, err){
				alert(err);
			}
		});
	}
	return false;
}


function removeCart(cartNoList){
	
	if(confirm('선택된 상품을 삭제할까요?')){
		$.ajax({
			url:"/shop/cart_remove",
			methos:"GET",
			data:{"cartNoList":cartNoList},
			success:function(data, status, xhr){
				alert("장바구니에서 삭제되었습니다.");
				var cartNo = cartNoList.split(',');
				for(var i=0;i<cartNo.length;i++){
					$('.cartlist'+cartNo[i]).remove();
				}
			},
			error:function(status, xhr, err){
				alert(err);
			}
		});
	}
}

/* 체크박스 전체선택, 전체해제 */
function checkAll(rows){
      if( $("#th_checkAll").is(':checked') ){
        $("input[name=checkRow]").prop("checked", true);
        //$("#checkRows").attr("value",rows);
        $('#delete').attr('onclick','javascript:removeCart(' + rows + ')');
        $('#buy').attr('href','/shop/checkout/cart/' + rows);
      }else{
        $("input[name=checkRow]").prop("checked", false);
        //$("#checkRows").attr("value",'');
        $('#delete').attr('onclick','alert("상품을 선택해주세요")');
        $('#buy').attr('onclick','alert("상품을 선택해주세요")');
        $('#buy').attr('href','#');
      }
}

/* 체크박스 선택, 해제 */
function checkRow() {
	var checkRows = Array();
	$('input:checkbox[name="checkRow"]').each(function() {
		var checkRow = $(this).val();
		if (this.checked) {// checked 처리된 항목의 값
			checkRows.push(checkRow);

		}
		$("#checkRows").attr("value", checkRows);
		if (checkRows != null) {
			$('#delete').attr('onclick', 'javascript:removeCart(' + checkRows + ')');
			$('#buy').attr('onclick', '');
			$('#buy').attr('href', '/shop/checkout/cart/' + checkRows);
			
			if($("#checkRows").attr("value") == ''){
				$('#delete').attr('onclick', 'alert("상품을 선택해주세요")');
				$('#buy').attr('onclick', 'alert("상품을 선택해주세요")');
				$('#buy').attr('href', '#');
			}
		}
	});
}


/*---------------------checkout.jsp----------------------*/

/* 주문자 정보 동일 */
function checkBuy(my) {
	if (my.checked) {
		$('#name_to').attr('value', $('#name_from').attr('value'));
		$('#phone_to').attr('value', $('#phone_from').attr('value'));
		$('#postcode').attr('value', $('#postCode_from').attr('value'));
		$('#roadAddress').attr('value', $('#roadAddr_from').attr('value'));
		$('#jibunAddress').attr('value', $('#jibunAddr_from').attr('value'));
		$('#detailAddress').attr('value', $('#detailAddr_from').attr('value'));
		$('#extraAddress').attr('value', $('#extraAddr_from').attr('value'));
	}else{
		$('#name_to').attr('value', '');
		$('#phone_to').attr('value', '');
		$('#postcode').attr('value', '');
		$('#roadAddress').attr('value', '');
		$('#jibunAddress').attr('value', '');
		$('#detailAddress').attr('value', '');
		$('#extraAddress').attr('value', '');
	}
}


/*---------------------주소----------------------*/
daum.postcode.load(function(){
	
    //load함수를 이용하여 core스크립트의 로딩이 완료된 후, 우편번호 서비스를 실행합니다.
    $(".addrBtn").on("click",function (){
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
            }
        }).open();
    });
});

/* ----------- Review ---------- */
$(function () {
	var productNo = $('#reviewform #productNo').val();
	$('#writereview').on('click', function (event) {
		
		//serialize   -   form에 포함된 입력요소의 값을 이름=값&이름=값...형식으로 만드는 함수
		var formData = $('#reviewform').serialize();
		
		$.ajax({
			url: "/shop/review/write-review",
			method: "POST",
			data: formData,
			success: function (data, status, xhr) {
				$('textarea').val();
				alert("댓글 등록");
				$("#review-list").load('/shop/review/review-list',
					{ "productNo": productNo },
					function () {
						$('#productNo').attr("value", productNo);
					});
			},
			error: function (xhr, status, err) {
				alert(err);
			}
		});
	});

	var currentreviewNo = -1;
	
	$('#review-list').on('click', '.editreview', function (event) {
		reviewNo = $(this).attr('data-reviewno');
		$('.collapse').collapse('hide');
		
		if (currentreviewNo != -1) {
			$('#reviewview' + currentreviewNo).css('display', '');
			$('#reviewedit' + currentreviewNo).css('display', 'none');
		}
		$('#reviewview' + reviewNo).css('display', 'none');
		$('#reviewedit' + reviewNo).css('display', '');
		currentreviewNo = reviewNo;
	});

	$('#review-list').on('click', '.cancel', function (event) {
		reviewNo = $(this).attr('data-reviewno');
		$('#reviewview' + reviewNo).css('display', '');
		$('#reviewedit' + reviewNo).css('display', 'none');
		currentreviewNo = -1;
	});

	$('#review-list').on('click', '.deletereview', function (event) { //새로 만들어지는 객체에도 이벤트를 적용시키도록 하는 것??
		reviewNo = $(this).attr('data-reviewno');
		$.ajax({
			url: "/shop/review/delete-review",
			method: "GET",
			data: "reviewNo=" + reviewNo,
			success: function (data, status, xhr) {
				if (data == 'success') {
					$('#tr' + reviewNo).remove();
					alert('삭제했습니다');
				}
				else alert('삭제실패');
			},
			error: function (xhr, status, err) {
				console.log(err);
			}
		});
	});

	$('#review-list').on('click', '.updatereview', function (event) {
		//현재 클릭된 <a 의 data-reviewno 속성 값 읽기
		var reviewNo = $(this).attr('data-reviewno');
		var content = $('#updateform' + reviewNo + ' textarea').val();
		var inputData = $('#updateform' + reviewNo).serialize();

		//ajax 방식으로 데이터 수정
		$.ajax({
			"url": "/shop/review/update-review",
			"method": "POST",
			"data": inputData,
			"success": function (data, status, xhr) {
				alert('댓글을 수정했습니다.');
				var span = $('#reviewview' + reviewNo + ' span');
				span.html(content.replace(/\n/gi, '<br>'));
				//view-div는 숨기고, edit-div는 표시하기   
				$('#reviewview' + reviewNo).css('display', 'block');
				$('#reviewedit' + reviewNo).css('display', 'none');
			},
			"error": function (xhr, status, err) {
				alert('댓글 수정 실패');
			}
		});
	});

	$('#write-comment').on('click', function (event) {
		var reviewNo = $(this).attr('data-reviewno');
		var content = $('#comment-form textarea').val();
		if (content.length == 0) return;

		var commentData = $('#comment-form').serialize();

		$.ajax({
			url: "/shop/review/write-comment",
			method: "POST",
			data: commentData,
			success: function (data, status, xhr) {
				alert('댓글을 달았습니다.');
				$('#comment-collapse' + reviewNo).collapse('hide'); //hide bootstrap modal
				$('#comment-form').each(function () {
					this.reset();
				});
				
				$("#review-list").load('/shop/review/review-list',
						{ "productNo": productNo },
						function () {
							$('#productNo').attr("value", productNo);
//							$('#star').attr("id","star"+productNo);
//							$('#star_input').attr("id","star_input"+productNo);
						});
			},
			error: function (xhr, status, err) {
				alert('fail');
			}
		});
	});
});