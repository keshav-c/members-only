# frozen_string_literal: true

# Data model for Posts
class Post < ApplicationRecord
  belongs_to :user

  validates :content, presence: true, length: { minimum: 4, maximum: 280 }
end
