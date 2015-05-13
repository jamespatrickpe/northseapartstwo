class CreateVales < ActiveRecord::Migration
  def change
    create_table :vales do |t|

      t.belongs_to :employee, :required => true

      t.decimal :amount, :limit => 16,:precision => 16, :scale => 2, :required => true
      t.string :description, :limit => 64
      t.decimal :rate_of_payment, :limit => 16,:precision => 16, :scale => 2
      t.string :rate_of_time, :limit => 64
      t.string :status, :limit => 64, :default => "AWAITING"

      t.timestamps null: false
    end
  end
end
