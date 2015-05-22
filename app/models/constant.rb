class Constant < ActiveRecord::Base

  include UUIDHelper

  validates_length_of :constant, maximum: 64
  validates_length_of :description, maximum: 128
  validates_length_of :name, maximum: 64

end
