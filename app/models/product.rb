class Product < ApplicationRecord
  enum status: [:ongoing, :accepted]
  validates :title, presence: true
  validates :city, presence: true
  validates :street, presence: true

  def address
    "#{street}, #{zipcode} #{city}"
  end

  geocoded_by :address
  after_validation :geocode, if: [:will_save_change_to_street?, :will_save_change_to_zipcode?, :will_save_change_to_city?]

  belongs_to :user
  has_many :swaps

  default_scope { order(created_at: :desc) }
end
