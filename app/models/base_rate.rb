class BaseRate < ActiveRecord::Base

  include UUIDHelper

  belongs_to :employee
  validates_presence_of :employee

  validates_presence_of :employee, :period_of_time
  validates_length_of :remark , maximum: 256
  validates_numericality_of :amount

end
