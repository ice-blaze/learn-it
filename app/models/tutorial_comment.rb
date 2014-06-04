class TutorialComment < ActiveRecord::Base
  belongs_to :tutorial
  belongs_to :user

  has_many :tutorial_comment_votes
  has_many :users, through: :tutorial_comment_votes

  def path
    self.tutorial
  end

  def title
    self.content
  end

  def votes
    self.tutorial_comment_votes
  end
end
