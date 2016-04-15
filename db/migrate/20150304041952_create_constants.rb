class CreateConstants < MainMigration
  def change
    create_table :constants, :id => false  do |t|
      t.string :id, limit: 36, primary: true, null: false
      t.string :value, :limit => 64
      t.string :name, :limit => 256
      t.string :constant_type, :limit => 64
      t.datetime :date_of_effectivity, :required => true
      t.string :remark, :limit => 256
      t.timestamps
    end
    execute "ALTER TABLE constants ADD PRIMARY KEY (id);"
  end
end
