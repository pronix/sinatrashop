functions.product = {
	edit: function(product) {
		return '<h4>Editing Product: ' + product.id + '</h4>'
			+ '<p><label for="name">Name</label>'
			+ '<input type="text" name="name" value="' + product.name + '" /></p>'
			+ '<p><label for="price">Price</label>'
			+ '<input type="text" name="price" value="' + parseFloat(product.price).toFixed(2) + '" /></p>'
			+ '<p><label for="description">Description</label>'
			+ '<textarea name="description">' + product.description + '</textarea></p>';
	},
	content: function(product) {
		var inner_html = '<h4>Product: ' + product.id + '</h4>'
			+ 'Name: ' + product.name
			+ '<br />Price: $' + parseFloat(product.price).toFixed(2)
			+ '<br />Description: ' + product.description + '<br />';
		return inner_html;
	},
	empty: function() {
		return { name: '', price: 0, description: '' };	
	}
};
