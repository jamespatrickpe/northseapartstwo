class RegularWorkPeriod < ActiveRecord::Base

  include UUIDHelper
  belongs_to :employee
  validates_presence_of :employee
  validates_presence_of :start_time
  validates_presence_of :end_time
  validates_presence_of :date_of_effectivity

end
