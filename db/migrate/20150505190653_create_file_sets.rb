class CreateFileSets < ActiveRecord::Migration
  def change
    create_table :file_sets, :id => false    do |t|
      t.string :id, limit: 36, primary: true, null: false
      t.string :file, :limit => 512
      t.string :description, :limit => 256
      t.string :rel_file_set_id, limit: 36, required: true
      t.string :rel_file_set_type, required: true
      t.timestamps null: false
    end
    execute "ALTER TABLE file_sets ADD PRIMARY KEY (id);"
  end
end
