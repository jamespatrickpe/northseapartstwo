module NameValidations extend ActiveSupport::Concern

  included do
    validates :name, uniqueness: true
    validates_presence_of :name
  end

end