class PartComment < ActiveRecord::Base
  belongs_to :part
  belongs_to :user

  has_many :part_comment_votes
  has_many :users, through: :part_comment_votes
end
