class PartVote < ActiveRecord::Base
  belongs_to :user
  belongs_to :part

  validates_uniqueness_of :user, scope: :part

  validates :user, :part, presence: true
  validates :positive, inclusion: [true, false]
end
