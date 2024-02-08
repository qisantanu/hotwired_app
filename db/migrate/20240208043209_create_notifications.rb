class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.integer :status, default: 0, null: false
      t.timestamps
    end
  end
end
