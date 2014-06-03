class FunctionComment < ActiveRecord::Base
  belongs_to :function
  belongs_to :user

  has_many :function_comment_votes
  has_many :users, through: :function_comment_votes

  def parent_path
    [self.function.interpreter,self.function]
  end
end
