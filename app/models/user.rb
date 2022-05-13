require 'byebug'
class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  enum role: [:user, :trainer, :admin]
  validates :role, inclusion: {in: roles.keys} 
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_many :trainees,
    foreign_key: :trainer_id,
    class_name: :User

  belongs_to :trainer, 
    primary_key: :id,
    foreign_key: :trainer_id,
    class_name: :User,
    optional: true

  has_many :user_exercises  
  has_many :exercises, through: :user_exercises

  ROUTINE= 
  {
    'Monday': 'Back',
    'Tuesday': 'Chest',
    'Wednesday': 'Arm',
    'Thursday': 'Leg',
    'Friday': 'Abs',
    'Saturday': 'Shoulder'
  }

  def current_day_exercises
    day= Date.today.strftime("%A").to_sym
    exercises.where(category: User::ROUTINE[day])
  end

  def completed_exercises
    exercise_ids= current_day_exercises.map(&:id)
    user_exercises.where(exercise_id: exercise_ids).where(status: true).length
  end

  def remaining_exercises
    ((completed_exercises/current_day_exercises.length.to_f)*100).to_i
  end
end
