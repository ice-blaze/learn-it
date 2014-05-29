class DonePart < ActiveRecord::Base
  belongs_to :user
  belongs_to :part

  validates_uniqueness_of :user, :scope => :part
end
