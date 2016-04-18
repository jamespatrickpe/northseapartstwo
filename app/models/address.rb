class Address < ActiveRecord::Base

  include BaseConcerns,
          RemarkValidations


  belongs_to :addressable, polymorphic: true
  validates_numericality_of :longitude
  validates_numericality_of :latitude

end
