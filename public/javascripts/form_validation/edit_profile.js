$(document).ready(function() {
    validation_array = new Array(
        $("#profile_first_name"),
        $("#profile_last_name"),
        $("#profile_nick"),
        $("#profile_city"),
        $("#profile_state"),
        $("#profile_ntrp")
    );

    submit = $("#profile_submit");
    form = $(".edit_profile");

    check_field = function(field) {
        if (field.val().length > 0) {
			if (field.val().length > 20)
				return [false, "This field can be up to 20 characters!"];
			else
				return [true, ""];
		}
		else
			return [false, "This field cannot be empty!"]
    }

	after_submit = function() {}
})

