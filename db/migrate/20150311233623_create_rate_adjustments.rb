class CreateRateAdjustments < ActiveRecord::Migration
  def change
    create_table :rate_adjustments, :id => false   do |t|
      t.string :id, limit: 36, primary: true, null: false

      t.string :employee_id, limit: 36,:required => true

      t.decimal :amount, :limit => 16, :precision => 16, :scale => 2
      t.string :signed_type, :limit => 64, :'index.html.erb' => true
      t.string :rate_of_time, :limit => 64, :required => true
      t.string :description, :limit => 256
      t.boolean :activated, :default => true

      t.timestamps null: false
    end
  end
end
