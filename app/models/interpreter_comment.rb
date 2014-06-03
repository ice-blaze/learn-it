class InterpreterComment < ActiveRecord::Base
  belongs_to :interpreter
  belongs_to :user

  has_many :interpreter_comment_votes
  has_many :users, through: :interpreter_comment_votes

  def parent_path
    self.interpreter
  end

  def votes
    self.interpreter_comment_votes
  end
end
