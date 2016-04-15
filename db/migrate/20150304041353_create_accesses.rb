class CreateAccesses < MainMigration
  def change
    create_table :accesses, :id => false  do |t|
      common_set_two(t)
      actor_id(t)
      t.string :username, :limit => 64
      t.string :password_digest, :limit => 512, :required => true
      t.string :email, :limit => 512, :required => true
      t.string :hash_link, :limit => 512, :required => true, :unique => true
      t.integer :attempts, :default => 0, :limit => 1
      t.datetime :last_login
      t.boolean :verification, :default => 0
      t.boolean :remember_me, :default => 0
    end
  end
end