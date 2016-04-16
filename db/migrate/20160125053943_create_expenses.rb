class CreateExpenses < MainMigration
  def change
    create_table :expenses, :id => false   do |t|
      common_set_one(t)
      amount(t)
      datetime_of_implementation(t)
      t.string :category, :limit => 256
      t.string :physical_id, :limit => 256
    end
    primary_key_override(:expenses.to_s)
  end
end