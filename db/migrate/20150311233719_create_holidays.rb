class CreateHolidays < MainMigration
  def change
    create_table :holidays, :id => false   do |t|
      t.string :id, limit: 36, primary: true, null: false
      t.string :holiday_type_id, limit: 36, :required => true
      t.string :description, :limit => 256
      t.string :name, :limit => 64
      t.date :date_of_implementation, :required => true, :unique => true
      t.timestamps null: false
    end
    execute "ALTER TABLE holidays ADD PRIMARY KEY (id);"
  end
end
