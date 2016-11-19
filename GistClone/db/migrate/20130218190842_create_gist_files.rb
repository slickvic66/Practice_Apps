class CreateGistFiles < ActiveRecord::Migration
  def change
    create_table :gist_files do |t|
      t.integer :gist_id
      t.string :body

      t.timestamps
    end
  end
end
