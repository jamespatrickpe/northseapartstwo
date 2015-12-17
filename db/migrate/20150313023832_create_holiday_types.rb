class CreateHolidayTypes < ActiveRecord::Migration
  def change
    create_table :holiday_types, :id => false   do |t|
      t.string :id, limit: 36, primary: true, null: false
      t.string :type_name, :limit => 64, :required => true
      t.decimal :rate_multiplier, :precision => 16, :scale => 2, :limit => 16
      t.decimal :overtime_multiplier, :precision => 16, :scale => 2, :limit => 16
      t.decimal :rest_day_multiplier, :precision => 16, :scale => 2, :limit => 16
      t.decimal :overtime_rest_day_multiplier, :precision => 16, :scale => 2, :limit => 16
      t.boolean :no_work_pay, :default => false
      t.timestamps null: false
    end
    execute "ALTER TABLE holiday_types ADD PRIMARY KEY (id);"
  end
end
