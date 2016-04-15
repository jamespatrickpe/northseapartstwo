class RateAdjustment < ActiveRecord::Base



  belongs_to :employee
  validates_presence_of :employee

  validates_numericality_of :amount
  validates_presence_of :rate_of_time

  validates_length_of :remark, maximum: 128


end
