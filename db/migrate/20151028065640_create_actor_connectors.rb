class CreateActorConnectors < ActiveRecord::Migration
  def change
    create_table :actor_connectors, :id => false  do |t|
      t.string :id, limit: 36, primary: true, null: false
      t.string :relationship, :limit => 64
      t.string :relationship_type, :limit => 64
      t.timestamps
    end
    execute "ALTER TABLE actor_connectors ADD PRIMARY KEY (id);"
  end
end
