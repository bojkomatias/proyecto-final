class Account < ApplicationRecord
  belongs_to :user
  has_many :transfers

  paginates_per 5
end
