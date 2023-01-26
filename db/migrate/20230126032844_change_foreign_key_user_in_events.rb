class ChangeForeignKeyUserInEvents < ActiveRecord::Migration[7.0]
  def change
    remove_reference :events, :user, index: false
    add_reference :events, :host, foreign_key: { to_table: :users }, index: true
  end
end
