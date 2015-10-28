class Branch < ActiveRecord::Base

  include UUIDHelper

  belongs_to :actor
  validates_presence_of :actor

end
