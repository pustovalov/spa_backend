class User < ApplicationRecord
  has_secure_password

  has_many :posts, dependent: :destroy

  validates :email, :name, uniqueness: true, presence: true
end
