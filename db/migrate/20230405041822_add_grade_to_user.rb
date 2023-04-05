class AddGradeToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :grade, :integer, null: false, limit: 1, default: 1
  end
end
