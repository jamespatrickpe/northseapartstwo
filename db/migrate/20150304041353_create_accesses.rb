class CreateAccesses < ActiveRecord::Migration
  def change
    create_table :accesses do |t|
      t.string :username, :index => true, :limit => 64
      t.string :password_digest, :limit => 512
      t.boolean :remember_me, :default => 0
      t.string :security_level, :default => "NONE", :limit => 128
      t.belongs_to :entity
      t.boolean :enabled, :default => 0

      t.timestamps
    end


  end
end
