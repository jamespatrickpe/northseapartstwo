class Address < ActiveRecord::Base

  include BaseConcerns
  include RemarkValidations

  belongs_to :rel_model, polymorphic: true

  validates_numericality_of :longitude
  validates_numericality_of :latitude

end
