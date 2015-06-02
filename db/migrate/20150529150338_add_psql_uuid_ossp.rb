class AddPsqlUuidOssp < ActiveRecord::Migration
  def change
    execute <<-SQL
      create extension "uuid-ossp";
    SQL
  end
end
