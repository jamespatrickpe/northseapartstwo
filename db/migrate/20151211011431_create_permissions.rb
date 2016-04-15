class CreatePermissions < MainMigration
  def change
    create_table :permissions, :id => false do |t|
      t.string :id, limit: 36, primary: true, null: false
      t.string :access_id, limit: 36, :required => true
      t.string :can, limit: 256, :required => true
      t.string :remark, :limit => 256
      t.timestamps null: false
    end
    execute "ALTER TABLE permissions ADD PRIMARY KEY (id);"
  end
end