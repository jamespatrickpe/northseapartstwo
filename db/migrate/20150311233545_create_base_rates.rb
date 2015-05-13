class CreateBaseRates < ActiveRecord::Migration
  def change
    create_table :base_rates do |t|

      t.belongs_to :employee, :required => true

      t.decimal :amount, :limit => 32, :precision => 32, :scale => 2
      t.string :period_of_time, :limit => 32

      t.timestamps null: false
    end
  end
end
