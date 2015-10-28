class ContactDetail < ActiveRecord::Base

  include UUIDHelper

  has_many :addresses
  has_many :digitals
  has_many :telephones
  belongs_to :actor

  validates_presence_of :actor
end
