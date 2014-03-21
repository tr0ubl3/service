# For more information see: http://emberjs.com/guides/routing/

Service.SolvingStepsRoute = Ember.Route.extend({
	model: ->
		@store.find('solving_step')
})
