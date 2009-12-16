class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.integer :woeid
      t.string :name
      t.string :country
      t.integer :lat
      t.string :lon

      t.timestamps
    end
  end

  def self.down
    drop_table :locations
  end
end
