class CreateProposals < ActiveRecord::Migration
  def change
    create_table :proposals do |t|
      t.string :status, default: "open"
      t.string :proposed_idea
      t.uuid :participation_id

      t.timestamps null: false
    end
    add_foreign_key :proposals, :participations
  end
end
