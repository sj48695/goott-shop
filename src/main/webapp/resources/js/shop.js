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
				var result = "<img width='200' height='200' src='" + e.target.result + "'>";
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