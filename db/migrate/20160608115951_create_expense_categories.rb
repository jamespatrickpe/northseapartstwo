class CreateExpenseCategories < MainMigration
  def change
    create_table :expense_categories, :id => false do |t|
      common_set_one(t)
      make_name(t)
      t.string :ancestry
    end
    primary_key_override(:expense_categories.to_s)
  end
end
