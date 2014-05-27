class Function < ActiveRecord::Base
  has_many :function_comments, inverse_of: :function
  belongs_to :interpreter

  validates :name, :regex, :content, :interpreter, presence: true
end
