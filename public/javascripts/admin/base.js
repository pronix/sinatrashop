var functions = {};
var items = {};

$(function() {
	$.each(functions, function(e, i) {
		var display = e.charAt(0).toUpperCase() + e.slice(1);
		var display = display.replace('_', ' ');
		var nav_node = $('<a href="#">' + display + 's</a>')
			.attr('id', e)
			.click(function() {
				$('td.left a').not(this).removeClass('selected');
				$(this).addClass('selected');
				display_content(this); 
			});
		$('td.left').append(nav_node); 
	});
});

var render_display_node = function(item, type) {
	var content = functions[type].content(item);
	return $(document.createElement('div'))
		.html(content)
		.attr('id', "item" + item.id)
		.append(delete_link(item))
		.append(edit_link(item));
};

var new_link = function() {
	return $(document.createElement('a'))
		.html('New')
		.attr('href', '#')
		.addClass('new')
		.click(function() { new_item(this); });
};
var update_link = function(item) {
	return $(document.createElement('a'))
		.html('Update')
		.attr('href', '#')
		.addClass("item" + item.id)
		.click(function() { update_item(this); });
};
var close_link = function(item) {
	return $(document.createElement('a'))
		.html('Cancel')
		.attr('href', '#')
		.addClass("item" + item.id)
		.click(function() { close_item(this); });
};
var delete_link = function(item) {
	return $(document.createElement('a'))
		.html('Delete')
		.attr('href', '#')
		.addClass("item" + item.id)
		.click(function() { delete_item(this); });
};
var edit_link = function(item) {
	return $(document.createElement('a'))
		.html('Edit')
		.attr('href', '#')
		.addClass("item" + item.id)
		.click(function() { edit_item(this) });
};

var update_item = function(node) {
	var type = $('td.left a.selected').attr('id');
	var item = items[$(node).attr('class')]; 
	var data = {};
	$('div#item' + item.id + ' input, div#item' + item.id + ' textarea, div#item' + item.id + ' select').each(function(i, j) {
		data[$(j).attr('name')] = $(j).val();
	});
	$.ajax({
		type: "POST",
		url: "/admin/" + type + "/" + item.id,
		data: JSON.stringify(data),
		beforeSend: function(xhr, i) {
			notify('<img src="/images/ajax-loader.gif" alt="working..." />');
		},
		success: function(data) {
			var item = data[type];
			if($('td.right div#item' + item.id).length == 0) {
				$('td.right div#itemnew').replaceWith(render_display_node(item, type));
				notify('Created');
				$('td.right').append(new_link());
			} else {
				$('td.right div#item' + item.id).replaceWith(render_display_node(item, type));
				notify('updated');
			}
			items["item" + item.id] = item;
		},
		dataType: "json",
		error: function(xhr, i, b) {
			var data = $.parseJSON(xhr.responseText);
			notify('<ul><li>' + data.join('</li><li>') + '</li></ul>');
		} 
	});
};

var close_item = function(node) {
	var type = $('td.left a.selected').attr('id');
	var item = items[$(node).attr('class')];
	var content = functions[type].content(item);
	if(item.id == 'new') {
		$('td.right div#itemnew').remove();
		$('td.right').append(new_link());
	} else {
		$('td.right div#item' + item.id).replaceWith(render_display_node(item, type));
	}
};

var delete_item = function(node) {
	var type = $('td.left a.selected').attr('id');
	var item = items[$(node).attr('class')];
	$.ajax({
		type: "DELETE",
		url: "/admin/" + type + "/" + item.id,
		beforeSend: function(xhr, i) {
			notify('<img src="/images/ajax-loader.gif" alt="working..." />');
		},
		success: function(data) {
			$('td.right div#item' + item.id).remove();
			notify('deleted');
		},
		dataType: "json",
		error: function(xhr, i, b) {
			var data = $.parseJSON(xhr.responseText);
			notify('<ul><li>' + data.join('</li><li>') + '</li></ul>');
		} 
	});
};

var edit_item = function(node) {
	var type = $('td.left a.selected').attr('id');
	var item = items[$(node).attr('class')]; 
	var content = functions[type].edit(item);
	var enode = $('div#item' + item.id).html(content);
	enode.append(update_link(item));
	enode.append(close_link(item));
};
var new_item = function() {
	var type = $('td.left a.selected').attr('id');
	var item = functions[type].empty();
	item.id = "new";
	items["itemnew"] = item;
	var content = functions[type].edit(item);
	var node = $(document.createElement('div'))
		.attr('id', 'itemnew')
		.html(content)
		.append(update_link(item))
		.append(close_link(item));
	$('td.right a.new').replaceWith(node);
};

var display_content = function(node) {
	var type = $(node).attr('id');
	$.ajax({
		url: "/admin/" + type,
		beforeSend: function(xhr, i) {
			notify('<img src="/images/ajax-loader.gif" alt="working..." />');
		},
		success: function(data) {
			items = {};
			$('td.right').html('');
			$.each(data, function(i, point) {
				var item = point[type]
				items["item" + item.id] = item;
				$('td.right').append(render_display_node(item, type));
			});
			$('td.right').append(new_link());
			$('td.right div:odd').addClass('odd');
			notify('');
		},
		dataType: "json",
		error: function(xhr, i, b) {
			var data = $.parseJSON(xhr.responseText);
			notify('<ul><li>' + data.join('</li><li>') + '</li></ul>');
		} 
	});
};

var notify = function(message) {
	$('td.message').html(message);
};

