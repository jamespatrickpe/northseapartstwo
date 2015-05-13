class CreateVerifications < ActiveRecord::Migration
  def change
    create_table :verifications do |t|

      t.belongs_to :access, :required => true

      t.string :temp_email, :limit => 64, :required => true, :'index.html.erb' => true
      t.string :hashlink, :limit => 512
      t.boolean :verified, :default => 0

      t.timestamps
    end
  end
end
