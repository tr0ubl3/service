# For more information see: http://emberjs.com/guides/routing/

Service.solvingStepsRoute = Ember.Route.extend(
	model: ->
		@store.find('solving_step')
)
