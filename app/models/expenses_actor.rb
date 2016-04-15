class ExpensesActor < ActiveRecord::Base



  validates_presence_of :expense_id
  validates_presence_of :actor_id

end
