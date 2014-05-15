class ManufacturerSerializer < ActiveModel::Serializer
  attributes :machining_type

  def machining_type
  	object.machine_groups.collect(&:machining_type).uniq
  end
end
