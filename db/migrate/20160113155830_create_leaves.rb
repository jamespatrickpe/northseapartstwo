class CreateLeaves < MainMigration
  def change
    create_table :leaves, :id => false do |t|
      common_set_one(t)
      employee_id(t)
      t.string :type_of_leave, :limit => 64
      t.datetime :start_of_effectivity, default: Time.now
      t.datetime :end_of_effectivity, default: Time.now
    end
    primary_key_override(:leaves.to_s)
  end
end