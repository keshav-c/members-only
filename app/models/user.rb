# frozen_string_literal: true

# Data model for Users
class User < ApplicationRecord
  has_many :posts

  validates :name,
            presence: true,
            length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  validates :email,
            presence: true,
            length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password,
            presence: true,
            length: { minimum: 6 }

  before_create do
    self[:remember_digest] = Digest::SHA1.hexdigest(SecureRandom.urlsafe_base64)
  end

  class << self
    def digest(string)
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create(string, cost: cost)
    end
  end
end
