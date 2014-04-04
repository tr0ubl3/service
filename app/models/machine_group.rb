class MachineGroup < ActiveRecord::Base
  attr_accessible :manufacturer_id, :name, :machine_type, :version
  belongs_to :manufacturer
  has_many :machines
  has_many :alarms
end
