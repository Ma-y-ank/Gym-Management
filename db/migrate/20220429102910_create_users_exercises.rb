class CreateUsersExercises < ActiveRecord::Migration[5.2]
  def change
    create_table :users_exercises do |t|
      t.integer :user_id
      t.integer :exercise_id
      t.boolean :favourite, default: false
    end
  end
end
