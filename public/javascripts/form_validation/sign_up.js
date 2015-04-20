Name$(document).ready(function() {
    validation_array = new Array(
        $("#user_email"),
        $("#user_password"),
        $("#user_password_confirmation")
    );

    submit = $("#user_submit");
    form = $(".registration_form");

    check_field = function(field) {
		var val = field.val();
		var id = field.attr("id");

		if (val.length > 0) {
			if (id == "user_email") {
				if (val.length > 50)
					return [false, "This field can contain a maximum of 50 characters"];
				var pattern = new RegExp(/^(("[\w-\s]+")|([\w-]+(?:\.[\w-]+)*)|("[\w-\s]+")([\w-]+(?:\.[\w-]+)*))(@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$)|(@\[?((25[0-5]\.|2[0-4][0-9]\.|1[0-9]{2}\.|[0-9]{1,2}\.))((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\.){2}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\]?$)/i);
				if (pattern.test(val))
					return [true, ""];
				else
					return [false, "Invalid Email Address!"]
			}
			else if (id == "user_password" || id == "user_password_confirmation") {
				if (val.length > 20)
					return [false, "This field can contain up to 20 characters!"];
				else if (val.length < 6)
					return [false, "This field must have at least 6 characters!"];
				else
					return [true, ""]
			}
			else
				return [true, ""];
		}
		else
			return [false, "This field cannot be empty!"]
    }

	after_submit = function() {
        if ($("#user_password").val() != $("#user_password_confirmation").val()) {
			$("#user_password").addClass('error');
			$("#user_password_confirmation").addClass('error');
			$("#form_error").html("<p class='fields_error_msg'>Hasło i potwierdzenie nie są takie same!</p>");
		}
		else {
			$("#form_error").html("");
		}
    }
})

