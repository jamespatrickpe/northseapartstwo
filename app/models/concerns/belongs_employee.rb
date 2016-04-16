module BelongsEmployee extend ActiveSupport::Concern

  included do
    belongs_to :employee
    validates_presence_of :employee
  end

end