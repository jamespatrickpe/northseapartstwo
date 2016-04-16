class CreateLinkSets < MainMigration
  def change
    create_table :link_sets, :id => false do |t|
      common_set_one(t)
      polymorphic_association(t,:linksetable)
      url(t)
    end
    primary_key_override(:link_sets.to_s)
  end
end
