var update_shipping = function() {
	var data = {};
	$('input.shipping, select.shipping').each(function(i, j) {
		data[$(j).attr('name').replace("[order]", '')] = $(j).val();
	}); 

	$.ajax({
		type: "POST",
		url: "/shipping_methods?" + Number(new Date()),
		data: JSON.stringify(data),
		beforeSend: function(xhr, i) {
			$('td#shipping_methods *').remove();
		},
		dataType: 'json',
		success: function(data) {
			$.each(data, function(i, e) {
				var label_node = $(document.createElement('label'))
					.html(e.name + ' $' + e.amount.toFixed(2));
				var radio_node = $(document.createElement('input'))
					.data('price', e.amount)
					.click(function() { update_totals(); })
					.attr('type', 'radio')
					.attr('name', 'order[shipping_method_id]')
					.val(e.id);
				var p_node = $(document.createElement('div'))
					.append(radio_node);
				$('td#shipping_methods').append(label_node);
				$('td#shipping_methods').append(p_node);
			});
			$('td#shipping_methods input:first').attr('checked', true);
			update_totals();
		},
		error: function(xhr, i, b) {
			var p_node = $(document.createElement('p'))
				.html('Sorry! We could not generate any shipping methods. Please try again.');
			$('td#shipping_methods').append(p_node);
		}

	});
};
var update_totals = function() {
	var subtotal = parseFloat($('span#subtotal').html().split(': $')[1]);
	var shipcost = $('td#shipping_methods input:checked').data('price');
	var total = subtotal + shipcost;
	if($('span#tax').length) {
		total += parseFloat($('span#tax').html().split(': $')[1]);
	}
	$('span#shipping_total').html('Shipping: $' + shipcost.toFixed(2));
	$('span#total').html('Total: $' + total.toFixed(2));
};

$(function() {
	$('input.shipping, select.shipping').each(function(i, j) {
		$(j).change(function() { update_shipping() });
	});
	update_shipping();
});

