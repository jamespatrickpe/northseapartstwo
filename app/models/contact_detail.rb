class ContactDetail < ActiveRecord::Base

  has_many :addresses
  has_many :digitals
  has_many :telephones
  belongs_to :entity

  validates_presence_of :entity
end
