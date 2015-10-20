class InstitutionEmployee < ActiveRecord::Base

  include UUIDHelper

  belongs_to :entity
  validates_presence_of :compensation_type
  validates_length_of :compensation_type, maximum: 64

end