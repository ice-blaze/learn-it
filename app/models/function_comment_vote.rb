class FunctionCommentVote < ActiveRecord::Base
  belongs_to :user
  belongs_to :function_comment

  validates_uniqueness_of :user, :scope => :function_comment

  validates :user, :function_comment, presence: true
  validates :positive, inclusion: [true, false]
end
