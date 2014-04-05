class Alarm < ActiveRecord::Base
  attr_accessible :number, :text
  has_and_belongs_to_many :service_events
  
  scope :search, lambda { |query| where(["number = ?", "#{query}".to_i]) }

  def self.import(file)
  	CSV.foreach(file.path, headers: :true) do |row|
  		Alarm.create! row.to_hash
  	end
  end
end
