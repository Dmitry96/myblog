jQuery(function($){

	$(".deleteAction").click( function () {
		var current_post_tr = $(this).parents('td')[0];
		if(confirm("Are you sure?")){
			$.ajax({
						url: '/posts/' + $(current_post_tr).attr('data-post'),
						type: 'POST',
						data: { _method: 'DELETE' },
						success: function(result) {
							$(current_post).fadeOut(100);
							console.log(result);
						}
			});

		};

	});

});