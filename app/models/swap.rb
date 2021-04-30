class Swap < ApplicationRecord
  belongs_to :user
  belongs_to :product

  has_many :messages

  belongs_to :other_product, foreign_key: "other_product_id", class_name: "Product", optional: true

  enum status: [:ongoing, :accepted, :rejected, :exchanged]

  default_scope { order(updated_at: :desc) }
end
