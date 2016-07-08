class HolidayType < ActiveRecord::Base

  include BaseConcerns

  validates_presence_of :type_name
  validates_presence_of :rate_multiplier
  validates_presence_of :overtime_multiplier
  validates_presence_of :rest_day_multiplier
  validates_presence_of :overtime_rest_day_multiplier

  validates_numericality_of :rate_multiplier
  validates_numericality_of :overtime_multiplier
  validates_numericality_of :rest_day_multiplier
  validates_numericality_of :overtime_rest_day_multiplier

  searchable do
    string :type_name
    text :type_name
  end

end
