Ember.Handlebars.registerBoundHelper 'recordNumber', (records, record) ->
	console.log(records)
	records.indexOf(record)