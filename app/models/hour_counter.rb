class HourCounter < ActiveRecord::Base
  attr_accessible :machine_id, :machine_hours_age
  belongs_to :machine

  validate :hour_counter_cannot_be_smaller_than_in_the_past, :on => :update
  
  def hour_counter_cannot_be_smaller_than_in_the_past
    if machine_hours_age.present? && machine_hours_age < self.machine_hours_age
      errors.add(:machine_hours_age, "can't be smaller than already existing value")
    end
  end

end
