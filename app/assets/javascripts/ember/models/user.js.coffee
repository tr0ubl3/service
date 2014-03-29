# for more details see: http://emberjs.com/guides/models/defining-models/

Service.User = DS.Model.extend(
	firstName: DS.attr('string')
	lastName: DS.attr('string')
	solving_steps: DS.hasMany('solving_step')
	fullName: ->
		@get('firstName') + ' ' + @get('lastName')
)
