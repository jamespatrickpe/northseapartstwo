class CreateFileSets < MainMigration
  def change
    create_table :file_sets, :id => false do |t|
      common_set_one(t)
      polymorphic_association(t)
      t.string :file, :limit => 512
    end
  end
end
