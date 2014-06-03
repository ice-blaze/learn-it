class Tutorial < ActiveRecord::Base
  has_many :tutorial_comments, inverse_of: :tutorial
  has_many :tutorial_grades, inverse_of: :tutorial
  has_many :parts, inverse_of: :tutorial
  belongs_to :user
  belongs_to :interpreter

  validates :title, :description, :user, :interpreter, presence: true
  validates :is_finish, :inclusion => {:in => [true, false]}

  def grade_mean
    self.tutorial_grades.sum(:grade) / self.tutorial_grades.count
  end

  #return true if fully finished
  #       false if partialy finished
  #       nil if never touched
  def done(user)
    parts = self.parts
    count = 0
    finished = true
    parts.each do |p|
      count += 1
      finished = false unless user.done_parts.exists?(part_id: p.id)
    end
    return nil if count == 0
    finished
  end
end
