class Tutorial < ActiveRecord::Base
  has_many :tutorial_comments, inverse_of: :tutorial
  has_many :grade_tutorials
  has_many :parts, inverse_of: :tutorial
  belongs_to :user
  belongs_to :interpreter

  validates :title, :description, :user, :interpreter, presence: true
  validates :is_finish, :inclusion => {:in => [true, false]}
end
