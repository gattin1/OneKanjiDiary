class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :diaries, dependent: :destroy

  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, uniqueness: true
end
+
