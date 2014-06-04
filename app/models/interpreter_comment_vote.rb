class InterpreterCommentVote < ActiveRecord::Base
  belongs_to :user
  belongs_to :interpreter_comment

  validates_uniqueness_of :user, :scope => :interpreter_comment

  validates :user, :interpreter_comment, :positive, presence: true
end
