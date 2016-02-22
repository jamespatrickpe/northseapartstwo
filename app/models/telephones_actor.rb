class TelephonesActor < ActiveRecord::Base

  include UUIDHelper

  validates_presence_of :telephone_id
  validates_presence_of :actor_id

end
