# For more information see: http://emberjs.com/guides/routing/

Service.SolvingStepRoute = Ember.Route.extend({
	model: (params) ->
		@store.find('solving_step', params.solving_step_id)
})
