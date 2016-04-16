class RegularWorkPeriod < ActiveRecord::Base

  include BaseConcerns,
          BelongsEmployee

  validates_presence_of :start_time
  validates_presence_of :end_time
  validates_presence_of :date_of_implementation

end
