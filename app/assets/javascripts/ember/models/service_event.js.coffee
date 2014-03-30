# for more details see: http://emberjs.com/guides/models/defining-models/

Service.ServiceEvent = DS.Model.extend(
	eventName: DS.attr('string')
	solving_steps: DS.hasMany('solving_step')
)
