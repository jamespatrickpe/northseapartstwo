class Constant < ActiveRecord::Base

  include BaseConcerns
  include RemarkValidations
  include NameValidations

  validates_presence_of :value
  validates_length_of :value, maximum: 64

  validates_presence_of :constant_type
  validates_length_of :constant_type, maximum: 64

end
