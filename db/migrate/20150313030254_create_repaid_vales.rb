class CreateRepaidVales < ActiveRecord::Migration
  def change
    create_table :repaid_vales do |t|

      t.belongs_to :vale, :required => true

      t.decimal :amount, :limit => 16, :precision => 16, :scale => 2, :required => true

      t.timestamps null: false

    end
  end
end
