class CreateFileSets < MainMigration
  def change
    create_table :file_sets, :id => false do |t|
      common_set_one(t)
      t.string :filesetable_id
      t.string :filesetable_type
      t.string :file, :limit => 512
    end
    primary_key_override(:file_sets.to_s)
  end
end
