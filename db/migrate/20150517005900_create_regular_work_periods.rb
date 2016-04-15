class CreateRegularWorkPeriods < MainMigration
  def change
    create_table :regular_work_periods, :id => false    do |t|
      common_set_one(t)
      datetime_of_implementation(t)
      employee_id(t)
      t.time :start_time,:required => true, default: '08:00:00'
      t.time :end_time,:required => true, default: '17:00:00'
    end
  end
end