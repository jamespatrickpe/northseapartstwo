class HolidayType < ActiveRecord::Base

  validates_presence_of :type_name
  validates_numericality_of :additional_rate
  validates_numericality_of :additional_rate_overtime
  validates_numericality_of :additional_rate_rest_day_priveleges

end
