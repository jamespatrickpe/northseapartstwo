class Address < ActiveRecord::Base



  belongs_to :rel_model, polymorphic: true
  # validates_presence_of :actor
  validates_numericality_of :longitude
  validates_numericality_of :latitude
  validates_length_of :remark , maximum: 256

end
