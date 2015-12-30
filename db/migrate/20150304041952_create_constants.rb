class CreateConstants < ActiveRecord::Migration
  def change
    create_table :constants, :id => false  do |t|
      t.string :id, limit: 36, primary: true, null: false
      t.string :value, :limit => 64
      t.string :name, :limit => 256
      t.string :constant_type, :limit => 64
      t.string :remark, :limit => 256
      t.timestamps
    end
    execute "ALTER TABLE settings ADD PRIMARY KEY (id);"
  end
end
