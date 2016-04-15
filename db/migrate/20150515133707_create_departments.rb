class CreateDepartments < MainMigration
  def change
    create_table :departments, :id => false    do |t|
      common_set_one(t)
      make_name(t)
    end
  end
end
