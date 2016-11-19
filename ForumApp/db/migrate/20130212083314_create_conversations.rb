class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.string :name
      t.integer :user_id
      t.integer :forum_id

      t.timestamps
    end
  end
end
