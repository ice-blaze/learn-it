class Function < ActiveRecord::Base
  has_many :comment_functions
  belongs_to :interpreter

  validates :name, :regex, :content, :interpreter, presence: true
end
