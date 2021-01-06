class Article < ApplicationRecord
  validates :title, presence: true, length: { within: 4..128 }

  scope :sorted, -> { order(id: :asc) }
  scope :newest_first, -> { order(created_at: :desc) }
  scope :oldest_first, -> { order(created_at: :asc) }
  scope :latest_update, -> { order(updated_at: :desc) }
end
