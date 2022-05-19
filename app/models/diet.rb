class Diet < ApplicationRecord
  validates :name, presence: true
  belongs_to :exercise
end
