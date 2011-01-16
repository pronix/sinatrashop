functions.product = {
	edit: function(product) {
		return '<label for="name">Name</label>'
			+ '<input type="text" name="name" value="' + product.name + '" />'
			+ '<label for="price">Price</label>'
			+ '<input type="text" name="price" value="' + product.price + '" />'
			+ '<label for="description">Description</label>'
			+ '<input type="text" name="description" value="' + product.description + '" />';
	},
	content: function(product) {
		var inner_html = product.name + ' ' + product.price + ' ' + product.description;
		return inner_html;
	},
	empty: function() {
		return { name: '', price: '', description: '' };	
	}
};
