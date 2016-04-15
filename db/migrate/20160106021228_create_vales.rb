class CreateVales < MainMigration
  def change
    create_table :vales, :id => false do |t|

      t.string :id, limit: 36, :primary_key => true, null: false
      t.boolean :approval_status, :required => true, default: false
      t.decimal :amount, :limit => 16, :precision => 16, :scale => 2,:required => true
      t.decimal :amount_of_deduction, :limit => 16, :precision => 16, :scale => 2,:required => true
      t.string :period_of_deduction, :limit => 64,:required => true
      t.string :remark, :limit => 256
      t.string :employee_id, limit: 36,:required => true
      t.datetime :date_of_effectivity, :required => true
      t.timestamps null: false
    end
    execute "ALTER TABLE vales ADD PRIMARY KEY (id);"
  end
end
