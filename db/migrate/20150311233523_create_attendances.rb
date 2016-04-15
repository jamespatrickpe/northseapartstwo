class CreateAttendances < MainMigration
  def change
    create_table :attendances, :id => false do |t|
      t.string :id, limit: 36, primary: true, null: false
      t.string :employee_id, limit: 36,:required => true
      t.date :date_of_attendance, :required => true
      t.time :timein, default: "00:00:01"
      t.time :timeout, default: "23:59:59"
      t.string :remark, :limit => 256
      t.timestamps null: false
    end
    execute "ALTER TABLE attendances ADD PRIMARY KEY (id);"
  end
end
