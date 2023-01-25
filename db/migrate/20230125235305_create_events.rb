class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.text :name
      t.datetime :event_date
      t.text :event_location

      t.timestamps
    end
  end
end
