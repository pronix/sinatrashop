var functions = {};
var items = {};

YUI().use("node", "io", "json", function(Y) {
	var render_display_node = function(item, type) {
		var content = functions[type].content(item);
		var display_node = Y.Node.create('<div></div>')
			.set('innerHTML', content)
			.addClass("item" + item.id);
		display_node.append(edit_link(item));
		display_node.append(delete_link(item));
		return display_node;
	};
	var new_link = function() {
		var new_link_node = Y.Node.create('<a href="#">New</a>').addClass('new');;
		Y.on('click', function() { new_item(); }, new_link_node);
		return new_link_node;	
	};
	var update_link = function(item) {
		var update_link_node = Y.Node.create('<a href="#">Submit</a>').addClass(item.id);
		Y.on('click', Y.bind(update_item, item), update_link_node);
		return update_link_node;	
	};
	var close_link = function(item) {
		var close_link_node = Y.Node.create('<a href="#">X</a>').addClass(item.id);
		Y.on('click', Y.bind(close_item, item), close_link_node);
		return close_link_node;	
	};
	var delete_link = function(item) {
		var delete_link_node = Y.Node.create('<a href="#">Delete</a>').addClass(item.id);
		Y.on('click', Y.bind(delete_item, item), delete_link_node);
		return delete_link_node;	
	};
	var edit_link = function(item) {
		var edit_link_node = Y.Node.create('<a href="#">Edit</a>').addClass(item.id);
		Y.on('click', Y.bind(edit_item, item), edit_link_node);
		return edit_link_node;	
	};

	var update_item = function(e) {
		var type = Y.one('div.left a.selected').getAttribute('id');
		var node = e.currentTarget;
		var item = items["item" + node.getAttribute('class')]; 
		var config = { 
			method: 'POST',
   			headers: { 'Content-Type': 'application/json' },
			on: {
				success: Y.bind(function(oId, o) {
					var data = Y.JSON.parse(o.responseText);
					var item = data[type];
					if(Y.all('div.right div.item' + item.id).isEmpty()) {
						Y.one('div.right div.itemnew').replace(render_display_node(item, type));
						notify('created');
						Y.one('div.right').append(new_link());
					} else {
						Y.one('div.right div.item' + item.id).replace(render_display_node(item, type));
						notify('updated');
					}
					items["item" + item.id] = item;
				}),
				start: Y.bind(function(oId, o) {
					notify('<img src="/images/ajax-loader.gif" alt="working..." />');
				}),
				failure: Y.bind(function(oId, o) {
					if(o.responseText !== undefined){
						var errors = Y.JSON.parse(o.responseText);
						notify('<ul><li>' + errors.join('</li><li>') + '</li></ul>');
					}
				})
			}
   		};
		var data = {}; 
		Y.each(
			Y.all('div.item' + item.id + ' input'), 
			function(e, i, a) {
				data[e.getAttribute('name')] = e.get('value');
			},
		this);
		config.data = Y.JSON.stringify(data);

		Y.io("/admin/" + type + "/" + item.id, config);
	};
	var close_item = function(e) {
		var type = Y.one('div.left a.selected').getAttribute('id');
		var node = e.currentTarget;
		var item = items["item" + node.getAttribute('class')]; 
		var content = functions[type].content(item);
		Y.one('div.right div.item' + item.id).replace(render_display_node(item, type));
	};
	var delete_item = function(e) {
		var type = Y.one('div.left a.selected').getAttribute('id');
		var node = e.currentTarget;
		var item = items["item" + node.getAttribute('class')]; 
		var config = { 
			method: 'DELETE',
   			headers: { 'Content-Type': 'application/json' },
			on: {
				success: Y.bind(function(oId, o) {
					Y.one('div.right div.item' + item.id).remove();
					notify('deleted');
				}),
				start: Y.bind(function(oId, o) {
					notify('<img src="/images/ajax-loader.gif" alt="working..." />');
				}),
				failure: Y.bind(function(oId, o) {
					if(o.responseText !== undefined){
						var errors = Y.JSON.parse(o.responseText);
						notify('<ul><li>' + errors.join('</li><li>') + '</li></ul>');
					}
				})
			}
   		};
		Y.io("/admin/" + type + "/" + item.id, config);
	};
	var edit_item = function(e) {
		var type = Y.one('div.left a.selected').getAttribute('id');
		var node = e.currentTarget;
		var item = items["item" + node.getAttribute('class')]; 
		var content = functions[type].edit(item);
		var node = Y.one('div.item' + item.id).set('innerHTML', content);
		node.append(update_link(item));
		node.append(close_link(item));
	};
	var new_item = function() {
		var type = Y.one('div.left a.selected').getAttribute('id');
		var item = functions[type].empty();
		item.id = "new";
		items["itemnew"] = item;
		var content = functions[type].edit(item);
		var node = Y.Node.create('<div></div>')
			.addClass('itemnew')
			.set('innerHTML', content);
		Y.one('div.right a.new').replace(node);
		node.append(update_link(item));
		node.append(close_link(item));
	};

	var display_content = function(e) {
		var type = e.getAttribute('id');
		var config = { 
			method: 'GET',
   			headers: { 'Content-Type': 'application/json' },
			on: {
				success: Y.bind(function(oId, o) {
					var data = Y.JSON.parse(o.responseText);
					items = {};
					Y.one('div.right').set('innerHTML', '');
					Y.each(data, function(point, i, a) {
						var item = point[type]
						Y.one('div.right').append(render_display_node(item, type));
						items["item" + item.id] = item;
					});
					Y.one('div.right').append(new_link());
					notify('');
				}),
				start: Y.bind(function(oId, o) {
					notify('<img src="/images/ajax-loader.gif" alt="working..." />');
				}),
				failure: Y.bind(function(oId, o) {
					if(o.responseText !== undefined){
						var errors = Y.JSON.parse(o.responseText);
						notify('<ul><li>' + errors.join('</li><li>') + '</li></ul>');
					}
				})
			}
   		};
		Y.io("/admin/" + type, config);
	};

	var notify = function(message) {
		Y.one('div.message').set('innerHTML', message);
	};

	Y.on('domready', function() {
		Y.each(functions, function(e, i, a) {
			var nav_node = Y.Node.create('<a href="#">' + i + '</a>').setAttribute('id', i);
			Y.on('click', Y.bind(function(b) {
				var node = b.currentTarget;
				Y.all('div.left a').removeClass('selected');
				node.addClass('selected');
				display_content(node);
			}, this), nav_node); 
			Y.one('div.left').append(nav_node); 
		});
	});
});
