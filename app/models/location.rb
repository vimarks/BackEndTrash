class Location < ApplicationRecord
  has_many :trashes
  has_many :users, through: :trashes
end
