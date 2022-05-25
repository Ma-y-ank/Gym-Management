class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  enum role: {trainee: 'Trainee', trainer: 'Trainer', admin: 'Admin'}
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable
  
  validates :name, presence: true
  belongs_to :trainer, 
    primary_key: :id,
    foreign_key: :trainer_id,
    class_name: :User,
    optional: true
  
  has_many :trainees,
    foreign_key: :trainer_id,
    class_name: :User

  has_many :user_exercises  
  has_many :exercises, through: :user_exercises

  has_many :diets, through: :exercises

  ROUTINE= 
  {
    'Monday': 'Abs',
    'Tuesday': 'Arm',
    'Wednesday': 'Chest',
    'Thursday': 'Back',
    'Friday': 'Leg',
    'Saturday': 'Shoulder',
    'Sunday': 'Back'
  }

  def current_day_exercises
    day= Date.today.strftime("%A").to_sym
    exercises.filter_by_category(User::ROUTINE[day])
  end

  def completed_exercises_count
    user_exercises.where(exercise_id: current_day_exercises.ids, completed: true).length
  end

  def remaining_exercises_percentage
    if current_day_exercises.length > 0  
      ((completed_exercises_count/current_day_exercises.length.to_f)*100).to_i
    else
      0
    end
  end
end
