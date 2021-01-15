# frozen_string_literal: true

# ArticleCategory model
class ArticleCategory < ApplicationRecord
  belongs_to :article
  belongs_to :category
end
