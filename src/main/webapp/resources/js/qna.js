$(function() {

	$('#qaselectcategory').on('change', function(event) {

		this.form.submit();

	});
});



$(function(){
    $("#description").summernote({
        height : 300,
        width : 800
    });
});