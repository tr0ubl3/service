# For more information see: http://emberjs.com/guides/routing/

Service.SolvingStepsNewRoute = Ember.Route.extend({
	model: ->
		@store.createRecord('solving_step')
		# @store.find('solving_step')
		# @store.filter('solving_step', (solving_step)->
		# 	!solving_step.get('isNew')
		# )

	actions: 
		create: (solving_step)->
			route = @
			solving_step.save().then(->
				route.transitionTo('solving_steps') 
			)
})		
