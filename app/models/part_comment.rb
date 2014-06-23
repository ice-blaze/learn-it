class PartComment < ActiveRecord::Base
  belongs_to :part
  belongs_to :user

  has_many :part_comment_votes, dependent: :delete_all
  has_many :users, through: :part_comment_votes

  validates :content, :like, :dislike, :user, :part, presence: true

  def path
    [self.parent,self.part]
  end

  def parent
    self.part.tutorial
  end

  def title
    self.content
  end

  def votes
    self.part_comment_votes
  end

  def positive
    self.votes.where(positive: true).count
  end

  def negative
    self.votes.where(positive: false).count
  end
end
