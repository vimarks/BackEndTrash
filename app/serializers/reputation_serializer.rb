class ReputationSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :rating
end
