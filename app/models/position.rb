class Position < ActiveRecord::Base

  include UUIDHelper

  belongs_to :department, autosave: true
  validates_presence_of :department
  validates_length_of :label , maximum: 64
  validates_length_of :description , maximum: 256

end
