class PartComment < ActiveRecord::Base
  belongs_to :part
  belongs_to :user

  has_many :part_comment_votes
  has_many :users, through: :part_comment_votes

  validates :content, :like, :dislike, :user, :part, presence: true

  def path
    [self.part.tutorial,self.part]
  end

  def title
    self.content
  end

  def votes
    self.part_comment_votes
  end
end
