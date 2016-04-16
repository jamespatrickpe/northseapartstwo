class CreateAssociations < MainMigration
  def change
    create_table :associations, :id => false do |t|
      common_set_one(t)
      t.string :model_one_type, :limit => 36, :required => true
      t.string :model_one_id, :limit => 36, :required => true
      t.string :model_two_type, :limit => 36, :required => true
      t.string :model_two_id, :limit => 36, :required => true
    end
    primary_key_override(:associations.to_s)
  end
end
