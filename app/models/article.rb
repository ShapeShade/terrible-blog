class Article < ApplicationRecord
  validates :title, presence: true, length: { within: 4..128 }
end
