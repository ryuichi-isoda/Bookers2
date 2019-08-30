class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books, dependent: :destroy
  validates :name, presence: true, length:{minimum: 2, maximum: 20}
  validates :introduction, length:{maximum: 50}
  attachment :profile_image
end
