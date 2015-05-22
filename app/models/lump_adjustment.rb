class LumpAdjustment < ActiveRecord::Base

  include UUIDHelper

  belongs_to :employee
  validates_length_of :amount, maximum: 64
  validates_length_of :signed_type , maximum: 64
  validates_length_of :description , maximum: 256

end
