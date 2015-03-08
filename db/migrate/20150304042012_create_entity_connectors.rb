class CreateEntityConnectors < ActiveRecord::Migration
  def change
    create_table :entity_connectors do |t|

      t.integer :entity_id_one, :limit => 8
      t.string :relationship, :limit => 128
      t.string :relationship_type, :limit => 128
      t.integer :entity_id_two, :limit => 8
      t.timestamps

    end
  end
end
