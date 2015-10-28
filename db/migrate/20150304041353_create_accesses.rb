class CreateAccesses < ActiveRecord::Migration
  def change
    create_table :accesses, :id => false  do |t|

      t.string :id, limit: 36, primary: true, null: false
      t.string :actor_id, limit: 36, :required => true
      t.string :username, :limit => 64
      t.string :password_digest, :limit => 512

      #t.boolean :remember_me, :default => 0
      #t.boolean :enabled, :default => 0

      t.timestamps
    end


  end
end
