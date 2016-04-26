class RegularWorkPeriod < ActiveRecord::Base

  include BaseConcerns,
          Employee

  validates_presence_of :start_time
  validates_presence_of :end_time
  validates_presence_of :datetime_of_implementation

end
