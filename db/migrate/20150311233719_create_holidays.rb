class CreateHolidays < MainMigration
  def change
    create_table :holidays, :id => false   do |t|
      common_set_one(t)
      date_of_implementation(t)
      make_name(t)
      t.string :holiday_type_id, limit: 36, :required => true
    end
    primary_key_override(:holidays.to_s)
  end
end
