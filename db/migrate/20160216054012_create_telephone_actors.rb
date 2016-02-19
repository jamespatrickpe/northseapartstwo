class CreateTelephoneActors < ActiveRecord::Migration
  def change
    create_table :telephones_actors, :id => false  do |t|
      t.string :id, limit: 36, primary: true, null: false
      t.string :actor_id, limit: 36, :required => true
      t.string :telephone_id, limit: 36, :required => true
      t.timestamps
    end
  end
end
