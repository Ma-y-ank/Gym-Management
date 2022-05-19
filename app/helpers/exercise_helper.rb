module ExerciseHelper
  def exercise_categories
    Exercise.categories.keys.map(&:titleize)
  end
end
