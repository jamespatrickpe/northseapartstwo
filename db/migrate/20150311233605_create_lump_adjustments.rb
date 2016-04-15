class CreateLumpAdjustments < MainMigration
  def change
    create_table :lump_adjustments, :id => false   do |t|
      common_set_one(t)
      datetime_of_implementation(t)
      employee_id(t)
      amount(t)
    end
  end
end
