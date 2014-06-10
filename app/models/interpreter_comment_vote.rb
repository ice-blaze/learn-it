class InterpreterCommentVote < ActiveRecord::Base
  belongs_to :user
  belongs_to :interpreter_comment

  validates_uniqueness_of :user, scope: :interpreter_comment

  validates :user, :interpreter_comment, presence: true
  validates :positive, inclusion: [true, false]
end
