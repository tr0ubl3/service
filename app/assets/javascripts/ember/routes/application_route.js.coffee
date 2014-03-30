# For more information see: http://emberjs.com/guides/routing/

Service.ApplicationRoute = Ember.Route.extend({
	model: ->
		event = location.search.match(/\?event\=([\d]+)/)[1]
		@store.find('serviceEvent', event)
})
