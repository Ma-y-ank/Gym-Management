class UserMailer < ApplicationMailer
  def user_exercise_update
    @exercises = params[:exercises]
    #Sending exercises name to view
    @exercises.map! do |id|
      Exercise.find_by(id: id).name
    end
    @email= params[:email]

    mail(to: @email, subject: "Change in Workout Schedule")
  end
end
