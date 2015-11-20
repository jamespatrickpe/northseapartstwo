class Role < ActiveRecord::Base

  include UUIDHelper

  has_one :actor

end
