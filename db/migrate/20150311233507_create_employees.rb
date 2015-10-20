class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees, :id => false do |t|
      t.string :id, limit: 36, primary: true, null: false

      t.string :entity_id, limit: 36,:required => true
      t.timestamps null: false

    end
  end
end