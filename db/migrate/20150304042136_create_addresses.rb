class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses, :id => false do |t|
      t.string :id, limit: 36, primary: true, null: false
      t.string :actor_id, limit: 36,:required => true
      t.string :description, :limit => 256, :required => true
      t.decimal :longitude, :precision => 18, :scale => 12, :limit => 32
      t.decimal :latitude, :precision => 18, :scale => 12, :limit => 32
      t.timestamps
    end
    execute "ALTER TABLE addresses ADD PRIMARY KEY (id);"
  end
end
