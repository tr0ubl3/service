# For more information see: http://emberjs.com/guides/routing/

Service.SolvingStepsNewRoute = Ember.Route.extend({
	model: ->
		event = location.search.match(/\?event\=([\d]+)/)[1]
		# console.log(event)
		@store.createRecord('solving_step', {serviceEventId: event})
	actions: 
		create: (solving_step)->
			route = @
			solving_step.save().then(->
				route.transitionTo('solving_steps') 
			)
})