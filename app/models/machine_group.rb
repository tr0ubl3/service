class MachineGroup < ActiveRecord::Base
  attr_accessible :manufacturer_id, :machining_type, :machine_type, :version
  belongs_to :manufacturer
  has_many :machines
  has_many :alarms, dependent: :destroy

  def view_name
  	"#{manufacturer.name}-#{machine_type}-#{version}"
  end
end
