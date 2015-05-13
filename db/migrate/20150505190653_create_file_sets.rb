class CreateFileSets < ActiveRecord::Migration
  def change
    create_table :file_sets do |t|

      t.timestamps null: false
      t.string :path, :limit => 512
      t.string :description, :limit => 128
      t.references :rel_file_set, polymorphic: true

    end
  end
end
