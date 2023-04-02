class CreateFishes < ActiveRecord::Migration[7.0]
  def change
    create_table :fishes do |t|
      t.references  :user,            null: false
      t.string      :image
      t.datetime    :fishing_date,    null: false
      t.string      :body,            null: false
      t.decimal     :latitude,        null: false, precision: 11, scale: 8
      t.decimal     :longitude,       null: false, precision: 11, scale: 8
      t.references  :species,         null: false
      t.integer     :size
      t.integer     :weather,          null: false, limit: 1
      t.integer     :wind_direction,  null: false, limit: 1
      t.decimal     :wind_speed,      null: false, precision: 5, scale: 2
      t.decimal     :temperature,     null: false, precision: 5, scale: 2
      t.integer     :tide_name,       null: false, limit: 1

      t.timestamps
    end
  end
end
