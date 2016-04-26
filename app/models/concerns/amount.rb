module Amount
  extend ActiveSupport::Concern

  included do
    validates_presence_of :amount
    validates_numericality_of :amount
  end

end