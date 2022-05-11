# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def user_exercise_update
    exercises= [Exercise.new(name: 'Lat Pulldown', category: 'Back', description: 'For back', link: 'https://y.com')]
    UserMailer.with(exercises: exercises, email: 'mayank.agarwal0903@icloud.com').user_exercise_update
  end
end
