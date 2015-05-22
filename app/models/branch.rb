class Branch < ActiveRecord::Base

  include UUIDHelper

  belongs_to :entity
  validates_presence_of :entity

end
