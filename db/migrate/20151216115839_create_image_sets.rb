class CreateImageSets < ActiveRecord::Migration
  def change
    create_table :image_sets, :id => false  do |t|
      t.string :id, limit: 36, primary: true, null: false
      t.string :picture, :limit => 512
      t.string :description, :limit => 256
      t.string :rel_image_set_id, limit: 36, required: true
      t.string :rel_image_set_type, required: true
      t.timestamps null: false
    end
    execute "ALTER TABLE image_sets ADD PRIMARY KEY (id);"
  end
end
