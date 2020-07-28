class Recipe < ActiveRecord::Base
  belongs_to :user
  belongs_to :category #category model
  has_many :bookmarks

  validates_presence_of :name, :url
  validates :name, uniqueness: true

end


#conventions, get a model and migration foreign key, active record, class names singular etc. snake case migration belongs/has_many connects db key,

