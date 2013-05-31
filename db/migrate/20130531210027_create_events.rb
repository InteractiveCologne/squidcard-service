class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events, primary_key: :event_key do |t|
      t.string  :key,         null: false
      t.boolean :card_id,     default: true
      t.boolean :resource,    default: true

      t.timestamps
    end

    add_index :events, :key, unique: true
  end
end
