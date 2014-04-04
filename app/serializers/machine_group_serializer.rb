class MachineGroupSerializer < ActiveModel::Serializer
  attributes :id, :name, :type, :manufacturer_id
end
