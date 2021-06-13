class Item < ApplicationRecord
  belongs_to :category
  belongs_to :transfer, optional: true
  belongs_to :budget, optional: true
end
