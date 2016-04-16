class Address < ActiveRecord::Base

  include BaseConcerns,
          RemarkValidations,
          BelongsRelModel

  validates_numericality_of :longitude
  validates_numericality_of :latitude

end
