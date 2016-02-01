class CreateDigitals < ActiveRecord::Migration
  def change
    create_table :digitals, :id => false  do |t|
      t.string :id, limit: 36, primary: true, null: false
      t.string :rel_model_id, limit: 36,:required => true
      t.string :rel_model_type, limit: 36,:required => true
      t.string :url, :limit => 512, :required => true
      t.string :description, :limit => 256
      t.timestamps
    end
    execute "ALTER TABLE digitals ADD PRIMARY KEY (id);"
  end
end
