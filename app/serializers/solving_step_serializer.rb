class SolvingStepSerializer < ActiveModel::Serializer
  attributes :id, :step, :description, :created_at
  embed :ids, include: true
  has_one :user
  has_one :service_event
end
