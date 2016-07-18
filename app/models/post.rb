class Post < ApplicationRecord
  validates :title, :body, :username, presence: true
end
