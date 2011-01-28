var update_shipping = function() {
	var data = {};
	$('input.shipping, select.shipping').each(function(i, j) {
		data[$(j).attr('name').replace("[order]", '')] = $(j).val();
	}); 

	$.ajax({
		type: "POST",
		url: "/shipping_methods?" + Number(new Date()),
		data: JSON.stringify(data),
		dataType: "json",
		beforeSend: function(xhr, i) {
			$('td#shipping_methods .dynamo').remove();
		},
		success: function(data) {
			$.each(data, function(i, e) {
				var label_node = $(document.createElement('label'))
					.html(e.name + ' ' + e.amount);
				var radio_node = $(document.createElement('input'))
					.attr('type', 'radio')
					.attr('name', 'order[shipping_method_id]')
					.val(e.id);
				var p_node = $(document.createElement('p'))
					.addClass('dynamo')
					.append(label_node)
					.append(radio_node);
				$('td#shipping_methods').append(p_node);
			});
		},
		error: function(xhr, i, b) {
			var p_node = $(document.createElement('p'))
				.html('Sorry! We could not generate any shipping methods. Please try again.')
				.addClass('dynamo');
			$('td#shipping_methods').append(p_node);
		}

	});
};

$(function() {
	//$('#update_shipping').on('click', update_shipping());
	$('input.shipping, select.shipping').each(function(i, j) {
		$(j).change(function() { update_shipping() });
	});
	update_shipping();
});

