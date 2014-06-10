class Tutorial < ActiveRecord::Base
  has_many :tutorial_comments, inverse_of: :tutorial, dependent: :delete_all
  has_many :tutorial_grades, inverse_of: :tutorial, dependent: :delete_all
  has_many :parts, inverse_of: :tutorial, dependent: :delete_all
  belongs_to :user
  belongs_to :interpreter

  validates :title, :description, :user, :interpreter, presence: true
  validates :is_finish, :inclusion => {:in => [true, false]}

  def grade_mean
    return 0.0 if self.tutorial_grades.count == 0
    self.tutorial_grades.sum(:grade) / self.tutorial_grades.count
  end

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
