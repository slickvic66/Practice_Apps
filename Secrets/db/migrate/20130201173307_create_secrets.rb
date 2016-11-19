class CreateSecrets < ActiveRecord::Migration
  def change
    create_table :secrets do |t|
      t.text :body
      t.integer :user_id

      t.timestamps
    end
  end
end
