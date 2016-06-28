class CreateEmployees < MainMigration
  def change
    create_table :employees, :id => false do |t|
      common_set_one(t)
      system_account_id(t)
    end
    primary_key_override(:employees.to_s)
  end
end