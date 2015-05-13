class CreateEntities < ActiveRecord::Migration
  def change
    create_table :entities do |t|

      t.string :name, :limit => 64, :required => true
      t.string :description, :limit => 256
      t.string :logo, :limit => 512

      t.timestamps
    end
  end
end
