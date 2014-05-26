class Interpreter < ActiveRecord::Base
  has_many :comment_interpreters
  has_many :grade_interpreters
  has_many :functions, inverse_of: :interpreter
  has_many :tutorials, inverse_of: :interpreter
  belongs_to :user

  validates :title,:description, :open_token, :close_token, :user, presence: true
  validates :is_finish, :inclusion => {:in => [true, false]}
  validates :open_token, length: { is: 1 }
  validates :close_token, length: { is: 1 }
end
