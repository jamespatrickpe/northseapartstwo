class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees, :id => false do |t|

      t.string :id, limit: 36, primary: true, null: false
      t.string :actor_id, limit: 36,:required => true
      t.string :branch_id, limit: 36,:required => true
      t.timestamps null: false

    end
  end
end

#links unique properties of employees to actor