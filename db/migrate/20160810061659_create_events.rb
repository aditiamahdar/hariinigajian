class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :event_id
      t.string :name
      t.text :description
      t.integer :price, default: 0

      t.timestamps
    end
  end
end
