class Group < ActiveRecord::Base
  has_many :user, through: :user_groups
  has_many :cards
end
