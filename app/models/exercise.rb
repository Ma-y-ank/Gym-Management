class Exercise < ApplicationRecord
  has_many :exercise_users,
    foreign_key: :exercise_id,
    class_name: :UserExercise

  has_many :users, through: :exercise_users

  def favourite?(user)
    UserExercise.find_by(user_id: user, exercise_id: self.id).favourite?
  end
end
