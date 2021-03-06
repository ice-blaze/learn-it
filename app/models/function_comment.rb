class FunctionComment < ActiveRecord::Base
  belongs_to :function
  belongs_to :user

  has_many :function_comment_votes, dependent: :delete_all
  has_many :users, through: :function_comment_votes

  validates :content,:like,:dislike,:function,:user, presence: true

  def path
    [self.parent,self.function]
  end

  def parent
    self.function.interpreter
  end

  def title
    self.content
  end

  def votes
    self.function_comment_votes
  end

  def positive
    self.votes.where(positive: true).count
  end

  def negative
    self.votes.where(positive: false).count
  end
end
