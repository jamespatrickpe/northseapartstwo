class CreateAddresses < MainMigration
  def change
    create_table :addresses, :id => false do |t|
      common_set_two(t)
      polymorphic_association(t)
      remark(t)
      t.decimal :longitude, :precision => 18, :scale => 12, :limit => 32
      t.decimal :latitude, :precision => 18, :scale => 12, :limit => 32
    end
  end
end
