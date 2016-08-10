class AddUniqIndexEventId < ActiveRecord::Migration[5.0]
  def change
    add_index(:events, :event_id, unique: true)
  end
end
