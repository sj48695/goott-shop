$(function() {
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

/* 체크박스 전체선택, 전체해제 */
function checkAll(){
      if( $("#th_checkAll").is(':checked') ){
        $("input[name=checkRow]").prop("checked", true);
      }else{
        $("input[name=checkRow]").prop("checked", false);
      }
}
