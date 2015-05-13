class CreateAccesses < ActiveRecord::Migration
  def change
    create_table :accesses do |t|

      t.belongs_to :entity, :required => true

      t.string :username, :'index.html.erb' => true, :limit => 64
      t.string :password_digest, :limit => 512
      t.boolean :remember_me, :default => 0

      t.boolean :enabled, :default => 0

      t.timestamps
    end


  end
end
