class CreateAttendances < ActiveRecord::Migration[8.0]
  def change
    create_table :attendances do |t|
      t.references :attendee, null: false, foreign_key: { to_table: :users }
      t.references :attended_event, null: false, foreign_key: { to_table: :events }
      t.timestamps
    end
  end
end
