class Review < ApplicationRecord
  belongs_to :user

  validates :content, presence: true
  validates :rating, presence: true, inclusion: { in: 1..5 }, numericality: { only_integer: true }

  default_scope { order(created_at: :desc) }

  state_machine :initial => :created do
    event :approve do
      transition :created => :approved
    end
    event :decline do
      transition :created => :declined
    end
  end
end
