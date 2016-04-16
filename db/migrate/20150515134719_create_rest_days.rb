class CreateRestDays < MainMigration
  def change
    create_table :rest_days, :id => false    do |t|
      common_set_one(t)
      employee_id(t)
      datetime_of_implementation(t)
      t.string :day, :limit => 64, :default => "SUNDAY"
    end
    primary_key_override(:rest_days.to_s)
  end
end
