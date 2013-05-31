class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string  :key,         null: false
      t.string  :name,        null: false
      t.boolean :card_uid,    default: true
      t.boolean :resource,    default: true

      t.timestamps
    end

    add_index :events, :key, unique: true
  end
end
