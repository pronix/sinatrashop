var login = function() {
	var data = {};
	$('div#login_fields input').each(function(i, j) {
		data[$(j).attr('name')] = $(j).val();
	});
	$.ajax({
		type: "POST",
		url: "/login.json?" + Number(new Date()),
		data: JSON.stringify(data),
		dataType: 'json',
		success: function(data) {
			if($('#cart').length) {
				$('div#guest,div#login_fields,div#create_fields').remove();
				$('td#userauth')
					.append($(document.createElement('span'))
						.attr('id', 'username')
						.html('Welcome ' + data + '!'))
					.append($(document.createElement('a'))
						.html('Log Out')
						.attr('href', '#')
						.click(function() { logout(); }));
			} else {
				document.location = '/';
			}
		},
		error: function(xhr, i, b) {
			alert('sorry fail login');
		}
	});
};
var create_account = function() {
	var data = {};
	$('div#create_fields input').each(function(i, j) {
		data[$(j).attr('name')] = $(j).val();
	});
	$.ajax({
		type: "POST",
		url: "/create_account.json?" + Number(new Date()),
		data: JSON.stringify(data),
		dataType: 'json',
		success: function(data) {
			if($('#cart').length) {
				$('div#guest,div#login_fields,div#create_fields').remove();
				$('td#userauth')
					.append($(document.createElement('span'))
						.attr('id', 'username')
						.html('Welcome ' + data + '!'))
					.append($(document.createElement('a'))
						.html('Log Out')
						.attr('href', '#')
						.click(function() { logout(); }));
			} else {
				document.location = '/';
			}
		},
		error: function(xhr, i, b) {
			alert($.parseJSON(xhr.responseText));
		}

	});
};
var logout = function() {
	$.ajax({
		type: "POST",
		url: "/logout.json?" + Number(new Date()),
		dataType: 'json',
		success: function(data) {
			//reload page
			document.location = '/cart';
		},
		error: function(xhr, i, b) {
			alert('fail login');
		}
	});
};

$(function() {
	$('input#login').click(function() {
		login();
		return false;
	});
	$('input#create_account').click(function() {
		create_account();
		return false;
	});
	$('a#logout').click(function() {
		logout();	
	});
});
