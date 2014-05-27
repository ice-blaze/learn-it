class TutorialComment < ActiveRecord::Base
  belongs_to :tutorial
  belongs_to :user
end
