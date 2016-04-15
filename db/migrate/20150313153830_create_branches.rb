class CreateBranches < MainMigration
  def change
    create_table :branches, :id => false   do |t|
      common_set_one(t)
      make_name(t)
    end
  end
end
