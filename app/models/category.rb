class Category < ApplicationRecord
  has_many :subcategories, class_name: "Category"
  has_many :items
  belongs_to :category, class_name: "Category", optional: true

  paginates_per 5
end
