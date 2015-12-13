class CreateActors < ActiveRecord::Migration
  def change
    create_table :actors, :id => false do |t|
      t.string :id, limit: 36, primary: true, null: false
      t.string :name, :limit => 64, :required => true
      t.string :description, :limit => 256
      t.string :logo, :limit => 512
      t.timestamps
    end
    execute "ALTER TABLE actors ADD PRIMARY KEY (id);"
  end
end
