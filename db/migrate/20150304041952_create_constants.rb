class CreateConstants < ActiveRecord::Migration
  def change
    create_table :constants, :id => false  do |t|

      t.string :id, limit: 36, primary: true, null: false
      t.string :constant, :limit => 64
      t.string :name, :limit => 256
      t.string :constant_type, :limit => 64

      t.timestamps
    end
  end
end
