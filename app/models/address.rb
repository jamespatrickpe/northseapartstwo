class Address < ActiveRecord::Base

  include UUIDHelper

  belongs_to :actor
  validates_presence_of :actor
  validates_numericality_of :longitude
  validates_numericality_of :latitude
  validates_length_of :description , maximum: 256

end
