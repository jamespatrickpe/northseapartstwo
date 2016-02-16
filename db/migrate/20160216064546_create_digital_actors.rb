class CreateDigitalActors < ActiveRecord::Migration
  def change
    create_table :digitals_actors, :id => false  do |t|
      t.string :id, limit: 36, primary: true, null: false
      t.string :actor_id, limit: 36, :required => true
      t.string :digital_id, limit: 36, :required => true
      t.timestamps
    end
  end
end
