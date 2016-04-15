class CreateDutyStatuses < MainMigration
  def change
    create_table :duty_statuses, :id => false  do |t|
      common_set_one(t)
      employee_id(t)
      datetime_of_implementation(t)
      t.boolean :active, :required => true, default: false
    end
  end
end