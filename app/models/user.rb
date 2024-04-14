class User < ApplicationRecord
  has_secure_password
  has_many :photographs

  validates :account_id, presence: true, uniqueness: true
  validates :password, presence: true
end
