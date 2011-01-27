var shipping_options = ['Calculator::FlatPercent', 'Calculator::FlatRate', 'Calculator::PerItem'];

functions.shipping_method = {
	edit: function(shipping_method) {
		var inner_html = '<h4>Editing Shipping Method: ' + shipping_method.id + '</h4>'
			+ '<p><label for="klass">Name</label>'
			+ '<select name="klass">'
		$.each(shipping_options, function(i, a) {
			inner_html += '<option value="' + a + '">' + a + '</option>';
		});
		inner_html += '</select></p>'
			+ '<p><label for="detail">Detail</label>'
			+ '<input type="text" name="detail" value="' + shipping_method.detail + '" /></p>';
		var match = '<option value="' + shipping_method.klass + '">';
		return inner_html.replace(match, '<option value="' + shipping_method.klass + '" selected="selected">');
	},
	content: function(shipping_method) {
		return '<h4>Shipping Method:' + shipping_method.id + '</h4>'
			+ shipping_method.klass + ' ' + shipping_method.detail + '<br />';
	},
	empty: function() {
		return { klass: '', detail: '' };
	}
};
