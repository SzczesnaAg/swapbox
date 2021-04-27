class Product < ApplicationRecord
  enum status: [:ongoing, :accepted, :rejected]
  validates :title, presence: true
  validates :city, presence: true
  validates :street, presence: true

  geocoded_by :city
  after_validation :geocode, if: :will_save_change_to_city?
end
