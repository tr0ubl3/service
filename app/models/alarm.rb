class Alarm < ActiveRecord::Base
  attr_accessible :number, :text
  belongs_to :machine_group
  has_and_belongs_to_many :service_events

  validates :number, :presence => true, :uniqueness => true
  
  scope :search, lambda { |query| where(["number = ?", "#{query}".to_i]) }

  def self.import(file)
  	CSV.foreach(file.path, headers: :true) do |row|
  		Alarm.create! row.to_hash
  	end
  	return true
  end
end
