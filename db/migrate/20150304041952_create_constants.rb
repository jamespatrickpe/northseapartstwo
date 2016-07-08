class CreateConstants < MainMigration
  def change
    create_table :constants, :id => false  do |t|
      common_set_one(t)
      make_name(t)
      date_of_implementation(t)
      t.string :value, :limit => 128
      t.string :constant_type, :limit => 128
    end
    primary_key_override(:constants.to_s)
  end
end
