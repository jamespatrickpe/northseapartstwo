module AmountValidations extend ActiveSupport::Concern

  included do
    validates_presence_of :amount
    validates_numericality_of :amount
    validates_length_of :amount, maximum: 16
  end

end