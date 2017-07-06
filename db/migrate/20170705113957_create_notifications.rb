class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.references :user, foreign_key: true
      t.references :item, polymorphic: true
      t.boolean :viewed, default: false

      t.timestamps
    end
  end
end
