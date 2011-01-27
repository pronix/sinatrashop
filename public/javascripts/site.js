$(function() {
	if($('input#previous_selection').length > 0) {
		$('div.product input.' + $('input#previous_selection').val()).attr('checked', true);
	}
	var obj;
	if($('input:radio:checked').length) {
		obj = $('input:radio:checked');
	} else {
		obj = $('input:radio').first();
		$(obj).attr('checked', true);
	}
	$(obj).parent().addClass('selected');
	update_price();
	$('div.product').mouseover(function() {
		$(this).addClass('hovered');
	}).mouseout(function() {
		$(this).removeClass('hovered');
	}).click(function() {
		$(this).find('input').attr('checked', true);
		$('div.product').not(this).removeClass('selected');
		$(this).addClass('selected');
		update_price();
	});
});

var update_price = function() {
	$('label#price_display').html($('input:radio:checked').parent().find('h2 span').html());
};
