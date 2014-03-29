# for more details see: http://emberjs.com/guides/controllers/


Groupable = Ember.Mixin.create
  group: null
  ungroupedContent: null

  groupedContent: (->
    model = @
    groupedContent = Ember.A([])

    groupCallback = @get('group')
    ungroupedContent = @get('ungroupedContent')

    return groupedContent unless groupCallback
    return groupedContent unless ungroupedContent

    ungroupedContent.forEach (item) ->
      group = groupCallback.call(model, item)
      return unless groupKey = group.get('key')

      foundGroup = groupedContent.findProperty('group.key', groupKey)

      unless foundGroup
        foundGroup = groupedContent.pushObject Ember.ArrayProxy.create
          group: group,
          content: Ember.A([])

      foundGroup.get('content').pushObject(item)

    groupedContent
  ).property('group', 'ungroupedContent.@each')


Service.SolvingStepsController = Ember.ArrayController.extend Groupable,
  ungroupedContentBinding: 'content'
  group: (solving_step) ->
    Ember.Object.create
      key: moment.utc(solving_step.get('createdAt')).format('DD.MM.YYYY') # using momentjs to pluck the day from the date
      description: 'some string describing this group (if you want)'
