class Exercise < ApplicationRecord
  has_many :exercise_users,
    foreign_key: :exercise_id,
    class_name: :UserExercise

  has_many :users, through: :exercise_users
end
