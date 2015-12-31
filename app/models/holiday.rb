class Holiday < ActiveRecord::Base

  include UUIDHelper
  belongs_to :holiday_type
  validates_presence_of :date_of_implementation
  validates_uniqueness_of :date_of_implementation
  validates_presence_of :holiday_type

end
