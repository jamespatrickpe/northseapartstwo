class CreateAdvancedPaymentsToEmployees < ActiveRecord::Migration

  def change
    create_table :advanced_payments_to_employees , :id => false   do |t|
      t.string :id, limit: 36, primary: true, null: false

      t.string :employee_id, limit: 36,:required => true

      t.decimal :amount, :limit => 16,:precision => 16, :scale => 2, :required => true
      t.string :description, :limit => 64
      t.decimal :rate_of_payment, :limit => 16,:precision => 16, :scale => 2
      t.string :rate_of_time, :limit => 64
      t.string :status, :limit => 64, :default => "AWAITING"

      t.timestamps null: false
    end
  end

end
