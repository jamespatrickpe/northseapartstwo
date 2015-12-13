class CreateLumpAdjustments < ActiveRecord::Migration
  def change
    create_table :lump_adjustments, :id => false   do |t|
      t.string :id, limit: 36, :primary_key => true, null: false
      t.decimal :amount, :limit => 16, :precision => 16, :scale => 2
      t.boolean :signed_type, :required => true, default: true
      t.string :remark, :limit => 256
      t.string :employee_id, limit: 36,:required => true
      t.datetime :date_of_effectivity, :required => true
      t.timestamps null: false
    end
    execute "ALTER TABLE lump_adjustments ADD PRIMARY KEY (id);"
  end
end
