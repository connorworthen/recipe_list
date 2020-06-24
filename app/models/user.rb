class User < ActiveRecord::Base
  has_many :recipes


  has_secure_password
  validates_presence_of :username, :password_digest
  validates :username, uniqueness: true
end