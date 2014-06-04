class FunctionVote < ActiveRecord::Base
  belongs_to :user
  belongs_to :function

  validates_uniqueness_of :user, :scope => :function
end
