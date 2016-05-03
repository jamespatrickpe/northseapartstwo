class CreateAddresses < MainMigration
  def change
    create_table :addresses, :id => false do |t|
      common_set_one(t)
      t.string :contact_detail_id
      t.decimal :longitude, :precision => 18, :scale => 12, :limit => 32
      t.decimal :latitude, :precision => 18, :scale => 12, :limit => 32
    end
    primary_key_override(:addresses.to_s)
  end
end
