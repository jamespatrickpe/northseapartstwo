class CreateRegularWorkPeriods < MainMigration
  def change
    create_table :regular_work_periods, :id => false    do |t|
      t.string :id, limit: 36, primary: true, null: false
      t.time :start_time,:required => true, default: '08:00:00'
      t.time :end_time,:required => true, default: '17:00:00'
      t.datetime :date_of_effectivity, :required => true, default: Time.now
      t.string :remark, limit: 256
      t.string :employee_id, limit: 36,:required => true
      t.timestamps null: false
    end
    execute "ALTER TABLE regular_work_periods ADD PRIMARY KEY (id);"
  end
end
