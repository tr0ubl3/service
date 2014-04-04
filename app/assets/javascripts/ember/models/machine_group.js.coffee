# for more details see: http://emberjs.com/guides/models/defining-models/

Service.MachineGroup = DS.Model.extend
  name: DS.attr 'string'
  type: DS.attr 'string'
  manufacturerId: DS.attr 'number'
