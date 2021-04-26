class Product < ApplicationRecord
  enum status: [:ongoing, :accepted, :rejected]
  validates :title, presence: true
  validates :city, presence: true
  validates :street, presence: true
end
