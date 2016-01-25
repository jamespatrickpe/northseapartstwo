class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses, :id => false   do |t|
      t.string :id, limit: 36, primary: true, null: false
      t.decimal :amount, :limit => 16, :precision => 16, :scale => 2
      t.string :category, :limit => 256
      t.string :remark, :limit => 256
      t.datetime :date_of_effectivity, :required => true
      t.timestamps null: false
    end
    execute "ALTER TABLE expenses ADD PRIMARY KEY (id);"
  end
end
