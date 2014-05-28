class TutorialCommentVote < ActiveRecord::Base
  belongs_to :user
  belongs_to :tutorial_comment

  validates_uniqueness_of :user, :scope => :tutorial_comment
end

