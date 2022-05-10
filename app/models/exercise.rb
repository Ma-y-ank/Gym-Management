class Exercise < ApplicationRecord
  enum category: {Back: "Back", Leg: "Leg", Chest: "Chest", Arm: "Arm", Abs: "Abs", Shoulder: "Shoulder"}
  
  has_many :user_exercises
  has_many :users, through: :user_exercises

  def favourite?(user_id)
    user_exercises.find_by(user_id: user_id).favourite?
  end
end
