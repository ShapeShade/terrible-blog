# Category Model
class Category < ApplicationRecord
  has_many :article_categories
  has_many :articles, through: :article_categories

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { within: 3..50 }
end
