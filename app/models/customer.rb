class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  acts_as_paranoid

  has_many :orders, dependent: :destroy
  has_many :cart_products, dependent: :destroy
  has_many :products, through: :cart_products
  has_many :destinations, dependent: :destroy
end
