class CreateBaseRates < ActiveRecord::Migration
  def change
    create_table :base_rates, :id => false   do |t|
      t.string :id, limit: 36, primary: true, null: false

      t.string :employee_id,limit: 36, :required => true
      t.string :signed_type, limit: 64, :required => true

      t.decimal :amount, :limit => 16, :precision => 16, :scale => 2
      t.string :period_of_time, :limit => 64

      t.string :remark, :limit => 256

      t.datetime :start_of_effectivity, :required => true
      t.datetime :end_of_effectivity

      t.timestamps null: false
    end
  end
end
