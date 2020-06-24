class Recipe < ActiveRecord::Base
  belongs_to :user
  # has_many :bookmarks

  validates_presence_of :name, :url
  validates :name, uniqueness: true

end