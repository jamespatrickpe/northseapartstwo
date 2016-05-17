class CreateEmployees < MainMigration
  def change
    create_table :employees, :id => false do |t|
      common_set_two(t)
      system_actor_id(t)
      t.string :branch_id, limit: 36,:required => true
    end
    primary_key_override(:employees.to_s)
  end
end