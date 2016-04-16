class Biodatum < ActiveRecord::Base

  include BaseConcerns

  belongs_to :actor

  validates_presence_of :actor

end
