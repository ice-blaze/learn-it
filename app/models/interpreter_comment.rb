class InterpreterComment < ActiveRecord::Base
  belongs_to :interpreter
  belongs_to :user

  has_many :interpreter_comment_votes, dependent: :delete_all
  has_many :users, through: :interpreter_comment_votes

  validates :content, :like, :dislike, :interpreter, :user, presence: true

  def path
    [self.parent]
  end

  def parent
    self.interpreter
  end

  def title
    self.content
  end

  def votes
    self.interpreter_comment_votes
  end

  def positive
    self.votes.where(positive: true).count
  end

  def negative
    self.votes.where(positive: false).count
  end
end
