class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :products, dependent: :destroy
  has_many :swaps, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_one_attached :photo
end
