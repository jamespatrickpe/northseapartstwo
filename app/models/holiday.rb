class Holiday < ActiveRecord::Base

  belongs_to :holiday_type

  validates :date_of_implementation, uniqueness: true
  validates_presence_of :holiday_type

end
