class User < ApplicationRecord
  has_many :orders
  has_one :cart


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         validates :name, presence: true, length: { minimum: 3 }

         validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
end
