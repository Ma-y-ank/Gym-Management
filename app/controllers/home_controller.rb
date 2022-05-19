class HomeController < ApplicationController
  def home
    if current_user
      current_exercises= current_user.current_day_exercises
      # Get id of exercises which have been completed
      current_exercises= current_exercises.select {|exercise| exercise.completed?(current_user.id)}
      @diets = current_exercises.map(&:diets).flatten.pluck(:name)
      # @diets= current_exercises.map do |exercise|
      #   exercise.diets.map(&:name)
      # end.flatten
      # Diet.where(exercise: current_exercises)
      @pagy, @exercises = (current_user.admin? ?  pagy(Exercise.all, items: 4) : pagy(current_user.exercises, items: 4))
    end
  end
end
