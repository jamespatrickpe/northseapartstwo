class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles, :id => false do |t|
      t.string :id, limit: 36, primary: true, null: false
      t.string :type_of_vehicle,:limit => 64
      t.string :plate_number,:limit => 64
      t.string :orcr,:limit => 64
      t.string :remark, :limit => 256
      t.datetime :date_of_registration
      t.timestamps null: false
    end
    execute "ALTER TABLE vehicles ADD PRIMARY KEY (id);"
  end
end
