class CreateEntities < ActiveRecord::Migration
  def change
    create_table :entities do |t|

      t.string :name, :limit => 128
      t.string :description, :limit => 512
      t.string :logo, :limit => 512

      t.timestamps
    end
  end
end
