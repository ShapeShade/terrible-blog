# frozen_string_literal: true

# Article Model
class Article < ApplicationRecord
  belongs_to :user
  has_many :article_categories
  has_many :categories, through: :article_categories

  validates :title, presence: true, length: { within: 4..128 }

  scope :sorted, -> { order(id: :asc) }
  scope :newest_first, -> { order(created_at: :desc) }
  scope :oldest_first, -> { order(created_at: :asc) }
  scope :latest_update, -> { order(updated_at: :desc) }
end
