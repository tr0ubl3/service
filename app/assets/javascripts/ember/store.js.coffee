# http://emberjs.com/guides/models/#toc_store
# http://emberjs.com/guides/models/pushing-records-into-the-store/

Service.Store = DS.Store.extend()

# Override the default adapter with the `DS.ActiveModelAdapter` which
# is built to work nicely with the ActiveModel::Serializers gem.
Service.SolvingStepAdapter = DS.RESTAdapter.extend(
	suffix: '.json'
	pathForType: (type) ->
		decamelized = Ember.String.decamelize(type)
		Ember.String.pluralize(decamelized) + @get('suffix')
)

Service.ApplicationSerializer = DS.ActiveModelSerializer.extend({})