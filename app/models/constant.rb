class Constant < ActiveRecord::Base

  include BaseConcerns
  include RemarkConcerns
  include NameConcerns

  validates_presence_of :value
  validates_length_of :value, maximum: 64

  validates_presence_of :constant_type
  validates_length_of :constant_type, maximum: 64

end
