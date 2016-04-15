class Biodatum < ActiveRecord::Base



  belongs_to :actor
  validates_presence_of :actor

end
