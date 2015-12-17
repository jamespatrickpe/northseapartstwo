class Telephone < ActiveRecord::Base
  include UUIDHelper
  belongs_to :actor
  validates_presence_of :actor
  validates_length_of :digits , maximum: 32, message: "digits must be less than 32 characters"
  validates_length_of :description , maximum: 256, message: "description must be less than 256 characters"
end
