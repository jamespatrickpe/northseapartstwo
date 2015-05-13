class AllowableSet < ActiveRecord::Base

  belongs_to :access
  validates_presence_of :access

  validates_length_of :controller , maximum: 64
  validates_length_of :action , maximum: 64
  validates_length_of :security_level , maximum: 64

end
