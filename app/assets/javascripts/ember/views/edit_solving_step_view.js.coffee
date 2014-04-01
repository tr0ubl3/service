# for more details see: http://emberjs.com/guides/views/

Service.EditSolvingStepView = Ember.View.extend
  didInsertElement: ->
  	@$().focus()

Ember.Handlebars.helper('edit-solving-step', Service.EditSolvingStepView)
