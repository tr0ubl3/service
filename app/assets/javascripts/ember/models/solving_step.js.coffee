# for more details see: http://emberjs.com/guides/models/defining-models/

Service.SolvingStep = DS.Model.extend(
	serviceEventId: DS.attr('number')
	step: DS.attr('string')
	createdAt: DS.attr()
	user: DS.belongsTo('user')
)
