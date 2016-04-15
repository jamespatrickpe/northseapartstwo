class CreateRateAdjustments < MainMigration
  def change
    create_table :rate_adjustments, :id => false   do |t|
      common_set_one(t)
      amount(t)
      employee_id(t)
      t.string :rate_of_time, :limit => 64, :required => true
      t.boolean :activated, :default => true
    end
  end
end
