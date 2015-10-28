class CreateBranches < ActiveRecord::Migration
  def change
    create_table :branches, :id => false   do |t|
      t.string :id, limit: 36, primary: true, null: false
      t.string :actor_id, limit: 36,:required => true
      t.timestamps null: false

    end
  end
end
