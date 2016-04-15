class CreateActors < MainMigration
  def change
    create_table :actors, :id => false do |t|
      common_set_one(t)
      make_name(t)
      t.string :logo, :limit => 512
    end
    primary_key_override(:actors.to_s)
  end
end
