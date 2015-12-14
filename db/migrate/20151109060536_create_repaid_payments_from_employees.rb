class CreateRepaidPaymentsFromEmployees < ActiveRecord::Migration
  def change
    create_table :repaid_payments_from_employees , :id => false   do |t|
      t.string :id, limit: 36, primary: true, null: false
      t.decimal :amount, :limit => 16, :precision => 16, :scale => 2, :required => true
      t.string :advanced_payments_to_employee_id, limit: 36,:required => true
      t.timestamps null: false
    end
    execute "ALTER TABLE repaid_payments_from_employees ADD PRIMARY KEY (id);"
  end
end
