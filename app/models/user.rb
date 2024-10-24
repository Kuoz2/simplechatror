class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

ADMIN_ROLE = 'admin'.freeze
USER_ROLE = 'user'.freeze

has_many :user_rooms
has_many :rooms, through: :user_rooms
has_many :messages


def admin?
  role == ADMIN_ROLE
end

def user?
  role == USER_ROLE
end

end
