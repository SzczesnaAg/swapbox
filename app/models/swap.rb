class Swap < ApplicationRecord
  belongs_to :user
  belongs_to :product

  enum status: [:ongoing, :accepted, :rejected]
end
