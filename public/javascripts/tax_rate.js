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
			if(data && data > 0) {
				if($('span#tax').length > 0) {
					$('span#tax').html('Est. Tax: $' + data.toFixed(2));
				} else {
					$(document.createElement('span'))
						.attr('id', 'tax')
						.html('Est. Tax: $' + data.toFixed(2))
						.insertBefore('span#total');
				}	
			} else {
				$('span#tax').remove();
			}
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

