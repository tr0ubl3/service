class SolvingStepSerializer < ActiveModel::Serializer
  attributes :id, :service_event_id, :step, :created_at
end
