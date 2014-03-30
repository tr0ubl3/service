# For more information see: http://emberjs.com/guides/routing/

Service.SolvingStepsNewRoute = Ember.Route.extend({
	model: ->
		@store.createRecord('solving_step', { serviceEvent: @modelFor('application') })
	actions: 
		create: (solving_step)->
			route = @
			solving_step.save().then(->
				route.transitionTo('solving_steps') 
			)
})