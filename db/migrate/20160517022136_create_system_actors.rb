class CreateSystemActors < MainMigration
  def change
    create_table :system_actors, :id => false do |t|
      common_set_one(t)
      make_name(t)
      t.string :logo, :limit => 512
    end
    primary_key_override(:system_actors.to_s)
  end
end
