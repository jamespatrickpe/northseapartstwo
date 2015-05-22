class CreateRepaidVales < ActiveRecord::Migration
  def change
    create_table :repaid_vales, :id => false   do |t|
      t.string :id, limit: 36, primary: true, null: false
      t.decimal :amount, :limit => 16, :precision => 16, :scale => 2, :required => true
      t.string :vale_id, limit: 36,:required => true

      t.timestamps null: false
    end
  end
end
