class CreateAttendances < MainMigration
  def change
    create_table :attendances, :id => false do |t|
      common_set_one(t)
      employee_id(t)
      date_of_implementation(t)
      t.time :timein, default: "00:00:01"
      t.time :timeout, default: "23:59:59"
    end
    primary_key_override(:attendances.to_s)
  end
end
