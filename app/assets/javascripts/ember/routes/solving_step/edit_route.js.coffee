# For more information see: http://emberjs.com/guides/routing/

Service.SolvingStepEditRoute = Ember.Route.extend({
	model: ->
		@modelFor('solving_step')
	actions: 
		update: (solving_step) ->
			solving_step.save()
})
