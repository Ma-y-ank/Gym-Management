class CreateDiets < ActiveRecord::Migration[5.2]
  def change
    create_table :diets do |t|
      t.string :name, null: false
      t.references :exercise, foreign_key: true

      t.timestamps
    end
  end
end
