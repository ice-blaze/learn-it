class InterpreterGrade < ActiveRecord::Base
  belongs_to :interpreter
  belongs_to :user

  validates_uniqueness_of :user, scope: :interpreter
  validates :grade, inclusion: 1..10
end
