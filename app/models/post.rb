class Post < ApplicationRecord
  include PgSearch
  validates :title, :body, :username, presence: true

  belongs_to :user

  pg_search_scope :search, against: [:title]

  mount_base64_uploader :image, PostImageUploader
end
