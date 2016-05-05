class CreateVehicles < MainMigration
  def change
    create_table :vehicles, :id => false do |t|
      common_set_one(t)
      date_of_implementation(t)
      t.decimal :capacity_m3, :limit => 16
      t.string :type_of_vehicle,:limit => 64
      t.string :plate_number,:limit => 64
      t.string :orcr,:limit => 64
    end
    primary_key_override(:vehicles.to_s)
  end
end
