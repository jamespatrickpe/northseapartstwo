class CreateExpenseEntries < MainMigration
  def change
    create_table :expense_entries, :id => false do |t|
      common_set_one(t)
      t.string :expense_category_id, :required => true
      t.string :system_account_id, :required => true
      datetime_of_implementation(t)
      amount(t)
    end
    primary_key_override(:expense_entries.to_s)
  end
end
