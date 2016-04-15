class CreateImageSets < MainMigration
  def change
    create_table :image_sets, :id => false  do |t|
      common_set_one(t)
      polymorphic_association(t)
      t.string :picture, :limit => 512
      t.integer :priority, :default => 0
    end
  end
end