class CreateEntityConnectors < ActiveRecord::Migration
  def change
    create_table :entity_connectors do |t|

      t.string :relationship, :limit => 64
      t.string :relationship_type, :limit => 64

      #Cannot figure this out
      t.belongs_to :entity, :class_name => 'Entity'
      t.belongs_to :entity, :class_name => 'Entity'

      t.timestamps

    end
  end
end
