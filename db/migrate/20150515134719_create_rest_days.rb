class CreateRestDays < MainMigration
  def change
    create_table :rest_days, :id => false    do |t|
      t.string :id, limit: 36, primary: true, null: false
      t.string :day, :limit => 64, :default => "SUNDAY"
      t.string :employee_id, limit: 36,:required => true
      t.datetime :date_of_effectivity, :required => true
      t.timestamps null: false
    end
    execute "ALTER TABLE rest_days ADD PRIMARY KEY (id);"
  end
end
