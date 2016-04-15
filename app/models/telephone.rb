class Telephone < ActiveRecord::Base

  belongs_to :rel_model, polymorphic: true

  # validates_presence_of :actor
  validates_length_of :digits , maximum: 32, message: "digits must be less than 32 characters"
  validates_length_of :remark , maximum: 256, message: "remark must be less than 256 characters"
end
