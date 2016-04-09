class Vehicle < ActiveRecord::Base

  include UUIDHelper

  validates_presence_of :date_of_registration
  validates_presence_of :type_of_vehicle
  validates_presence_of :plate_number
  validates_presence_of :orcr

end