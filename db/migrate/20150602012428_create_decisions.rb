class CreateDecisions < ActiveRecord::Migration
  def change
    create_table :decisions do |t|
      t.string :context, null: false
      t.boolean :is_active, default: true

      t.timestamps null: false
    end
  end
end
