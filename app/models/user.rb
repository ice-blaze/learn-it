class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :grade_interpreters
  has_many :grade_tutorials
  has_many :tutorials, inverse_of: :user
  has_many :interpreters,inverse_of: :user
  has_many :interpreter_comments, inverse_of: :user
  has_many :function_comments, inverse_of: :user
  has_many :tutorial_comments, inverse_of: :user
  has_many :part_comments, inverse_of: :user

  has_many :interpreter_comment_votes
  has_many :interpreter_comments, through: :interpreter_comment_votes

  has_many :tutorial_comment_votes
  has_many :tutorial_comments, through: :tutorial_comment_votes

  has_many :function_comment_votes
  has_many :function_comments, through: :function_comment_votes

  has_many :part_comment_votes
  has_many :part_comments, through: :part_comment_votes
end
