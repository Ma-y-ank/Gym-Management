class CreateExercises < ActiveRecord::Migration[5.2]
  def change
    create_table :exercises do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.string :category, null: false
      t.string :link, null: false

      t.timestamps
    end
  end
end
