class CreateVales < MainMigration
  def change
    create_table :vales, :id => false do |t|
      common_set_one(t)
      amount(t)
      employee_id(t)
      datetime_of_implementation(t)
      period_of_time(t)
      t.boolean :approval_status, :required => true, default: false
      t.decimal :amount_of_deduction, :limit => 16, :precision => 16, :scale => 2,:required => true
    end
  end
end
