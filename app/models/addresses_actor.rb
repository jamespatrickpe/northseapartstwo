class AddressesActor < ActiveRecord::Base

  include UUIDHelper

  validates_presence_of :address_id
  validates_presence_of :actor_id

end
