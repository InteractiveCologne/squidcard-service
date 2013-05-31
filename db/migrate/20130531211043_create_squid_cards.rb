class CreateSquidCards < ActiveRecord::Migration
  def change
    create_table :squid_cards, primary_key: :uid do |t|
      t.integer :uid,        null: false
      t.string  :reference

      t.timestamps
    end

    add_index :squid_cards, :uid,        unique: true
    add_index :squid_cards, :reference
  end
end
