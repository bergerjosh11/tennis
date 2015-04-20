$(document).ready(function() {    
    function validate_field(field) {
		var check = check_field(field);
        if (!check[0]) {
            field.addClass("error");
			add_error_msg(field, check[1])
            return false;
        }
        else {
            field.removeClass("error");
			remove_error_msg(field);
            return true;
        }
    }
	
	function add_error_msg(field, msg) {
		var error_msg = $("#" + field.attr("id") + "_error");
		error_msg.html(msg);
	}
	
	function remove_error_msg(field){
		var error_msg = $("#" + field.attr("id") + "_error");
		error_msg.html("");
	}
    
    function validate_form(fields) {
        var valid = true;
        
        $.each(fields, function(index, value) {
            valid &= validate_field(value);
        })
        
        return valid;
    }
    
    $.each(validation_array, function(index, value) {
        value.addClass("validatable_field");
    })
    
    $(".validatable_field").focusout(function() {
        validate_field($(this));
    })

    $(".validatable_field").focusin(function() {
        $(this).removeClass("error");
		remove_error_msg($(this));
    })    
    
    form.submit(function() {
		after_submit();
        if (!validate_form(validation_array))
            return false;
    })
})

