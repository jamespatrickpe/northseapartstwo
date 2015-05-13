class BaseRate < ActiveRecord::Base

  belongs_to :employee
  validates_presence_of :employee

  validates_presence_of :employee, :period_of_time
  validates_numericality_of :amount

end
