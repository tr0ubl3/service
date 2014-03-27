# For more information see: http://emberjs.com/guides/routing/

Service.SolvingStepEditRoute = Ember.Route.extend({
	model: ->
		@modelFor('solving_step')
	actions: 
		update: (solving_step) ->
			route = @
			solving_step.save().then(->
				route.transitionTo('solving_steps')
			)
})
