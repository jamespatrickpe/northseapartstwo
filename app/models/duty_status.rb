class DutyStatus < ActiveRecord::Base

  include UUIDHelper

  belongs_to :employee

  validates_length_of :description , maximum: 256, message: "description must be less than 256 characters"
  validates_length_of :label , maximum: 64, message: "label must be less than 64 characters"

end
