class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          #:confirmable, 
          :omniauthable
  include DeviseTokenAuth::Concerns::User
  has_many :cards
  has_many :user_groups
  has_many :groups ,through: :user_groups
end
