class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string  :key,         null: false, limit: 40
      t.string  :name,        null: false, limit: 255
      t.boolean :card_uid,    default: true
      t.boolean :resource,    default: true
      t.string  :url,         null: false, limit: 255
      t.string  :method,      null: false, default: :post, limit: 10
      t.string  :format,      null: false, default: :json, limit: 10

      t.timestamps
    end

    add_index :events, :key, unique: true
  end
end
