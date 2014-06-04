class Part < ActiveRecord::Base
  has_many :part_comments, inverse_of: :part
  has_many :done_parts, inverse_of: :part
  has_many :part_votes, inverse_of: :part
  belongs_to :tutorial

  validates :title, :content, :signature, :tutorial, presence: true

  def path
    [self.tutorial,self]
  end

  def votes
    self.part_votes
  end
end
