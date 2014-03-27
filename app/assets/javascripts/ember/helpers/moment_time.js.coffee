Ember.Handlebars.registerBoundHelper 'momentTime', (hour) ->
	moment(hour).format('HH:mm')