class UserMailer < ApplicationMailer
  def user_exercise_update
    @exercises = params[:exercises]
    @email= params[:email]
    mail(to: @email, subject: "Change in Workout Schedule")
  end
end
