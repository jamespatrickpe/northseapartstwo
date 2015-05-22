class CreateRestdays < ActiveRecord::Migration
  def change
    create_table :restdays, :id => false    do |t|
      t.string :id, limit: 36, primary: true, null: false
      t.string :day, :limit => 64, :default => "SUNDAY"
      t.string :employee_id, limit: 36,:required => true

      t.timestamps null: false
    end
  end
end
