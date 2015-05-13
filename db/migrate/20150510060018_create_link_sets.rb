class CreateLinkSets < ActiveRecord::Migration
  def change
    create_table :link_sets do |t|

      t.string :label, :limit => 128
      t.string :url, :limit => 512
      t.references :rel_link_set, polymorphic: true

      t.timestamps null: false
    end
  end
end
