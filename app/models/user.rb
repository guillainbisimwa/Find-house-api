class User < ApplicationRecord
  # encrypt password
  has_secure_password

  # Model associations
  has_many :favourites, dependent: :destroy

  # Validations
  validates_presence_of :name, :email, :password_digest
end
