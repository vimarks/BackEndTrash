class User < ApplicationRecord
  has_one :wallet
  has_one :reputation
  has_many :trashes
  has_many :locations, through: :trashes
  has_secure_password
  validates :username, uniqueness: { case_sensitive: false }
end
