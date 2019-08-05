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


function removeCart(cartNo){
	if(confirm('선택된 상품을 삭제할까요?')){
		$.ajax({
			url:"/shop/cart_remove",
			methos:"GET",
			data:{"cartNo" : cartNo},
			success:function(data, status, xhr){
				alert("장바구니에서 삭제되었습니다.");
				$('.cartlist'+cartNo).remove();
			},
			error:function(status, xhr, err){
				alert(err);
			}
		});
	}
}

/* 체크박스 전체선택, 전체해제 */
function checkAll(){
      if( $("#th_checkAll").is(':checked') ){
        $("input[name=checkRow]").prop("checked", true);
      }else{
        $("input[name=checkRow]").prop("checked", false);
      }
}

/* 체크박스 선택, 해제 */
function checkRow(){
    var checkRows = Array();
	$('input:checkbox[name="checkRow"]').each(function() {
	    var checkRow = $(this).val();
	    if(this.checked){//checked 처리된 항목의 값
	        checkRows.push(checkRow);
	    }
	});

	
    $("#checkRows").attr("value",checkRows);
}