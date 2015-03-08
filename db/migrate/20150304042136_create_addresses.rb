class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|

      t.string :description, :limit => 256
      t.decimal :longitude, :precision => 18, :scale => 12, :limit => 32
      t.decimal :latitude, :precision => 18, :scale => 12, :limit => 32
      t.belongs_to :contact_detail

      t.timestamps
    end
  end
end
