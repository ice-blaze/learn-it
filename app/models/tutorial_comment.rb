class TutorialComment < ActiveRecord::Base
  belongs_to :tutorial
  belongs_to :user

  has_many :tutorial_comment_votes, dependent: :delete_all
  has_many :users, through: :tutorial_comment_votes

  validates :content, :like, :dislike, :user, :tutorial, presence: true

  def path
    [self.parent]
  end

  def parent
    self.tutorial
  end

  def title
    self.content
  end

  def votes
    self.tutorial_comment_votes
  end

  def positive
    self.votes.where(positive: true).count
  end

  def negative
    self.votes.where(positive: false).count
  end
end
