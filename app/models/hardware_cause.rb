class HardwareCause < EventCause
  attr_accessible :category, :problem

  validates_uniqueness_of :name, scope: :problem
end
