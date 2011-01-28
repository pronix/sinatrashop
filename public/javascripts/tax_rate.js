var update_tax = function() {
	var data = {};
	$('input.shipping, select.shipping').each(function(i, j) {
		data[$(j).attr('name').replace("[order]", '')] = $(j).val();
	}); 

	$.ajax({
		type: "POST",
		url: "/tax_rate?" + Number(new Date()),
		data: JSON.stringify(data),
		dataType: "json",
		beforeSend: function(xhr, i) {
			//beforeSend
		},
		success: function(data) {
			//alert(data);
		},
		error: function(xhr, i, b) {
			//error here
		}

	});
};

$(function() {
	$('input.shipping, select.shipping').each(function(i, j) {
		$(j).change(function() { update_tax() });
	});
	update_tax();
});

