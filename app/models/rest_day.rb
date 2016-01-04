class RestDay < ActiveRecord::Base

  include UUIDHelper

  belongs_to :employee

  validates_length_of :day , maximum: 64
  validates_presence_of :employee
  validates_presence_of :date_of_effectivity

end