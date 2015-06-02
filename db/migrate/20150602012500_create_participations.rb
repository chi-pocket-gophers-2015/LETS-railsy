class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations, id: :uuid, default: 'uuid_generate_v4()' do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :decision, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
