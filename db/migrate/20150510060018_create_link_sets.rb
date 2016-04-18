class CreateLinkSets < MainMigration
  def change
    create_table :link_sets, :id => false do |t|
      common_set_one(t)
      url(t)
      t.string :linksetable_id
      t.string :linksetable_type
    end
    primary_key_override(:link_sets.to_s)
  end
end
