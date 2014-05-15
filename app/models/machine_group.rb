class MachineGroup < ActiveRecord::Base
  attr_accessible :manufacturer_id, :machining_type, :machine_type, :version
  belongs_to :manufacturer
  has_many :machines, dependent: :destroy
  has_many :alarms, dependent: :destroy

  validates :manufacturer_id, :presence => true
  validates :machining_type, :presence => true
  validates :machine_type, :presence => true, :uniqueness => true
  validates :version, :presence => true, :uniqueness => true

  def view_name
  	"#{manufacturer.name}-#{machine_type}-#{version}"
  end

  def alarms_to_csv
  	CSV.generate do |csv|
  		column_header = self.alarms.column_names & ["id", "number", "text"]
  		csv << column_header.insert(1, column_header.delete_at(2))
  		
  		self.alarms.each do |alarm|
  			csv << alarm.attributes.values_at(*column_header)
  		end
  	end
  end
end
