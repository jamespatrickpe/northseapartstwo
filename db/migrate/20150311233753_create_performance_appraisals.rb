class CreatePerformanceAppraisals < MainMigration
  def change
    create_table :performance_appraisals, :id => false   do |t|
      t.string :id, limit: 36, primary: true, null: false
      t.string :employee_id, limit: 36,:required => true
      t.string :description, :limit => 256
      t.string :category, :limit => 64
      t.decimal :score, :limit => 16, :precision => 16, :scale => 2, :required => true
      t.timestamps null: false
    end
    execute "ALTER TABLE performance_appraisals ADD PRIMARY KEY (id);"
  end
end
