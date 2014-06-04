class InterpreterComment < ActiveRecord::Base
  belongs_to :interpreter
  belongs_to :user

  has_many :interpreter_comment_votes
  has_many :users, through: :interpreter_comment_votes

  def path
    self.interpreter
  end

  def title
    self.content
  end

  def votes
    self.interpreter_comment_votes
  end
end
