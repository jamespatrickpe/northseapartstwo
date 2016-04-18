class CreateImageSets < MainMigration
  def change
    create_table :image_sets, :id => false  do |t|
      common_set_one(t)
      t.string :imagesetable_id
      t.string :imagesetable_type
      t.string :picture, :limit => 512
      t.integer :priority, :default => 0
    end
    primary_key_override(:image_sets.to_s)
  end
end