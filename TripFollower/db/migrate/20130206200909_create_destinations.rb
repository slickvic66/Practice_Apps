class CreateDestinations < ActiveRecord::Migration
  def change
    create_table :destinations do |t|
      t.string :name
      t.string :location
      t.binary :image
      t.text :thoughts

      t.timestamps
    end
  end
end
