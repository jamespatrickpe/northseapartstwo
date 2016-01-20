class CreatePayrolls < ActiveRecord::Migration
  def change
    create_table :payrolls, :id => false  do |t|

      t.string :id, limit: 36, primary: true, null: false
      t.string :employee_id, limit: 36,:required => true
      t.string :article, :required => true, default: "BASE"
      t.boolean :applicability, :required => true, default: false
      t.datetime :date_of_effectivity, :required => true, default: Time.now
      t.string :remark, :limit => 256
    t.timestamps
    end
    execute "ALTER TABLE payrolls ADD PRIMARY KEY (id);"
  end
end
