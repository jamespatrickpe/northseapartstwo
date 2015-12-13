class CreateAccesses < ActiveRecord::Migration
  def change
    create_table :accesses, :id => false  do |t|
      t.string :id, limit: 36, primary: true, null: false
      t.string :actor_id, limit: 36, :required => true
      t.string :username, :limit => 64
      t.string :password_digest, :limit => 512, :required => true
      t.string :email, :limit => 512, :required => true
      t.string :hashlink, :limit => 512, :required => true, :unique => true
      t.integer :attempts, :default => 0, :limit => 1
      t.boolean :verification, :default => 0
      t.boolean :remember_me, :default => 0
      t.timestamps
    end
    execute "ALTER TABLE accesses ADD PRIMARY KEY (id);"
  end
end
