YUI().use("node", "io", "json", "cookie", function(Y) {
	var request_shipping = function(e) {
		var config = { 
			method: 'POST',
   			headers: { 'Content-Type': 'application/json' },
			on: {
				start: Y.bind(function(oId, o) {
					Y.all('td#shipping_methods .dynamo').remove();
				}),
				success: Y.bind(function(oId, o) {
					var data = Y.JSON.parse(o.responseText);
					Y.each(data, function(e, i, b) {
						var label_node = Y.Node.create('<label></label>')
							.setContent(e.name + ' ' + e.amount);
						var radio_node = Y.Node.create('<input />')
							.setAttribute('type', 'radio')
							.setAttribute('name', 'order[shipping_method_id]')
							.set('val', e.id);
						var p_node = Y.Node.create('<p></p>')
							.addClass('dynamo')
							.append(label_node)
							.append(radio_node);
						Y.one('td#shipping_methods').append(p_node);
					});		
				}),
				failure: Y.bind(function(oId, o) {
					var p_node = Y.Node.create('<p></p>')
						.setContent('Sorry! We could not generate any shipping methods. Please try again.')
						.addClass('dynamo');
				})
			}
   		};
		var data = {}; 
		Y.each(
			Y.all('input.shipping, select.shipping'),
			function(e, i, a) {
				data[e.getAttribute('name')] = e.get('value');
			},
		this);
		data.cart = Y.Cookie.get('cart');
		config.data = Y.JSON.stringify(data);

		Y.io("/shipping_methods", config);
	};
	Y.on('domready', function() {
		Y.one('#update_shipping').on('click', function(event) {
			request_shipping();
			event.halt(); 
		});
		request_shipping();
	});
});
