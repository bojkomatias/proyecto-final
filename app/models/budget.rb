class Budget < ApplicationRecord
  belongs_to :user
  has_many :items
  accepts_nested_attributes_for :items 

  paginates_per 5
end
