# For more information see: http://emberjs.com/guides/routing/

Service.SolvingStepsRoute = Ember.Route.extend({
	model: ->
		event = location.search.match(/\?event\=([\d]+)/)[1]
		@store.filter('solving_step', {service_event_id: event}, (solving_step) ->
			!solving_step.get('isNew')
		)
	actions:
		'delete': (solving_step) ->
			solving_step.destroyRecord()
	
})
