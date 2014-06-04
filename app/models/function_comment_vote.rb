class FunctionCommentVote < ActiveRecord::Base
  belongs_to :user
  belongs_to :function_comment

  validates_uniqueness_of :user, :scope => :function_comment

  validates :user, :function_comment, :positive, presence: true
end
