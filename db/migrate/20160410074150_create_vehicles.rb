class CreateVehicles < MainMigration
  def change
    create_table :vehicles, :id => false do |t|
      common_set_one(t)
      t.decimal :capacity_m3, precision: 20, scale: 10
      t.decimal :load_kg, precision: 20, scale: 10
      t.string :type_of_vehicle,:limit => 32
      t.string :brand,:limit => 32
      date_of_implementation(t)
      t.string :plate_number,:limit => 32
      t.string :oil,:limit => 32
    end
    primary_key_override(:vehicles.to_s)
  end
end
