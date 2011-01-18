functions.page = {
	edit: function(page) {
		return '<h4>Editing Page: ' + page.id + '</h4>'
			+ '<p><label for="title">Title</label>'
			+ '<input type="text" name="title" value="' + page.title + '" /></p>'
			+ '<p><label for="slug">Slug</label>'
			+ '<input type="text" name="slug" value="' + page.slug + '" /></p>'
			+ '<p><label for="content">Content</label>'
			+ '<textarea name="content">' + page.content + '</textarea></p>';
	},
	content: function(page) {
		return '<h4>Page: ' + page.slug + '</h4>'
			+ 'Title: ' + page.title + ' (' + page.slug + ')<br />';
	},
	empty: function() {
		return { title: '', slug: '', content: '' };	
	}
};
