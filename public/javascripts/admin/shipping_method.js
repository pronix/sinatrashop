functions.shipping_method = {
	edit: function(shipping_method) {
		return '<label for="klass">Name</label>'
			+ '<input type="text" name="klass" value="Calculator::FlatRate" />'
			+ '<label for="detail">Detail</label>'
			+ '<input type="text" name="detail" value="' + shipping_method.detail + '" />';
	},
	content: function(shipping_method) {
		var inner_html = shipping_method.klass + ' ' + shipping_method.detail;
		return inner_html;
	},
	empty: function() {
		return { klass: '', detail: '' };
	}
};
