class HomeController < ApplicationController
  def homepage
    if current_user
      current_exercises= current_user.current_day_exercises
      @diets=[]
      current_exercises.each do |exercise|
        if exercise.status?(current_user.id)
          diets=Diet.where(exercise_id: exercise.id)
          diets.each do |diet|
            @diets << diet.name
          end
        end
      end
    end
    render :home
  end
end