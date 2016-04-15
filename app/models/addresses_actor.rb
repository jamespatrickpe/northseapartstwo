class AddressesActor < ActiveRecord::Base



  validates_presence_of :address_id
  validates_presence_of :actor_id

end
