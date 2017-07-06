class CreateFriendships < ActiveRecord::Migration[5.1]
  def change
    create_table :friendships do |t|
      t.integer :user_id
      t.integer :friend_id
      t.string :status

      t.timestamps
    end

    add_index(:friendships, [:user_id, :friend_id], unique: true)
    add_index(:friendships, [:friend_id, :user_id], unique: true)
  end
end
