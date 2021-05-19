class User < ApplicationRecord
  # encrypt password
  has_secure_password

  # Model associations
  has_many :favourites
  has_many :houses, through: :favourites

  # Validations
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates_presence_of :name, :email, :password_digest
end
