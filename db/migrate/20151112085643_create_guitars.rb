class CreateGuitars < ActiveRecord::Migration
  def change
    create_table :guitars do |t|
      t.string :manufacturer
      t.string :model

      t.timestamps null: false
    end
  end
end
