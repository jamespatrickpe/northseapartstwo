class CreateAddresses < MainMigration
  def change
    create_table :addresses, :id => false do |t|
      t.string :id, limit: 36, primary: true, null: false
      t.string :rel_model_id, limit: 36,:required => true
      t.string :rel_model_type, limit: 36,:required => true
      t.string :description, :limit => 256, :required => true
      t.decimal :longitude, :precision => 18, :scale => 12, :limit => 32
      t.decimal :latitude, :precision => 18, :scale => 12, :limit => 32
      t.timestamps
    end
    execute "ALTER TABLE addresses ADD PRIMARY KEY (id);"
  end
end
