class Part < ActiveRecord::Base
  has_many :comment_parts
  belongs_to :tutorial

  validates :title, :content, :signature, :tutorial, presence: true
end
