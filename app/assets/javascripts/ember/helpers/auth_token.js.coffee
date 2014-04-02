Ember.Handlebars.registerBoundHelper 'authToken', ->
	$('meta[name="csrf-token"]').attr('content')