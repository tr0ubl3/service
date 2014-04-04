class MachineGroup < ActiveRecord::Base
  attr_accessible :manufacturer_id, :name, :type

  has_many :machines
  has_many :alarms
end
