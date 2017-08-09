class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.text :commentFront
      t.text :commentBack
      t.boolean :isFront
      t.string :color
      t.integer :x
      t.integer :y
      t.integer :width
      t.integer :height

      t.timestamps null: false
    end
  end
end
