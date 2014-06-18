class Part < ActiveRecord::Base
  has_many :part_comments, inverse_of: :part, dependent: :delete_all
  has_many :done_parts, inverse_of: :part, dependent: :delete_all
  has_many :part_votes, inverse_of: :part, dependent: :delete_all
  belongs_to :tutorial

  validates :title, :content, :signature, :tutorial, :position, presence: true

  def path
    [self.tutorial,self]
  end

  def votes
    self.part_votes
  end
end
