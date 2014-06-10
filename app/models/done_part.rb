class DonePart < ActiveRecord::Base
  belongs_to :user
  belongs_to :part

  validates_uniqueness_of :user, scope: :part

  validates :user, :part, presence: true
end
