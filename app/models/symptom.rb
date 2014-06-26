class Symptom < ActiveRecord::Base
  attr_accessible :number, :description, :machine_group_id
  
  belongs_to :machine_group
  has_many :manifestations
  has_many :service_events, through: :manifestations
end