class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
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
end
