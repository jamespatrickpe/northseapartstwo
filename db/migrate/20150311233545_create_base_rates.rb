class CreateBaseRates < MainMigration
  def change
    create_table :base_rates, :id => false do |t|
      common_set_one(t)
      employee_id(t)
      amount(t)
      period_of_time(t)
      t.datetime :start_of_effectivity, :required => true
      t.datetime :end_of_effectivity, :required => true
      t.string :rate_type,:limit => 64, default: 'other'
    end
  end
end
