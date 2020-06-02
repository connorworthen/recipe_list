class User < ActiveRecord::Base   
    has_many :recipes
    has_secure_password

    # validates :name, presence: true   
    validates_presence_of :name, :email, :password
    # validates :password, length: {in: 6..20}, unless: ->(u){u.password.blank?}
end