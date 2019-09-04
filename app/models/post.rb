class Post < ApplicationRecord
  belongs_to :user

  validates :content, presence: true, length: { minimum: 4, maximum: 280 }
end
