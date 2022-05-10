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
end
