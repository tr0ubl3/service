class Alarm < ActiveRecord::Base
  attr_accessible :number, :text
  has_and_belongs_to_many :service_events
  
  scope :search, lambda { |query| where(["number = ?", "#{query}".to_i]) }
end
