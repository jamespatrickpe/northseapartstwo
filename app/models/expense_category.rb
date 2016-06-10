class ExpenseCategory < ActiveRecord::Base

  include BaseConcerns,
          RemarkConcerns,
          NameConcerns

  has_many :expense_entries, autosave: true

end
