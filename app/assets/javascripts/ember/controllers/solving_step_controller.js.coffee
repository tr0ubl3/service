# for more details see: http://emberjs.com/guides/controllers/

Service.SolvingStepController = Ember.ObjectController.extend({
	actions:
		editSolvingStep: ->
			@set('isEditing', true)
		acceptChanges: ->
			@set('isEditing', false)

			if (Ember.isEmpty(this.get('model.step')))
				@send('removeSolvingStep')
			else
				@get('model').save()
		removeSolvingStep: ->
			step = @get('model')
			step.deleteRecord()
			step.save()
})

