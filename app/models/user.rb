class User < ActiveRecord::Base
  has_many :participations
  has_many :decisions, through: :participations
  has_many :proposals, through: :participations
  has_many :queries, through: :participations

  validates_presence_of :name, :email, :phone_number, :password_digest
  validates_uniqueness_of :email, :phone_number
  # validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i

  has_secure_password
end
