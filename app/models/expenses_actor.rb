class ExpensesActor < ActiveRecord::Base

  include UUIDHelper

  validates_presence_of :expense_id
  validates_presence_of :actor_id

end
