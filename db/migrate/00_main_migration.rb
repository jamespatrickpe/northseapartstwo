class MainMigration < ActiveRecord::Migration

  def uuid(t)
    t.string :id,
             :limit => 36,
             :null => false,
             :required => true,
             :unique => true,
             :index => true,
             :primary_key => true
  end

  def period_of_time(t)
    t.string :period_of_time, :limit => 64, :required => true
  end

  def remark(t)
    t.string :remark, :limit => 256
  end

  def employee_id(t)
    t.string :employee_id, :limit => 36, :required => true
  end

  def amount(t)
    t.decimal :amount, :limit => 16, :precision => 16, :scale => 2
  end

  def actor_id(t)
    t.string :actor_id, :limit => 36
  end

  def time_stamps(t)
    t.timestamps null: false
  end

  def polymorphic_association(t)
    t.string :rel_model_id, limit: 36,:required => true
    t.string :rel_model_type, limit: 36,:required => true
  end

  def date_of_implementation(t)
    t.date :date_of_implementation, :required => true, :default => DateTime.now
  end

  def time_of_implementation(t)
    t.time :time_of_implementation, :required => true, :default => DateTime.now
  end

  def datetime_of_implementation(t)
    t.datetime :datetime_of_implementation, :required => true
  end

  def url(t)
    t.string :url, :limit => 512
  end

  def make_name(t)
    t.string :name, :limit => 64, :required => true
  end

  # Primary Common Pattern for Most Migrations
  def common_set_one(t)
    uuid(t)
    remark(t)
    time_stamps(t)
  end

  # Secondary Common Pattern for Most Migrations
  def common_set_two(t)
    uuid(t)
    time_stamps(t)
  end

  # Manually set Primary Key because MySQL is having trouble translating Rails Commands
  def primary_key_override(table_name)
    execute "ALTER TABLE "+table_name+" ADD PRIMARY KEY (id);"
  end

end