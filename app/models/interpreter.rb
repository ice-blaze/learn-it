class Interpreter < ActiveRecord::Base
  has_many :interpreter_comments, inverse_of: :interpreter
  has_many :interpreter_grades, inverse_of: :interpreter
  has_many :functions, inverse_of: :interpreter
  has_many :tutorials, inverse_of: :interpreter
  belongs_to :user

  validates :title,:description, :open_token, :close_token, :user, presence: true
  validates :is_finish, inclusion: [true, false]
  validates :open_token, length: { is: 1 }
  validates :close_token, length: { is: 1 }

  def grade_mean
    return 0.0 if self.interpreter_grades.count == 0
    self.interpreter_grades.sum(:grade) / self.interpreter_grades.count
  end

  def functions_ordered
    self.functions.order(position: :asc)
  end

  def comments_top
    self.interpreter_comments.sort_by{|e| e.votes.where(positive: false).count-e.votes.where(positive: true).count}
  end
end
