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
