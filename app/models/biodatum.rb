class Biodatum < ActiveRecord::Base

  belongs_to :entity
  validates_presence_of :entity

end
