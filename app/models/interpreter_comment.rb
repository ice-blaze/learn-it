class InterpreterComment < ActiveRecord::Base
  belongs_to :interpreter
  belongs_to :user
end
