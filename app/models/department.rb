class Department < ActiveRecord::Base

  include UUIDHelper

  validates_length_of :description , maximum: 256
  validates_length_of :label , maximum: 64
  has_many :positions

end
