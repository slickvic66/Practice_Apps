class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :xcoord
      t.string :ycoord
      t.string :name
      t.integer :photo_id

      t.timestamps
    end
  end
end
