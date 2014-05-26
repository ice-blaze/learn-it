class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :grade_interpreters
  has_many :grade_tutorials
  has_many :tutorials, inverse_of: :user
  has_many :interpreters,inverse_of: :user
end
