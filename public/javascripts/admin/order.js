functions.order = {
	edit: function(order) {
		return '<label for="email">Email</label>'
			+ '<input type="text" name="email" value="' + order.email + '" />'
			+ '<label for="phone">Phone</label>'
			+ '<input type="text" name="phone" value="' + order.phone + '" />';
	},
	content: function(order) {
		var inner_html = 'Order: ' + order.id + ' ' + order.email + ' ' + order.phone + '<br />'
			+ order.bill_firstname + ' ' + order.bill_lastname + '<br />'
			+ order.bill_address1 + ' ' + order.bill_address2 + '<br />'
			+ order.bill_city + ' ' + order.bill_state + ', ' + order.bill_zipcode + '<br />'
			+ order.ship_firstname + ' ' + order.ship_lastname + '<br />'
			+ order.ship_address1 + ' ' + order.ship_address2 + '<br />'
			+ order.ship_city + ' ' + order.ship_state + ', ' + order.ship_zipcode + '<br />'
			+ 'Product: ' + order.product_id;
		return inner_html;
	},
	empty: function() {
		return { 
			email: '',
			phone: '',
			bill_firstname: ''
		};	
	}
};

