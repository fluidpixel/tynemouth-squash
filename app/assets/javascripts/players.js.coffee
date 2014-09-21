jQuery ->
	$("#player_search_form input").keyup ->
		$.get $("#player_search_form").attr("action"), $("#player_search_form").serialize(), null, "script"
		false
	$("button.clear").click ->
		$('#player_search').val('');
		$.get $("#player_search_form").attr("action"), $("#player_search_form").serialize(), null, "script"
		false
	 # $("#player_search_form").submit ->
 # 	   $.get @action, $(this).serialize(), null, "script"
 # 	   false

	# $('#player_search').autocomplete
	# source: $('#player_search').data('autocomplete-source')
