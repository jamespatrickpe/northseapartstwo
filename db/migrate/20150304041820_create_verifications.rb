class CreateVerifications < ActiveRecord::Migration
  def change
    create_table :verifications do |t|

      t.string :temp_email, :limit => 128
      t.string :hashlink, :limit => 512
      t.boolean :verified, :default => 0

      t.belongs_to :access

      t.timestamps
    end
  end
end
