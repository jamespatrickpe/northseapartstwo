class CreateVerifications < ActiveRecord::Migration
  def change
    create_table :verifications, :id => false  do |t|
      t.string :id, limit: 36, primary: true, null: false

      t.string :temp_email, :limit => 512, :required => true
      t.string :hashlink, :limit => 512
      t.string :access_id, limit: 36, :required => true
      t.boolean :verified, :default => 0

      t.timestamps
    end
  end
end
