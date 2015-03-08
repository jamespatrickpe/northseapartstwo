class Address < ActiveRecord::Base
  belongs_to :contact_detail

  validates_presence_of :contact_detail
  validates_numericality_of :longitude
  validates_numericality_of :latitude
  validates_length_of :description , maximum: 256, message: "description must be less than 256 characters"

end
