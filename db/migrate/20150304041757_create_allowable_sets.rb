class CreateAllowableSets < ActiveRecord::Migration
  def change
    create_table :allowable_sets, :id => false do |t|
      t.string :id, limit: 36, primary: true, null: false

      t.string :access_id, limit: 36,:required => true

      t.string :security_level, :limit => 64, :required => true
      t.string :controller, :limit => 64, :required => true
      t.string :action, :limit => 64, :required => true

      t.timestamps
    end
  end
end
