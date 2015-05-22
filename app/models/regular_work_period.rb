class RegularWorkPeriod < ActiveRecord::Base

  include UUIDHelper

  belongs_to :employee
  validates_presence_of :employee

end
