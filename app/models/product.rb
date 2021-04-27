class Product < ApplicationRecord
  enum status: [:ongoing, :accepted, :rejected]
  validates :title, presence: true
  validates :city, presence: true
  validates :street, presence: true

  belongs_to :user

  default_scope { order(created_at: :desc) }
end
