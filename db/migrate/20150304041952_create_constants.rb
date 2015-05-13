class CreateConstants < ActiveRecord::Migration
  def change
    create_table :constants do |t|

      t.string :constant, :limit => 64, :'index.html.erb' => true
      t.string :description, :limit => 128
      t.string :name, :limit => 64, :'index.html.erb' => true

      t.timestamps
    end
  end
end
