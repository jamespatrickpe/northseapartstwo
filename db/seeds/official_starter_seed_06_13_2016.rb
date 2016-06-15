include ApplicationHelper
module OfficialStarterSeed06132016

  puts " == Loading Official Seed Starter Package 06/13/16 =="

  mobile = ExpenseCategory.new
  mobile.parent_expense_id = telephone.id
  mobile.name = 'Mobile'
  mobile.save!

  landline = ExpenseCategory.new
  landline.parent_expense_id = telephone.id
  landline.name = 'Landline'
  landline.save!


end