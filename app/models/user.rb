# frozen_string_literal: true

# User model
class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i.freeze

  before_save { self.email = email.downcase }

  has_many :articles

  validates :username, presence: true, length: { within: 3..50 }, uniqueness: { case_sensitive: false }

  validates :email, presence: true,
                    length: { within: 3..128 },
                    uniqueness: { case_sensitive: false },
                    format: { with: VALID_EMAIL_REGEX }

  scope :sorted, -> { order(id: :asc) }

  has_secure_password
end
