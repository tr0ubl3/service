# For more information see: http://emberjs.com/guides/routing/

Service.SolvingStepsNewRoute = Ember.Route.extend({
	model: ->
		@store.createRecord('solving_step', { serviceEvent: @store.find('serviceEvent', 50) })
	actions: 
		create: (solving_step)->
			route = @
			solving_step.save().then(->
				route.transitionTo('solving_steps') 
			)
})