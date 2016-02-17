class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :name
      t.text :body
      t.integer :top_position
      t.integer :left_position
      t.integer :top_offset
      t.integer :left_offset

      t.timestamps null: false
    end
  end
end
