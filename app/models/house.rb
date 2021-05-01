class House < ApplicationRecord
  # Association
  has_many :favourites
  has_many :users, :through => :favourites

  # validations
  validates_presence_of :picture, :about, :price, :owner
end
