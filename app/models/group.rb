class Group < ActiveRecord::Base
  has_many :user_groups
  has_many :user, through: :user_groups
  accepts_nested_attributes_for :user_groups
  has_many :cards
end
