class CreateTelephones < ActiveRecord::Migration
  def change
    create_table :telephones, :id => false  do |t|
      t.string :id, limit: 36, primary: true, null: false
      t.string :contact_detail_id, limit: 36,:required => true
      t.string :digits, :limit => 64, :required => true
      t.string :description, :limit => 256
      t.timestamps
    end
    execute "ALTER TABLE telephones ADD PRIMARY KEY (id);"
  end
end
