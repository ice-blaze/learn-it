class Part < ActiveRecord::Base
  has_many :part_comments, inverse_of: :part
  has_many :done_parts, inverse_of: :part
  belongs_to :tutorial

  validates :title, :content, :signature, :tutorial, presence: true
end
