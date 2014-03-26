# For more information see: http://emberjs.com/guides/routing/

Service.SolvingStepsNewRoute = Ember.Route.extend({
	model: ->
		event = RegExp('[^?event=]+[0-9]').exec(location.search)[0]
		console.log(event)
		@store.createRecord('solving_step', {serviceEventId: event})
	actions: 
		create: (solving_step)->
			route = @
			solving_step.save().then(->
				route.transitionTo('solving_steps') 
			)
})

# Service.SolvingStepsController = Ember.ArrayController.extend({
# 	queryParams: ['event']
# 	event: null
# 	@store.
# })		

