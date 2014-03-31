# for more details see: http://emberjs.com/guides/models/defining-models/

Service.SolvingStep = DS.Model.extend(
	step: DS.attr('string')
	description: DS.attr('string')
	createdAt: DS.attr()
	serviceEvent: DS.belongsTo('serviceEvent')
	user: DS.belongsTo('user')
)
