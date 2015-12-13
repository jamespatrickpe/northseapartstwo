class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments, :id => false    do |t|
      t.string :id, limit: 36, primary: true, null: false
      t.string :description, :limit => 256
      t.string :label, :limit => 64
      t.timestamps null: false
    end
    execute "ALTER TABLE departments ADD PRIMARY KEY (id);"
  end
end
