class CreateBranches < MainMigration
  def change
    create_table :branches, :id => false   do |t|
      t.string :id, limit: 36, primary: true, null: false
      t.string :name, limit: 36,:required => true
      t.timestamps null: false
    end
    execute "ALTER TABLE branches ADD PRIMARY KEY (id);"
  end
end
