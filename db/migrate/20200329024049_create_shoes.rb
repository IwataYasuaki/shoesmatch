class CreateShoes < ActiveRecord::Migration[5.2]
  def change
    create_table :shoes do |t|
      t.references :user, foreign_key: true
      t.float :left_size
      t.float :right_size
      t.string :maker
      t.string :name
      t.text :description
      t.references :shoe_status, foreign_key: true

      t.timestamps
    end
  end
end
