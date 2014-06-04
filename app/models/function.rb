class Function < ActiveRecord::Base
  has_many :function_comments, inverse_of: :function
  has_many :function_votes, inverse_of: :function
  belongs_to :interpreter

  validates :name, :regex, :content, :interpreter, presence: true

  def path
    [self.interpreter,self]
  end

  def title
    self.name
  end

  def votes
    self.function_votes
  end
end
