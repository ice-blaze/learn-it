class TutorialGradesController < ApplicationController
  before_action :authenticate_user!

  def create
    #if vote with actual user exist, only update
    @tutorial = Tutorial.find(params[:tutorial_id])
    @grade = @tutorial.tutorial_grades.where(:user_id => current_user.id).first

    if @grade.blank?
      @grade = TutorialGrade.new
      @grade.user = current_user
      @grade.tutorial = @tutorial
    end

    @grade.grade = grade_params[:grade]

    if @grade.save
      redirect_to @tutorial
    else
      redirect_to @tutorial, :flash => { :info => 'Grade failed, value should be between 1 and 10 !' }
    end
  end

  def update
  end

  def destroy
  end

  private
  def grade_params
    params.require(:tutorial_grade).permit(:grade)
  end
end
