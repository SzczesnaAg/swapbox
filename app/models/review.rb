class Review < ApplicationRecord
  belongs_to :user

  validates :content, presence: true
  validates :rating, presence: true, inclusion: { in: 1..5 }, numericality: { only_integer: true }

  default_scope { order(created_at: :desc) }

  enum status: [:created, :approved, :declined]
end
