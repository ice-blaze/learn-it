class Function < ActiveRecord::Base
  has_many :function_comments, inverse_of: :function
  has_many :function_votes, inverse_of: :function
  belongs_to :interpreter

  validates :regex, :content, :interpreter, presence: true
  validates :name, format: { with: /\A[a-zA-Z_][a-zA-Z_0-9?=!]*\z/,
                                    message: 'Only allows ruby function chars '}

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
