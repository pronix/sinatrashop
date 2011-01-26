functions.order = {
	edit: function(order) {
		return '<b>Order: ' + order.id + '</b><br />'
			+ '<input name="email" value="' + order.email + '" />'
			+ ' &ndash; '
			+ '<input name="phone" value="' + order.phone + '" /><br />'
			+ 'Total: ' + order.total + '<br />'
			+ '<b>Billing</b><br />'
			+ order.bill_firstname + ' ' + order.bill_lastname + '<br />'
			+ order.bill_address1 + ' ' + order.bill_address2 + '<br />'
			+ order.bill_city + ' ' + order.bill_state + ', ' + order.bill_zipcode + '<br />'
			+ '<b>Shipping</b><br />'
			+ order.ship_firstname + ' ' + order.ship_lastname + '<br />'
			+ order.ship_address1 + ' ' + order.ship_address2 + '<br />'
			+ order.ship_city + ' ' + order.ship_state + ', ' + order.ship_zipcode + '<br />';
	},
	content: function(order) {
		return '<b>Order: ' + order.id + '</b><br />' + order.email + ' &ndash; ' + order.phone + '<br />'
			+ 'Total: ' + order.total + '<br />'
			+ '<b>Billing</b><br />'
			+ order.bill_firstname + ' ' + order.bill_lastname + '<br />'
			+ order.bill_address1 + ' ' + order.bill_address2 + '<br />'
			+ order.bill_city + ' ' + order.bill_state + ', ' + order.bill_zipcode + '<br />'
			+ '<b>Shipping</b><br />'
			+ order.ship_firstname + ' ' + order.ship_lastname + '<br />'
			+ order.ship_address1 + ' ' + order.ship_address2 + '<br />'
			+ order.ship_city + ' ' + order.ship_state + ', ' + order.ship_zipcode + '<br />'
			+ 'Total: ' + order.total;
	},
	empty: function() {
		return { 
			email: '',
			phone: '',
			bill_firstname: ''
		};	
	}
};

