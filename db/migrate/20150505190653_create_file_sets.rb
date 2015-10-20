class CreateFileSets < ActiveRecord::Migration
  def change
    create_table :file_sets, :id => false    do |t|
      t.string :id, limit: 36, primary: true, null: false
      t.timestamps null: false
      t.string :path, :limit => 512
      t.string :description, :limit => 256
      t.string :rel_file_set_id, limit: 36, required: true
      t.string :rel_file_set_type, required: true
      #t.references :rel_file_set, polymorphic: true

    end
  end
end