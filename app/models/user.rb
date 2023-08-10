class User < ApplicationRecord
    has_many :orders
    has_one :cart
    belongs_to :province

    attr_accessor :address
    attr_accessor :province_id

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
