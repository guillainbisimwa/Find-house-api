class User < ApplicationRecord
  # model association
  has_many :favourites, dependent: :destroy

  # validations
  validates_presence_of :name, :email
end
