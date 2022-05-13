class CreateUserExercises < ActiveRecord::Migration[5.2]
  def change
    create_table :user_exercises do |t|
      t.integer :user_id
      t.integer :exercise_id
      t.boolean :favourite, default: false
      t.boolean :status, default: false
    end
  end
end
