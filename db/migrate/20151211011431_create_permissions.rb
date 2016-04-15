class CreatePermissions < MainMigration
  def change
    create_table :permissions, :id => false do |t|
      common_set_one(t)
      t.string :access_id, limit: 36, :required => true
      t.string :can, limit: 256, :required => true
    end
  end
end