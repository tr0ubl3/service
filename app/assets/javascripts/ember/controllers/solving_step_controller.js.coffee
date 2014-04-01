# for more details see: http://emberjs.com/guides/controllers/

Service.SolvingStepController = Ember.ObjectController.extend({
	isEditing: false
	bufferedStep: Ember.computed.oneWay('step')
	bufferedDescription: Ember.computed.oneWay('description')
	actions:
		editSolvingStep: ->
			@set('isEditing', true)
		acceptChanges: ->
			@set('isEditing', false)
			bufferedStep = @get('bufferedStep').trim()
			bufferedDescription = @get('bufferedDescription').trim()
			step = @get('model')
			if (Ember.isEmpty(bufferedStep))
				@send('removeSolvingStep')
			else
				step.set('step', bufferedStep)
				step.set('description', bufferedDescription)
				step.save()
		removeSolvingStep: ->
			step = @get('model')
			step.deleteRecord()
			step.save()
		cancelChanges: ->
			self = @
			@set('bufferedStep', self.get('step'))
			@set('bufferedDescription', self.get('description'))
			@set('isEditing', false)
})

