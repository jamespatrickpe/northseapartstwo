class CreateLinkSets < ActiveRecord::Migration
  def change
    create_table :link_sets, :id => false    do |t|
      t.string :id, limit: 36, primary: true, null: false
      t.string :label, :limit => 64
      t.string :url, :limit => 512
      t.string :rel_link_set_id, limit: 36, required: true
      t.string :rel_link_set_type, required: true
      t.timestamps null: false
    end
    execute "ALTER TABLE link_sets ADD PRIMARY KEY (id);"
  end
end
