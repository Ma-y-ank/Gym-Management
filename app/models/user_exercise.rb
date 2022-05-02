class UserExercise < ApplicationRecord
  self.table_name= "users_exercises"

  belongs_to :user
  belongs_to :exercise
end
