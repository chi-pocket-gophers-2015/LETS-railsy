class AddDefaultValueToQueryStatus < ActiveRecord::Migration
  def change
    change_column_default(:queries, :status, "waiting")
  end
end
