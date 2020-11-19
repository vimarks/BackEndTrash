class ImageSerializer < ActiveModel::Serializer
  attributes :id, :image_type, :url, :trash_id
end
