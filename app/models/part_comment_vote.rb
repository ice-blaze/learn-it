class PartCommentVote < ActiveRecord::Base
  belongs_to :user
  belongs_to :part_comment

  validates_uniqueness_of :user, scope: :part_comment

  validates :user, :part_comment, presence: true
  validates :positive, inclusion: [true, false]
end
