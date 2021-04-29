class Swap < ApplicationRecord
  belongs_to :user
  belongs_to :product
  has_many :messages

  enum status: [:ongoing, :accepted, :rejected]
end
