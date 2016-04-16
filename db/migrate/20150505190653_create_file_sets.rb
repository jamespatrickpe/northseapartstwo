class CreateFileSets < MainMigration
  def change
    create_table :file_sets, :id => false do |t|
      common_set_one(t)
      polymorphic_association(t,:filesetable)
      t.string :file, :limit => 512
    end
    primary_key_override(:file_sets.to_s)
  end
end
