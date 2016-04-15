class DigitalsActor < ActiveRecord::Base



  validates_presence_of :digital_id
  validates_presence_of :actor_id

end
