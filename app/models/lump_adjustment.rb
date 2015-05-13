class LumpAdjustment < ActiveRecord::Base

  belongs_to :employee
  validates_length_of :amount, maximum: 64,  message: "amount must be less than 64 characters"
  validates_length_of :signed_type , maximum: 64, message: "type must be less than 64 characters"
  validates_length_of :description , maximum: 256, message: "description must be less than 256 characters"

end
