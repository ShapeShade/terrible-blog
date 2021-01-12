# Category Model
class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { within: 3..50 }
end
