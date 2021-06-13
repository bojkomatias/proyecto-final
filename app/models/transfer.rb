class Transfer < ApplicationRecord
  has_many :items
  accepts_nested_attributes_for :items
  belongs_to :account

  paginates_per 5
end
