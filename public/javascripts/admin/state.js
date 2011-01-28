functions.state = {
	edit: function(state) {
		return '<h4>Editing State:</h4>'
			+ '<p><label for="name">Name</label>'
			+ '<input type="text" name="name" value="' + state.name + '" /></p>'
			+ '<p><label for="abbr">Abbr</label>'
			+ '<input type="text" name="abbr" value="' + state.abbr + '" /></p>';
	},
	content: function(state) {
		return state.name + ' (' + state.abbr + ')<br />';
	},
	empty: function() {
		return { name: '', abbr: '' };
	}
};
