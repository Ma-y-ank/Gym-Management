class HomeController < ApplicationController
  def homepage
    if current_user
      current_exercises= current_user.current_day_exercises
      @diets=[]
      current_exercises.each do |exercise|
        if exercise.status?(current_user.id)
          @diets << Diet.find_by(exercise_id: exercise.id).name
        end
      end
    end
    render :home
  end
end