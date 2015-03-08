class CreateConstants < ActiveRecord::Migration
  def change
    create_table :constants do |t|

      t.string :constant, :limit => 512
      t.string :description, :limit => 512
      t.string :type, :limit => 64

      t.timestamps
    end
  end
end
