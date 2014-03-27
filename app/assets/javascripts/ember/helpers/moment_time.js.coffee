Ember.Handlebars.registerBoundHelper 'momentTime', (hour) ->
	moment(hour).fromNow()