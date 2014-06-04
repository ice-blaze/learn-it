class TutorialGrade < ActiveRecord::Base
  belongs_to :tutorial
  belongs_to :user

  validates_uniqueness_of :user, :scope => :tutorial

  validates :grade,:user,:tutorial, presence: true
end
