class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :user, foreign_key: true
      t.references :fish, foreign_key: true

      t.timestamps
    end

    add_index :likes, [:user_id, :fish_id], unique: true
  end
end
