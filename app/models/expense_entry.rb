class ExpenseEntry < ActiveRecord::Base

  include BaseConcerns,
          RemarkConcerns

  belongs_to :expense_category
  alias_attribute :system_account ,:service_provider

  has_many :system_association, as: :model_one
  has_many :system_association, as: :model_two

end
