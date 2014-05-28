class PartCommentVote < ActiveRecord::Base
  belongs_to :user
  belongs_to :part_comment

  validates_uniqueness_of :user, :scope => :part_comment
end
