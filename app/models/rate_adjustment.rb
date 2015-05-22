class RateAdjustment < ActiveRecord::Base

  include UUIDHelper

  belongs_to :employee
  validates_presence_of :employee

  validates_numericality_of :amount
  validates_presence_of :rate_of_time

  validates_length_of :description, maximum: 128


end
