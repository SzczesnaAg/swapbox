class Swap < ApplicationRecord
  belongs_to :user
  belongs_to :product
  belongs_to :other_product, foreign_key: "other_product_id", class_name: "Product", optional: true
  has_many :messages

  default_scope { order(updated_at: :desc) }

  enum status: [:ongoing, :accepted, :rejected, :exchanged, :canceled]
end
