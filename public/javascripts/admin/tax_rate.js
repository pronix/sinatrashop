tax_rate_states = {};

functions.tax_rate = {
	edit: function(tax_rate) {
		var edit_content = '<h4>Editing Tax Rate:</h4>'
			+ '<p><label for="state_id">State</label>'
			+ '<select name="state_id">';
		$.each(tax_rate_states, function(i, e) {
			edit_content += '<option value="' + i.replace(/^state/, '') + '">' + e + '</option>';
		});
		edit_content += '</select>'
			+ '<p><label for="rate">Rate</label>'
			+ '<input type="text" name="rate" value="' + tax_rate.rate + '" /></p>';
		alert(edit_content);
		return edit_content;
	},
	content: function(tax_rate) {
		return tax_rate_states["state" + tax_rate.state_id] + ' (' + tax_rate.rate + ')<br />';
	},
	empty: function() {
		return { state_id: '', rate: '' };
	},
	extra_action: function() {
		$.ajax({
			url: "/admin/state",
			success: function(data) {
				$.each(data, function(i, e) {
					tax_rate_states["state" + e.state.id] = e.state.name; 
				});
			},
			dataType: "json"
		});

	}
};
