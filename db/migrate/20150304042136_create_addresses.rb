class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|

      t.belongs_to :contact_detail, :required => true

      t.string :description, :limit => 256, :required => true
      t.decimal :longitude, :precision => 18, :scale => 12, :limit => 32
      t.decimal :latitude, :precision => 18, :scale => 12, :limit => 32


      t.timestamps
    end
  end
end
