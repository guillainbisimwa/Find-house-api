class House < ApplicationRecord

  # validations
  validates_presence_of :picture, :about, :price, :owner
end
