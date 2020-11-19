class Trash < ApplicationRecord
  has_many :images
  belongs_to :location
  has_one :reporter, class_name: 'User', foreign_key: :reporter_id
  has_one :cleaner, class_name: 'User', foreign_key: :cleaner_id
end
