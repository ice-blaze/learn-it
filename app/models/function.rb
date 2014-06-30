class Function < ActiveRecord::Base
  has_many :function_comments, inverse_of: :function, dependent: :delete_all
  has_many :function_votes, inverse_of: :function, dependent: :delete_all
  belongs_to :interpreter

  validates :regex, :content, :interpreter, :position, presence: true
  validates :name, format: { with: /\A[a-zA-Z_][a-zA-Z_0-9?=!]*\z/,
                                    message: 'Only allows ruby function chars '}
  validates :loop, inclusion: [true, false]

  def path
    [self.parent,self]
  end

  def parent
    self.interpreter
  end

  def title
    self.name
  end

  def votes
    self.function_votes
  end

  def positive
    self.votes.where(positive: true).count
  end

  def negative
    self.votes.where(positive: false).count
  end
end
